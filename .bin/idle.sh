#!/bin/bash

idleone=false
idleStageOne=${1:-30000}
pollingRate=2

while true; do
    idleTimeMillis=$(xprintidle)
    echo $idleTimeMillis  # just for debug purposes.

    if [[ $idleTimeMillis -gt $idleStageOne && $idleone = false && ! -a ~/.dimlock ]] ; then
            echo "idle stage one"
            cat /sys/class/backlight/intel_backlight/brightness > ~/.backlight
            echo "0" > /sys/class/backlight/intel_backlight/brightness
            idleone=true
            pollingRate=0.25
        fi

        if [[ $idleTimeMillis -lt $idleStageOne && $idleone = true ]] ; then
            echo "idle off"
            cat ~/.backlight > /sys/class/backlight/intel_backlight/brightness 
            rm ~/.backlight
            idleone=false
            pollingRate=2
        fi

    sleep $pollingRate   # polling interval

done
