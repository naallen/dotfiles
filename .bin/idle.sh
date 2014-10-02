#!/bin/bash

idleone=false
idletwo=false
idleStageOne=${1:-30000}
idleStageTwo=${2:-60000}
pollingRate=2
homeNetwork=$(cat ~/.homenetwork)

while true; do
    idleTimeMillis=$(~/.bin/getIdle)
    echo $idleTimeMillis  # just for debug purposes.

    if [[ $idleTimeMillis -gt $idleStageOne && $idleone = false  ]] ; then
        echo "idle stage one"
        echo "$(xbacklight -get) + 1" | bc > ~/.backlight
        xbacklight -set 1 -time 3000 -steps 30 & 
        idleone=true
        pollingRate=0.25
    fi

    if [[ $idleTimeMillis -gt $idleStageTwo && $idletwo = false  ]] ; then
        echo "idle stage two"
        xbacklight -set 0 
        xset dpms force off 
        [ "$(iwgetid -r)" -ne "$homeNetwork" ] && fuzzylock
        idletwo=true
        pollingRate=1
    fi

    if [[ $idleTimeMillis -lt $idleStageTwo && $idletwo = true ]] || [[ $idleTimeMillis -lt $idleStageOne && $idleone = true ]] ; then
        echo "idle off"
        xset dpms force on
        killall xbacklight
        xbacklight -set $(cat ~/.backlight)
        echo $(xbacklight -get)
        rm ~/.backlight
        idleone=false
        idletwo=false
        pollingRate=2
    fi

    sleep $pollingRate   # polling interval

done
