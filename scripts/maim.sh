#!/usr/bin/env bash
shopt -s extglob

noti() { notify-send -i $PWD/img.png -t 2000 "Screenshot Taken and copied to clipboard." 
}

help(){ echo "maim.sh"
	echo 
	echo "Usage: maim.sh [ARG]"
	echo 
	echo "-a | --active | active :  Takes screenshot of active window."
	echo
}

case $1 in

 	-s|--select|select)
		maim -s img.png 
			if [[ $? -ne 0 ]];
			then notify-send -t 2000 "Screenshot canceled by user." "You either pressed a key or right-clicked."
			exit 1	
			else shift
	fi
		xclip -selection clipboard -t image/png img.png
		noti
		;;

	-f|fullscreen|--fullscreen)
		maim img.png 
		if [[ $? -ne 0 ]];
			then notify-send -t 2000 "An error occured." "Screenshot could not be taken."
			exit 1	
			else shift
	fi
		xclip -selection clipboard -t image/png img.png
		noti
		;;

	-a|--active)
		maim -i $(xdotool getactivewindow) img.png
		if [[ $? -ne 0 ]];
			then notify-send -t 2000 "An error occured." "Screenshot could not be taken."
		exit 1
		else shift
	fi
		xclip -selection clipboard -t image/png img.png
		noti
		;;

	*|-h|--help|help)
		help

esac

if [[ -z img.png ]];
then rm img.png
fi