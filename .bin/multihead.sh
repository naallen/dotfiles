#!/bin/bash
set -x 
xhost local:nick
export DISPLAY=:0.0

if ! xrandr -q | grep -q "VGA1 connected"; then
  exit 1
fi

if xrandr -q | grep -q "LVDS1 connected 1280x800"; then
  xrandr --output LVDS1 --off --output VGA1 --mode 1920x1080 --right-of LVDS1
  if ! pgrep synergyc >/dev/null 2>&1; then
    synergyc -f 192.168.221.110
  fi
else 
  xrandr --output LVDS1 --auto --output VGA1 --off
  killall synergyc
fi
