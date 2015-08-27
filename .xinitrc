#!/bin/zsh
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
source /etc/X11/xinit/xinitrc.d/30-dbus.sh
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.95

/usr/lib/systemd/systemd --user &

xrdb -merge ~/.Xresources
xflux -l 43.467079 -g -79.714499 &
dunst -conf ~/.dunstrc &
synapse -s &
numlockx &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
.wallpaper/update.sh /home/nick/.wallpaper
~/.bin/idle.sh 45000 60000 &
udiskie -n -a -s &
synclient TouchpadOff=1 &
~/.bin/lightsOn.sh 50 &
~/.bin/trackpoint_apply &
#sxhkd &
#panel &

exec i3
#exec /home/nick/Workshop/openFrameworks/apps/hax/dex-ui/bin/dex-ui 
