#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>

# Get Colors
DIR="$HOME/.config/rofi"
background="`cat $DIR/shared/colors.rasi | grep 'background:' | cut -d':' -f2 | tr -d ' '\;`"
accent="`cat $DIR/shared/colors.rasi | grep 'selected:' | cut -d':' -f2 | tr -d ' '\;`"
RASI="$DIR/screenshot/style.rasi"

# Theme Elements
prompt='Screenshot'
mesg="Directory :: `xdg-user-dir PICTURES`/Screenshots"

# Options
layout=`cat ${RASI} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	option_1=" Capture Desktop"
	option_2=" Capture Area"
	option_3=" Capture Window"
	option_4=" Capture in 5s"
	option_5=" Capture in 10s"
else
	option_1=""
	option_2=""
	option_3=""
	option_4=""
	option_5=""
fi

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${RASI}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
dir="`xdg-user-dir PICTURES`/Screenshots"
file="Screenshot_${time}_${geometry}.png"

# Directory
if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
iDIR="$HOME/.config/mako/icons"
notify_view() {
	notify_cmd_shot="notify-send -h string:x-canonical-private-synchronous:sys-notify-shot -u low -i ${iDIR}/picture.png"
	${notify_cmd_shot} "Copied to clipboard."
	paplay /usr/share/sounds/freedesktop/stereo/screen-capture.oga &>/dev/null &
	viewnior ${dir}/"$file"
	if [[ -e "$dir/$file" ]]; then
		${notify_cmd_shot} "Screenshot Saved."
	else
		${notify_cmd_shot} "Screenshot Deleted."
	fi
}

# countdown
countdown () {
	for sec in `seq $1 -1 1`; do
		notify-send -h string:x-canonical-private-synchronous:sys-notify-count -t 1000 -i "$iDIR"/timer.png "Taking shot in : $sec"
		sleep 1
	done
}

# take shots
shotnow () {
	cd ${dir} && sleep 0.5 && grim - | tee "$file" | wl-copy
	notify_view
}

shot5 () {
	countdown '5'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

shot10 () {
	countdown '10'
	sleep 1 && cd ${dir} && grim - | tee "$file" | wl-copy
	notify_view
}

shotwin () {
	w_pos=`hyprctl activewindow | grep 'at:' | cut -d':' -f2 | tr -d ' ' | tail -n1`
	w_size=`hyprctl activewindow | grep 'size:' | cut -d':' -f2 | tr -d ' ' | tail -n1 | sed s/,/x/g`
	cd ${dir} && sleep 0.3 && grim -g "$w_pos $w_size" - | tee "$file" | wl-copy
	notify_view
}

shotarea () {
	cd ${dir} && grim -g "$(slurp -b ${background:1}CC -c ${accent:1}ff -s ${accent:1}0D -w 4 && sleep 0.3)" - | tee "$file" | wl-copy
	notify_view
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shot5
	elif [[ "$1" == '--opt5' ]]; then
		shot10
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
esac
