#!/usr/bin/env bash

# Match i3's focused window border after colourme updates its palette.
i3_config="${HOME}/.config/i3/config"
border_color=$(awk '$1 == "set" && $2 == "$green" { color = $3 } END { print color }' "$i3_config")
if [[ ! $border_color =~ ^#[[:xdigit:]]{6}$ ]]; then
    printf 'Could not read the focused border color from %s\n' "$i3_config" >&2
    exit 1
fi
export POLYBAR_I3_BORDER="$border_color"

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use 
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
#killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar mybar 2>&1 | tee -a /tmp/polybar1.log & disown
polybar time_s1 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
