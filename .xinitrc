#!/bin/sh
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
source /etc/X11/xinit/xinitrc.d/30-dbus

xrdb -merge ~/.Xresources
redshift & 
twmnd &
synapse -s &
numlockx &
thunar --daemon &
compton -cCb --vsync opengl &
sh ~/.fehbg &

exec i3 

