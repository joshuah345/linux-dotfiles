#/usr/bin/env bash

DIR=`dirname "$0"`

function get_volume {
    amixer -D pulse get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer -D pulse get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {

    volume=`get_volume`
if [ "$volume" = "0" ]; then
        icon_name="/usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-off.svg"
dunstify  -i "$icon_name" -t 2000 -h int:value:"$volume" -h string:synchronous:"─" --replace=555
    else
	if [  "$volume" -lt "10" ]; then
	     icon_name="/usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-low.svg"
dunstify -i "$icon_name" -r 555 -t 2000
    else
        if [ "$volume" -lt "30" ]; then
            icon_name="/usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-low.svg"
        else
            if [ "$volume" -lt "70" ]; then
                icon_name="/usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-medium.svg"
            else
                icon_name="/usr/share/icons/Papirus-Dark/48x48/status/notification-audio-volume-high.svg"
            fi
        fi
    fi
fi
bar=$(seq -s "█" $(($volume/5)) | sed 's/[0-9]//g')
# Send the notification
dunstify   "$bar" -i "$icon_name" -t 2000 -r 555 -u low
}

case $1 in
    up)
	# Set the volume on (if it was muted)
	amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	amixer -D pulse set Master on > /dev/null
	amixer -D pulse sset Master 5%- > /dev/null
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
dunstify   -i "/usr/share/icons/Papirus-Dark/16x16/status/notification-audio-volume-muted.svg" --replace=555 -u normal "Muted"  -t 2000
	else
	    send_notification
	fi
	;;
esac





