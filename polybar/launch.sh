#!/usr/bin/env bash
set -euo pipefail

polybar_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
repo_dir=$(dirname "$polybar_dir")
host_file="$repo_dir/.local-host"
if [[ -f $host_file ]]; then
    host=$(<"$host_file")
    case "$host" in
        pop|arch) set -a; source "$repo_dir/hosts/$host/polybar.env"; set +a ;;
        *) printf 'Unknown host profile: %s\n' "$host" >&2; exit 1 ;;
    esac
fi

if [[ -z ${POLYBAR_MONITOR:-} ]]; then
    POLYBAR_MONITOR=$(polybar --list-monitors | awk '/primary/ { sub(/:.*/, "", $1); print $1; exit }')
    if [[ -z $POLYBAR_MONITOR ]]; then
        POLYBAR_MONITOR=$(polybar --list-monitors | awk 'NR == 1 { sub(/:.*/, "", $1); print $1 }')
    fi
fi
[[ -n $POLYBAR_MONITOR ]] || { printf 'No display found for Polybar.\n' >&2; exit 1; }
export POLYBAR_MONITOR

# colourme writes the i3 palette; use its focused border color for both bars.
i3_config="$repo_dir/i3/config"
border_color=$(awk '$1 == "set" && $2 == "$green" { color = $3 } END { print color }' "$i3_config")
[[ $border_color =~ ^#[[:xdigit:]]{6}$ ]] || {
    printf 'Could not read the focused border color from %s\n' "$i3_config" >&2
    exit 1
}
export POLYBAR_I3_BORDER="$border_color"

python3 "$polybar_dir/sync-rofi-colors.py" "$polybar_dir/config.ini" "$repo_dir/rofi/colourme.rasi"

config="$polybar_dir/config.ini"
version=$(polybar --version | awk '{ print $2 }')
IFS=. read -r major minor _ <<< "$version"
if (( major < 3 || (major == 3 && minor < 7) )); then
    config="${XDG_CACHE_HOME:-$HOME/.cache}/polybar/config-legacy.ini"
    python3 "$polybar_dir/render-legacy.py" "$polybar_dir/config.ini" "$config"
fi

polybar-msg cmd quit >/dev/null 2>&1 || true
printf '%s\n' '---' | tee -a /tmp/polybar1.log /tmp/polybar2.log >/dev/null
polybar --config="$config" mybar 2>&1 | tee -a /tmp/polybar1.log & disown
polybar --config="$config" time_s1 2>&1 | tee -a /tmp/polybar2.log & disown
