# How to use my dotfiles. (and how these work, in detail)
 `Where do these files go, and why?`
 
 Assume this repository is layed out like your home folder. `~/`\
 
 The root directories (Aenami, Circela, Cocoon)  contain some of the folders shown below.
  
#### File structure


* `~/.config` is the directory on unix based systems for config(uration) files
  * `~/.config/compton.conf` - config file for ![compton (X compositor)](https://github.com/chjj/compton)

    * `~/.config/i3/config` - ![i3 (window manager)](https://github.com/i3/i3) config file
    * ` ~/.config/dunst/dunstrc` - ![dunst (notification daemon)](https://github.com/dunst-project/dunst) config file
    * `~/.config/polybar/x` - ![polybar](https://github.com/polybar/polybar) config file (x can be any filename you like)
    * `~/.config/cava/config - config file for ![cava](https://github.com/karlstav/cava)
  
* `~/.fonts` is one of the locations where user (manually) installed fonts are stored.

* `~/.themes` is one of the locations where themes (GTK, XFWM4, openbox, QT) can be stored

* `~/.icons` is one of the locations where icon sets can be stored (one of my favorites is ![Papirus](https://github.com/PapirusDevelopmentTeam/papirus-icon-theme))

#### Other files/folders

``i3bar.sh`` - a shell script i use to start polybar. *(dont launch this from a terminal, use xinit or your window manager's startup config)*

`.zshrc` - my config for ![ZSH (z-shell)](https://github.com/zsh-users/zsh) (Requires ![antigen](https://github.com/zsh-users/antigen) to load properly

``images/wallpapers`` - where all the wallpapers used in my screenshots are located
