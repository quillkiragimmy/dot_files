#!/usr/bin/bash

sapi() {
	while read line; do 
		wine $HOME/bin/tts.exe -v 8 -f 1 "$line" &>/dev/null
	done
}

gpu() {
	DRI_PRIME=1 thread_submit=true "$@"
}

ja() {
LC_ALL=ja_JP.UTF-8 "$@"
}

ch() {
	LC_ALL=zh_TW.BIG5 "$@"
}

sch() {
	LC_ALL=zh_CN.GB2312 "$@"
}

gg(){
	if [ -z "$1" ]; then
		w3m http://www.google.com
	else
		w3m http://www.google.com/search?q=$(echo $@| tr ' ' '+')
	fi
}

n() {
	$EDITOR $HOME/notes/archnote.md
}

repeat() { 
	i=0; 
	while [ $i -lt $2 ]; do 
		echo -n "$1"
		(( i++ ))
	done 
	echo "" 
}


man() {
	env LESS_TERMCAP_mb=$(printf "\e[1;31m") \
		LESS_TERMCAP_md=$(printf "\e[1;31m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		man "$@"
}

gallop() {
	sec=$1
	[ -z "$sec" ] && sec=20
	echo "gallop for $sec secs."
	for ((i=0;i<8;i++)); do 
		while true; do 
			((j++))
		done & pid="$pid $!"
	done

	sleep $sec
	kill $pid
	pid=''
}


lott(){
	list=()
	while (( ${#list[*]} != $2 )); do 
		t=$(printf '%02d' $(( RANDOM % $1 )) )
		(echo ${list[*]}| grep -q "$t") || list+=( $t )
	done
	echo ${list[*]}
}


ren(){
	if [ $# == '0' ]; then
		echo "Usage: ren [-r <sed-regex>] [-h, --half] <file-list>"
	else
		half_width=''
		re=""

		count=0
		while (( $# != 0 )); do
			case "$1" in
				'-h'| '--half')
					half_width='yes'
					;;
				'-r')
					shift
					re=$1
					;;
				*)
					orig[count]=$1
					target[count]=$1
					[[ "$half_width" ]] && target[count]=$(echo ${orig[count]}| sed "y/：１２３４５６７８９０ー＝＿＋！＠＃♯＄％＾＆＊（）「」【】・、，。〜　？〟〝/:1234567890-=_+!@##$%^&*()[][].,,.~ ?\"\"/")
					[[ "$re" ]] && target[count]=$(echo "${target[count]}"| sed "$re")

					[ "$1" != "${target[count]}" ] && echo -e "\e[1;32m${target[count]}\e[0;35m <-- $1 \e[0m"
					(( count++ ))
					;;
			esac
			shift
		done
		echo "forementioned renames confirmed? (N/y)"
		read ny
		if [ "$ny" == 'y' ]; then
			for (( i=0; i<count; i++ )); do
				[ "${orig[i]}" != "${target[i]}" ] && mv -nv "${orig[i]}" "${target[i]}"
			done
		fi

	fi
}

xpath(){
	html=''
	while read line; do
		html+="$line"
	done
	echo -e "$html"| xmllint --html --htmlout --xpath "$1" - 2>/dev/null
}

alias halfchar='sed "y/１２３４５６７８９０ー＝＿＋！＠＃＄％＾＆＊（）「」【】・、，。〜　？/1234567890-=_+!@#$%^&*()[][].,,.~ ?/"'

gtalk(){

if [ "$1" == '' ]; then
	lang='en'
else
	lang="$1"
fi

while read line; do
	wget -q -U Mozilla -O /tmp/tts.mp3 "http://translate.google.com/translate_tts?ie=UTF-8&tl=$lang&q=$(echo $line| tr ' ' '+')"
	mpv --speed 1.3 /tmp/tts.mp3 &> /dev/null
done
}

pokeme(){
	while read msg; do
		notify-send "$(date)" "$msg"
	done
}

lv(){
	ls $1| gtalk
}

umt(){

	for i in $(df| grep $1| cut -d' ' -f1); do
		echo "unmounting $i"
		umount "$i"
	done

}

yg(){
	i=0
	while true; do
		mkdir $i && break
		(( i++ ))
	done
	cd $i
	you-get  $1 &
	cd ..
}

adb_get_package(){
	pack=$(adb shell pm list packages| grep $1| tail -n1|sed 's/package://g'|sed 's/\r//g')
	echo pack="$pack"
	path=$(adb shell pm path "$pack"|sed 's/package://g'|sed 's/\r//g')
	echo path=$path
	adb pull $path "$pack".apk

}

lan(){
	[ -z "$1" ] && key="." || key="$1"
	ls -alh --sort=time | egrep "$key"| head -n 20
}
