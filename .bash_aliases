# some more ls aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls --color=auto -CF'
alias ll='l -l'
alias lh='ll -h'
alias la='lh -a'
#alias lan='la --sort=time| head -n 20'
alias md='mkdir -pv'
alias chmx='chmod +x'
alias xevKey="xev | grep -A2 --line-buffered '^KeyRelease' | sed -n '/keycode /s/^.*keycode \([0-9]*\).* (.*, \(.*\)).*$/\1 \2/p'"
alias duh='du -sch'
alias cpuh='su -c " cpupower frequency-set -g performance; cpupower frequency-set -u 8000000" '
alias cpul='su -c " cpupower frequency-set -g powersave; cpupower frequency-set -u 800000" '
alias iftopw='iftop -i wlo1 -B'
alias tarc='tar czvf'
alias tarx='tar xzvf'
alias info='info --vi-keys'
alias c='clear'
alias e='exit'
alias pcalc='pcalc -n'
alias tmc='pgrep transmission || (transmission-daemon -e /tmp/translog; sleep 1); transmission-remote-cli'
alias fest='festival --pipe --tts'
alias jtalk='tr "\n" " "| open_jtalk -x /usr/share/open-jtalk/dic/ -m /usr/share/open-jtalk/mei_normal.htsvoice -r 1.6 -ow /tmp/t.wav ; mpv --speed 1 /tmp/t.wav'
alias v='vim'
alias p='pgrep mpd || mpd; ncmpcpp'
alias b='cd ..;'
alias ta='tmux attach-session'
alias m='man'
alias psg='ps aux| grep '
alias x='startx'
alias k='pkill '
alias kk='killall -9 -r '
alias kkp='kill -9 '
alias 1080p='fbset -xres 1920 -yres 1080 -a'
alias frec='ffmpeg -f x11grab -r 25 -s 1920x1080 -i :0.0 -c:v libx264 -s 1280x720 rec$(date +%Y%m%d_%H-%M-%S).mkv'
alias g='grep '
alias d='~/bin/diary.sh '
alias jk='dbus-launch jackd -dalsa -dhw:PCH -p256 -r48000 & '
alias apm='aplaymidi -p14'
alias mm='multimidicast &> /dev/null &'
alias susp='echo -e "#`date +%s`\nsusp" >> $HOME/.bash_history; systemctl suspend'
alias hib='echo -e "#`date +%s`\nhib" >> $HOME/.bash_history; systemctl hibernate'
alias axel='axel --alternate'
alias syua='yaourt -Syua --devel --noconfirm'
alias syu='yaourt -Syua --noconfirm'
alias ak='anki'
alias cm='chromium'
alias tcm='chromium --proxy-server="socks://localhost:9050"'
alias ff='firefox'
alias yd='youtube-dl -f bestvideo+bestaudio  --write-sub --all-subs'
alias yda='youtube-dl -f bestaudio  --write-sub --all-subs'
alias nicodl='nicovideo-dl -u quillkiragimmy@gmail.com -p $(cat ~/passwd)'
alias am='alsamixer'
#alias lsusb='lsusb -t'
alias vm='VirtualBox --comment win7_32 --startvm 215f934a-c49e-4788-9dcc-4b5ec1c3f09c --no-startvm-errormsgbox'
alias pc='perlconsole'
#alias rcp='rsync -avP '
alias rcp='rsync -a --info=progress2 '
alias wim='ip link set wlo1 down; iwconfig wlo1 mode monitor; ip link set wlo1 up'
alias wid='ip link set wlo1 down; iwconfig wlo1 mode managed; ip link set wlo1 up'

alias wbl='export WINEDLLOVERRIDES="d3dx9_43=b; dsound=b"'
alias miso='mount -t iso9660 -o loop'

alias sayo='org_dir=`pwd`; cd /fileArch/adieu/; ja wine AVG*; cd $org_dir'
alias civ='cd /winh*/Pro*86*/R.*/Sid*/; export WINEDLLOVERRIDES="dsound=b"; gpu wine ./CivilizationV &> /dev/null; export WINEDLLOVERRIDES="dsound=n"; cd'
alias pt='cd /fileArch/pt2; pkill compton; gpu wine ./portal2 &> /dev/null; compton &> /dev/null & cd'
alias sg='export WINEDLLOVERRIDES="dsound=b"; cd /fileArch/sg; pkill compton; gpu ja wine ST*exe ; cd; compton ;export WINEDLLOVERRIDES="dsound=n"; '
alias xv='cd /fileArch/kara2; ja wine ./kara2.exe &> /dev/null; cd'
alias fw='cd /fileArch/FL*; ja wine FLO*exe &> /dev/null; cd'
alias oozora='cd /fileArch/kononi/*; ja wine ./Adv*exe; cd'
alias wa='org=`pwd`; cd /fileArch/WH*; ja wine ./WA2.exe &> /dev/null & ./p.sh; cd $org'
alias lb='export WINEDLLOVERRIDES="d3dx9_43=b; dsound=b"; cd /fileArch/limbo; gpu wine ./limbo; cd; export WINEDLLOVERRIDES="d3dx9_43=n; dsound=n"  '
alias vr=' cd /fileArch/voiceroid/; ja wine VOICEROID; '
alias vrmk='cd /fileArch/voiceroid_maki/AHS/Voiceroid+/tamiyasu; ja wine ./VOICEROID; cd'
alias rsd='cd /fileArch/Risshiden; gpu ja wine ./NOBU14SR_JP &>/dev/null; cd'
#alias cc='cd fileArch/cc/CRO*/; ja wine ./CRO*exe &  cd'
alias ns='~/bin/news.sh'
alias subahi='ja wine /fileArch/素晴らしき日々/BGI'
alias ab='ja wine /fileArch/Key/Ang*/Sig*'
alias kao='ja wine /fileArch/ROOT/顔のない月*/NSMoon*'
alias lf2='cd /fileArch/Little*/LF*/; wine lf2.exe'
alias wespeak='wine /fileArch/.wine/drive_c/*x86*/*Speech*SDK*/Bin/TTSApp.exe'
alias rim='wine /fileArch/RimWorld*/RimWorldWin.exe'
alias ssp='adb pull /sdcard/Android/data/com.dendenfactory.ukagakaforandroid/files/ghost/miyako/ghost/master/satori_savedata.txt /fileArch/ssp/ghost/miyako_0/ghost/master/ ;ja wine /fileArch/ssp/ssp; adb push /fileArch/ssp/ghost/miyako_0/ghost/master/satori_savedata.txt /sdcard/Android/data/com.dendenfactory.ukagakaforandroid/files/ghost/miyako/ghost/master/satori_savedata.txt' 
alias lo='libreoffice '
alias vq='ja wine /fileArch/VQ*/Game.exe'
alias asairo='cd /fileArch/asairo/; ja wine asairo.exe'

#alias rm='mkdir /tmp/recycle 2>/dev/null; mv -t /tmp/recycle/ -f'
#alias rmrm='/bin/rm /tmp/recycle -rf'

alias hid='dfu-programmer atmega16u2 erase; dfu-programmer atmega16u2 flash /home/patricius/arduino_midi.hex; dfu-programmer atmega16u2 reset'
alias mega='dfu-programmer atmega16u2 erase; dfu-programmer atmega16u2 flash /home/patricius/usbserial_mega_16u2.hex --suppress-bootloader-mem; dfu-programmer atmega16u2 reset'
