#!/usr/bin/env bash
while inotifywait -e close_write $HOME/.Xresources $HOME/.stx 
do notify-send "Reloading xrdb and xst" && xrdb $HOME/.stx $HOME/.Xresources && pkill xst -USR1
done
