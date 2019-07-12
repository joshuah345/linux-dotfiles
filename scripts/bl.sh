#!/usr/bin/env bash

cbl="$(< /sys/class/backlight/intel_backlight/brightness)"
blf="/sys/class/backlight/intel_backlight/brightness"
max="$(cat /sys/class/backlight/intel_backlight/max_brightness)"
per="$((($cbl*100) / $max))"%

if [[ -w $blf ]]
then :
else pkexec chmod a+u $blf
fi

if [[ $cbl -gt 2759 ]]; then
	per=100%
fi
function notify {
dunstify --appname="Brightness" --icon "/usr/share/icons/Papirus-Dark/48x48/status/notification-display-brightness-medium.svg" "$per" --replace=11236 -t 1500
}

case $1 in
    up)
	# Up the brightness (+50)
	echo $(($cbl + 50)) > $blf
	notify
	;;
    down)
	echo $(($cbl - 50)) > $blf
	notify
	;;
	current)
	echo "$per"
	;;
esac