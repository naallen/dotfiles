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
export WINEARCH=win32
export WINEPREFIX=~/.wine32

xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation" 1
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Button" 2
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Timeout" 200
xinput set-prop "TPPS/2 IBM TrackPoint" "Evdev Wheel Emulation Axes" 6 7 4 5
xinput set-prop "TPPS/2 IBM TrackPoint" "Device Accel Constant Deceleration" 0.95

/usr/lib/systemd/systemd --user &

xrandr --output LVDS1 --auto --output VGA1 --off
xhost + &
xset s 60 60 &
xrdb -merge ~/.Xresources &
udiskie -N -a -s &
~/.bin/lightsOn.sh 50 &
sudo /bin/trackpoint_apply.sh &
.wallpaper/update.sh &
lxsession &
systemctl --user start compton &
synapse -s &
systemctl --user start dunst &

exec i3
