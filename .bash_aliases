# some more ls aliases
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias l='ls --color=auto -CF'
alias ll='l -l'
alias lh='ll -h'
alias la='lh -a'
alias lan='la --sort=time| head '
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
alias p='ncmpcpp'
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
alias w='words '
alias d='~/bin/diary.sh '
alias jk='dbus-launch jackd -dalsa -dhw:PCH -p256 -r48000 & '
alias apm='aplaymidi -p14'
alias mm='multimidicast &> /dev/null &'
alias susp='systemctl suspend'
alias hib='systemctl hibernate'
alias axel='axel --alternate'
alias syua='yaourt -Syua --devel --noconfirm'
alias syu='yaourt -Syua --noconfirm'
alias ak='anki'
alias cm='chromium'
alias tcm='chromium --proxy-server="socks://localhost:9050"'
alias ff='firefox'
alias yd='youtube-dl -f bestvideo+bestaudio  --write-sub --all-subs'
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

alias civ='cd /winh*/Pro*86*/R.*/Sid*/; export WINEDLLOVERRIDES="dsound=b"; gpu wine ./CivilizationV &> /dev/null; export WINEDLLOVERRIDES="dsound=n"; cd'
alias pt='cd /fileArch/pt2; pkill compton; gpu wine portal2 &> /dev/null; compton &> /dev/null & cd'
alias sg='export WINEDLLOVERRIDES="dsound=b"; cd /fileArch/sg; pkill compton; gpu ja wine ST*exe ; cd; compton ;export WINEDLLOVERRIDES="dsound=n"; '
alias xv='cd /fileArch/kara2; ja wine kara2.exe &> /dev/null; cd'
alias fw='cd /fileArch/FL*; ja wine FLO*exe &> /dev/null; cd'
alias wa='cd /fileArch/WH*; ja wine WA2.exe &> /dev/null & ./p.sh'
alias lb='export WINEDLLOVERRIDES="d3dx9_43=b; dsound=b"; cd /fileArch/limbo; gpu wine limbo; cd; export WINEDLLOVERRIDES="d3dx9_43=n; dsound=n"  '
alias vr='cd fileArch/voiceroid/; wine VOICEROID; cd'
alias ok='cd fileArch/onikin/; ja wine onikin &  cd'
alias cc='cd fileArch/CRO*/; ja wine CRO*exe &  cd'
alias ns='~/bin/news.sh'
alias subahi='ja wine /fileArch/素晴らしき日々/BGI'
alias ab='ja wine /fileArch/Key/Ang*/Sig*'

