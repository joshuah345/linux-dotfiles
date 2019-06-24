# xfce4-panel (from  Equal and Opposite) <br />

### Panel 1

`Applet names will be referred to later....` <br /> <br /> 
<b> From left to right </b>the top panel includes: <br />
<br />
Launcher 1 <br />
Generic Monitor (genmon plugin) <br />
Seperator 1 <br>
Launcher 2 <br />
Generic Monitor 2 <br />
Launcher 3 <br />
Seperator <br />
Notification Area <br />
PulseAudio Plugin <br />
Power Manager Plugin <br />
Status Notifier Plugin <br />
Clock  <br /> <br />

#### General Settings <br>
Mode: Horizontal <br>
Row Size: 28 (adjust for screen size) <br>
Row Count: 1 <br>
Length: 100 <br>
Alpha: 42 <br>
Solid color: `#2f343f` <br>
Autohide: intelligent <br>
<br>

#### Launcher 1 <br>
Command: `rofi -show drun`<br>
Icon: flag-red (breeze-icons)<br>
<br>

#### Generic Monitor 1 (Window name) <br>
Command: `xdotool getwindowfocus getwindowname` <br>
Label: true : `"  "` (two spaces, to indent away from launcher) <br>
Period: 0.75 <br>
Font: Rubik 12 (Optional) <br>
<br>

#### Seperator 1<br>
Style: Transparent <br>
Expand: True<br>
<br>

#### Launcher 2
Command: `playerctl previous` (requires playerctl to be installed, controls apps like spotify) <br>
Icon: `go-previous` (breeze-icons)<br>
<br>

#### Generic Monitor 2
Command: ``player2.sh`` (you can get it from [here](https://github.com/joshuah345/linux-dotfiles/blob/master/Equal%20And%20Opposite%20(compton-tryone)/player2.sh), also requires [playerctl-mpris-tail](https://github.com/polybar/polybar-scripts/tree/master/polybar-scripts/player-mpris-tail) and playerctl)<br>
Period: 1.75 <br>
Label: Off <br>
<br>

note: you need to replace the directory for mpris tail with the correct one, for example `/home/username/playerctl-mpris-tail.py`
<br>

#### Launcher 3
Command: `playerctl next` <br>
Icon go-next (breeze-icons)<br>
<br> <br>


### Panel 2 <br>
#### General Settings <br> <br>
no items <br>
place behind panel 1 <br>
alpha: 55 <br>
solid color: `#2b2e37`<br>
Length: 90 <br>
Autohide: intelligent


