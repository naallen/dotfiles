#!/bin/zsh
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"
if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi
source /etc/X11/xinit/xinitrc.d/30-dbus
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel'

/usr/lib/systemd/systemd --user &

xrdb -merge ~/.Xresources
xflux -l 43.467079 -g -79.714499 &
dunst -conf ~/.dunstrc &
synapse -s &
numlockx &
compton --backend glx --paint-on-overlay --vsync opengl-swc &
hsetroot -fill ~/Pictures/wallpaper.png &
~/.bin/idle.sh 45000 60000 &
udiskie -n -a -s &
synclient TouchpadOff=1 &
~/.bin/lightsOn.sh 50 &
trackpoint_apply &
#sxhkd &
#panel &

exec i3
#exec /home/nick/Workshop/openFrameworks/apps/hax/dex-ui/bin/dex-ui 
