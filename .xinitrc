#!/usr/bin/bash

#from /etc/X11/xinit/xinitrc

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

$HOME/script/boot/monitor.sh
$HOME/bin/de_initer.sh

feh --bg-fill $HOME/.backgroundImg.png 
xsetroot -cursor_name left_ptr 

#setxkbmap -option caps:swapescape 
#setxkbmap -option 'ctrl:nocaps' 
#setxkbmap -option 'terminate:ctrl_alt_bksp'

xbindkeys &
dunst &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xset -b 

numlockx &
xbacklight = 13 &

compton --dbus &
conky -q &

#xmobar &
#cellwriter &
#unclutter -root -grab &
hidcur 3 &

#mpd &

sleep 1; $HOME/script/boot/daemon.sh &

xrandr --setprovideroffloadsink radeon Intel

#i3

$HOME/bin/eye_rest.sh &


xmonad 
