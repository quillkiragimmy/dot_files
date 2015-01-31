$HOME/script/boot/monitor.sh
$HOME/bin/de_initer.sh

feh --bg-fill $HOME/.backgroundImg.png 
xsetroot -cursor_name left_ptr 

#setxkbmap -option caps:swapescape 
#setxkbmap -option 'ctrl:nocaps' 
#setxkbmap -option 'terminate:ctrl_alt_bksp'

xbindkeys &

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
xset -b 

numlockx &
xbacklight = 13 &

compton &
conky &

#xmobar &
#cellwriter &
#unclutter -root -grab &
hidcur 3 &

#mpd &

sleep 1; $HOME/script/boot/daemon.sh &

xrandr --setprovideroffloadsink radeon Intel


xmonad 
