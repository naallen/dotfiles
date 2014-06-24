#!/bin/sh
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
source /etc/X11/xinit/xinitrc.d/30-dbus

/usr/lib/systemd/systemd --user &

xrdb -merge ~/.Xresources
xflux -l 43.467079 -g -79.714499 &
twmnd &
synapse -s &
numlockx &
thunar --daemon &
unclutter -idle 1 &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
hsetroot -fill ~/Pictures/Wallpapers/Reflection_Wallpaper_2_by_all_one_line.png &
xset s 60 60 &
udiskie &
synclient TouchpadOff=1 &
~/.bin/lightsOn.sh &
trackpoint_apply &

exec i3 
