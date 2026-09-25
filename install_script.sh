#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")
dry_run=false
if [[ ${1:-} == --dry-run ]]; then
    dry_run=true
    shift
fi
host=${1:-}
case "$host" in
    pop|arch) ;;
    *) printf 'Usage: %s [--dry-run] {pop|arch}\n' "$0" >&2; exit 2 ;;
esac

sources=(.bashrc .tmux.conf nvim i3 alacritty polybar rofi bin)
targets=(
    "$HOME/.bashrc" "$HOME/.tmux.conf"
    "$HOME/.config/nvim" "$HOME/.config/i3" "$HOME/.config/alacritty"
    "$HOME/.config/polybar" "$HOME/.config/rofi" "$HOME/bin"
)

# Check every destination before replacing any links. Regular files and
# directories need to be moved aside deliberately by their owner.
for target in "${targets[@]}"; do
    if [[ -e $target && ! -L $target ]]; then
        printf 'Refusing to replace existing %s\n' "$target" >&2
        exit 1
    fi
done
if [[ -e $repo_dir/i3/host.conf && ! -L $repo_dir/i3/host.conf ]]; then
    printf 'Refusing to replace existing %s\n' "$repo_dir/i3/host.conf" >&2
    exit 1
fi
if [[ -e $repo_dir/alacritty/alacritty.toml && ! -L $repo_dir/alacritty/alacritty.toml ]]; then
    printf 'Refusing to replace existing %s\n' "$repo_dir/alacritty/alacritty.toml" >&2
    exit 1
fi

for index in "${!sources[@]}"; do
    source="$repo_dir/${sources[$index]}"
    target="${targets[$index]}"
    if $dry_run; then
        printf 'Would link %s -> %s\n' "$target" "$source"
    else
        mkdir -p "$(dirname "$target")"
        ln -sfn "$source" "$target"
    fi
done

if ! $dry_run; then
    "$repo_dir/bin/select-host" "$host"
fi
