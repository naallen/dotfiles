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
redshift & 
twmnd &
synapse -s &
numlockx &
thunar --daemon &
#compton -cCb --backend glx --paint-on-overlay --vsync opengl-swc &
hsetroot -fill ~/Pictures/Wallpapers/Reflection_Wallpaper_2_by_all_one_line.png &
xfce4-power-manager &

exec i3 

