#!/usr/bin/env bash

init_filenames() {
	#$1 resolution

	# custom i3lock colors
	lockconf="$HOME/.config/stlockrc"
	if [ -e $lockconf ]; then
	    source "$lockconf"
	else
        # copy this block to ~/.config/stlockrc" to customize
	    insidecolor=00000000
	    ringcolor=ffffffff
	    keyhlcolor=d23c3dff
	    bshlcolor=d23c3dff
	    separatorcolor=00000000
	    insidevercolor=00000000
	    insidewrongcolor=d23c3dff
	    ringvercolor=ffffffff
	    ringwrongcolor=ffffffff
	    verifcolor=ffffffff
	    timecolor=ffffffff
	    datecolor=ffffffff
	    loginbox=00000066
		font="Work Sans 9"
      	locktext='Screen locked. Enter password.'
	fi
}

init_filenames $res


prelock() {
	if [ ! -z "$(pidof dunst)" ]; then
		pkill -u "$USER" -USR1 dunst
	fi
}

lock() {
	maim > reg.png

	convert reg.png \
		-filter Gaussian \
		-blur 5x2 \
		-gamma 0.7 \
		2.png

	i3lock \
		-t -i "2.png" \
		--timepos='x+110:h-70' \
		--datepos='x+43:h-45' \
		--clock --date-align 1 --datestr "$locktext" \
		--insidecolor=$insidecolor --ringcolor=$ringcolor --line-uses-inside \
		--keyhlcolor=$keyhlcolor --bshlcolor=$bshlcolor --separatorcolor=$separatorcolor \
		--insidevercolor=$insidevercolor --insidewrongcolor=$insidewrongcolor \
		--ringvercolor=$ringvercolor --ringwrongcolor=$ringwrongcolor --indpos='x+280:h-70' \
		--radius=20 --ring-width=4 --veriftext='' --wrongtext='' \
		--verifcolor="$verifcolor" --timecolor="$timecolor" --datecolor="$datecolor" \
		--time-font="$font" --date-font="$font" --layout-font="$font" --verif-font="$font" --wrong-font="$font" \
		--noinputtext='' --force-clock $lockargs
}


postlock() {
	if [ ! -z "$(pidof dunst)" ] ; then
		pkill -u "$USER" -USR2 dunst
	fi
}

case $1 in 

	-l|--lock)
	lock
	rm reg.png
	rm 2.png
	exit 0
	;;

	-s|--suspend)
	lock 
	systemctl suspend
	rm 2.png
	rm reg.png
	exit 0
	;;

	*)
	lock
	rm reg.png
	rm 2.png
	exit 0
esac 