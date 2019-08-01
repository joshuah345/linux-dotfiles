#!/usr/bin/env bash
name="$(basename $0)"

ps axu|grep "/$name"|tail -n+2|grep -v grep > /dev/null

if [[ $? -eq 0 ]]; then
echo "This script is already running. Exiting..."
exit 1
fi

while inotifywait -e close_write /home/joshua/.Xresources /home/joshua/.stx 
do notify-send "Reloading xrdb and xst" && xrdb /home/joshua/.stx /home/joshua/.Xresources && pkill xst -USR1
done 