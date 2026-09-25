#!/usr/bin/env bash
set -euo pipefail

xrandr \
  --output DisplayPort-0 --primary --mode 1920x1080 --rate 144 --pos 1920x0 \
  --output HDMI-A-1 --mode 1920x1080 --rate 60 --pos 0x0
