#!/usr/bin/env bash
while inotifywait -e close_write /home/joshua/.Xresources /home/joshua/.stx 
do notify-send "Reloading xrdb and xst" && xrdb /home/joshua/.stx /home/joshua/.Xresources && pkill xst -USR1
done