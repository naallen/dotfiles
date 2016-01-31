#!/bin/bash
# This is a script that toggles rotation of the screen through xrandr,
# and also toggles rotation of the stylus, eraser and cursor through xsetwacom

# Check orientation
orientation=`/usr/bin/xrandr --verbose -q | grep LVDS | awk '{print $5}'`
# Rotate the screen and stylus, eraser and cursor, according to your preferences.
if [ "$1" = "normal" ]; then
    if [ "$orientation" = "normal" ]; then
    /usr/bin/xrandr --output LVDS1 --rotate right 
    /usr/bin/xsetwacom set 12 Rotate cw
    /usr/bin/xsetwacom set 13 Rotate cw
    else
    /usr/bin/xrandr --output LVDS1 --rotate normal
    /usr/bin/xsetwacom set 12 Rotate none
    /usr/bin/xsetwacom set 13 Rotate none
    fi
elif [ "$1" = "invert" ]; then
    if [ "$orientation" = "normal" ]; then
    /usr/bin/xrandr --output LVDS1 --rotate inverted
    /usr/bin/xsetwacom set 12 Rotate half
    /usr/bin/xsetwacom set 13 Rotate half
    elif [ "$orientation" = "inverted" ]; then
    /usr/bin/xrandr --output LVDS1 --rotate normal
    /usr/bin/xsetwacom set 12 Rotate none
    /usr/bin/xsetwacom set 13 Rotate none
    elif [ "$orientation" = "right" ]; then
    /usr/bin/xrandr --output LVDS1 --rotate left
    /usr/bin/xsetwacom set 12 Rotate cw
    /usr/bin/xsetwacom set 13 Rotate cw
    elif [ "$orientation" = "left" ]; then
    /usr/bin/xrandr --output LVDS1 --rotate right
    /usr/bin/xsetwacom set 12 Rotate ccw
    /usr/bin/xsetwacom set 13 Rotate ccw
    fi
fi


