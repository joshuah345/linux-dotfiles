# Scripts

every file in this folder has been used in at least one of my rices. <br>

### dv.sh <br>

changes volume and sends notification to dunst (using papirus-dark icons) (dunst only) <br>

syntax : ``dv.sh <up|down|mute>`` <br> <br>

### bl.sh <br>

changes backlight and sends notification (dunst only) (papirus dark icons) <br>
syntax : ``bl.sh <up|down>`` <br><br>

### i3bar.sh <br>

some ironic naming here. this script actually launches polybar and sends a notification (doesnt require dunst) <br>
this works just like ``polybar -c <default polybar config dir>`` but shorter. <br>

syntax: ``i3bar.sh <filename> <barname>`` <br>

the file must be found in ``~/.config/polybar`` or else the script wont launch it. <br><br>

### xrel.sh <br>
a script i use to load xresources once the file is edited, just run it and it should detect when its edited. also sends USR1 to reload [xst](https://github.com/gnotclub/xst)
