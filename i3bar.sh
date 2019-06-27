#!/usr/bin/env bash
pkill polybar && notify-send --app-name Polybar "All running instances of polybar have been killed"
shopt -s extglob
pdir=$HOME/.config/polybar

case $1 in 
    !(list))
    fname=$1
    ;;
    list) 
    ls --color $HOME/.config/polybar
esac

case $2 in
    *)
    bname=$2 
esac 

<<<<<<< HEAD
 [[ -z "$2" ]] && exit || polybar -r -c $pdir/$fname $bname 1>&- 2>&-  & 
 notify-send --app-name Polybar "Bar "$bname" has started." 
=======
then pkill polybar & polybar -c ~/.config/polybar/aenami.ini aenami
>>>>>>> 66bbe5ec5c74df7a0b0d0088fba46c0d9a43d5a6


<<<<<<< HEAD
=======
fi
>>>>>>> 66bbe5ec5c74df7a0b0d0088fba46c0d9a43d5a6
