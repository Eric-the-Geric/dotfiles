#!/bin/bash

xrandr && xrandr --output HDMI-1 --mode 1920x1080 --left-of DP-2 --output DP-2 --primary --mode 1920x1080 -r 144
nitrogen --restore
