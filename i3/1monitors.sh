#!/bin/sh
xrandr --output eDP-1 --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output DP-2 --off --output DP-1-0 --off --output DP-1-1 --off --output HDMI-1-0 --off

feh --bg-fill --no-fehbg ~/Pictures/1.jpg

sleep 5

rs-polybar
