### DO NOT EDIT THIS UNLESS YOU KNOW WHAT YOU ARE DOING ###
### PROMPT SETTINGS ARE STORED IN '~/.zsh_prompt.conf' ###
### SET UP THE PROMPT ###
setopt PROMPT_SUBST
### ZSH OPTIONS ###
# make zsh behave better with '&', '*', etc when used as input with a command
setopt no_nullglob
setopt no_nomatch
###
### FUNCTIONS TO OUTPUT COLOR SAMPLES ###
prompt_fg_samples () {
    for i in {000..256}; do
        print -P -- "$(tput sgr0)$i: %{$(BG_COLOR $COLOR_BG)%}%${i}F %n %S %25<$(echo "/${${PWD#/*}%%/*}/" | sed 's%\/home\/%\~\/%')...<%~ %s%k%f"
    done
}
prompt_bg_samples () {
    for i in {000..256}; do
        print -P -- "$(tput sgr0)$i: %{$(echo -e "\033[48;5;${i}m")%}%$(FG_COLOR)F %n %S %25<$(echo "/${${PWD#/*}%%/*}/" | sed 's%\/home\/%\~\/%')...<%~ %s%k%f"
    done
}
### FUCTION TO CHANGE COLOR BASED ON $PWD ###
FG_COLOR () {
    case $PWD in
        /usr*|/opt*)
            echo "$COLOR_USR"
            ;;
        $HOME*|/run/media/simonizor*)
            echo "$COLOR_HOME"
            ;;
        *)
            echo "$COLOR_ROOT"
            ;;
    esac
}
MAIN_COLOR () {
    FG_COLOR
}
###
### FUNCTION TO SET THE BACKGROUND COLOR ###
BG_COLOR () {
    echo -e "\033[48;5;${1}m"
}
BACKGROUND_COLOR () {
    echo -e "\033[48;5;${COLOR_BG}m"
}
### FUNCTIONS TO GET THE GIT STATUS OF THE CURRENT DIRECTORY ###
parse_git_branch () {
    (git symbolic-ref -q HEAD || git name-rev --name-only --no-undefined --always HEAD) 2> /dev/null
}
parse_git_state () {
    if [[ -z "$(git status --porcelain)" ]]; then
        GIT_STATE=""
    else
        GIT_STATE="$(git status --porcelain | wc -l) "
    fi
    if [[ ! -z "$GIT_STATE" ]]; then
        echo "$GIT_STATE"
    fi
}
GIT_STATUS () {
    local git_where="$(parse_git_branch)"
    [ -n "$git_where" ] && echo "%$(FG_COLOR)F%S%{$(BG_COLOR $COLOR_BG)%} ʮ ${git_where#(refs/heads/|tags/)} $(parse_git_state)%s%f%k"
}
###
### FUNCTION TO SET THE EXIT STATUS PROMPT ###
EXIT_STATUS () {
    EXIT="$?"
    case $EXIT in
        0)
            echo ""
            ;;
        *)
            echo "%$(FG_COLOR)F%S%{$(BG_COLOR $COLOR_BG)%} ✘ "$EXIT "%s%f%k"
            ;;
    esac
}
###
# set the contents of the main prompt (PS1)
### FUNCTION TO SET THE PROMPT ###
MAIN_PROMPT () {
    echo -e "$PS1_CONTENTS"
}
### LOAD TAB COMPLETIONS ###
# Use modern completion system
autoload -Uz compinit
compinit
###
### SOURCE CONFIG FILE IF IT EXISTS OTHERWISE SETUP DEFAULTS ###
if [[ -f "$HOME/.zsh_prompt.conf" ]]; then
    source "$HOME"/.zsh_prompt.conf
else
cat > "$HOME"/.zsh_prompt.conf << 'EOL'
### PROMPT OPTIONS ###
# COLORS
# color support is limited to your terminal
# for most terminals, valid colors are 000-256
# run 'prompt_fg_samples' and 'prompt_bg_samples' for a preview of the colors
# set these colors to the same color to disable the prompt changing color based on directory
# foreground color for the prompt when in $HOME directory
COLOR_HOME="004"
# foreground color for the prompt when in /usr/* and /opt/*
COLOR_USR="011"
# foreground color for the prompt when in /*
COLOR_ROOT="009"
# background color for the prompt
COLOR_BG="000"
# PROMPT
# set the contents of the prompt
# '%$(FG_COLOR)F' is the color based on the $PWD as set in ~/.zsh_prompt.conf
# '%{$(BG_COLOR $COLOR_BG)%}' is the background color as set in ~/.zsh_prompt.conf
# '%25<$(echo "/${${PWD#/*}%%/*}/" | sed 's%\/home\/%\~\/%')...<%~' truncates the current
# directory if more than 25 characters
# see http://zsh.sourceforge.net/Doc/Release/Prompt-Expansion.html#Prompt-Expansion for zsh prompt expansions
PS1='%{$(BG_COLOR $COLOR_BG)%}%$(FG_COLOR)F %n %S %25<$(echo "/${${PWD#/*}%%/*}/" | sed 's%\/home\/%\~\/%')...<%~ %s%k%f '
# set whether exit status and git status prompt on right side is enabled
# must be set to TRUE or FALSE
ENABLE_RPS1="TRUE"
###
### ENVIRONMENT VARIABLES ###
# Change/remove these to match your settings
# xterm-256color should work for most modern teminal emulators
export TERM=xterm-256color
# change this to the path of your favorite terminal text editor
export EDITOR=/usr/bin/nano
# MPD users may have trouble without this set
# should not affect anyone who does not use MPD
export MPD_HOST=127.0.0.1
###
### OTHER OPTIONS ###
# launches tmux in each new terminal if tmux is not already running in that terminal
# requires 'tmux' be installed
ENABLE_TMUX="FALSE"
# launch new zsh sessions in dtach which allows programs to keep running if terminal is closed/crashes
# requires 'dtach' be installed
ENABLE_DTACH="FALSE"
###
### ADD YOUR OPTIONS HERE ###

###
EOL
source "$HOME"/.zsh_prompt.conf
fi
### SET THE PROMPT ###
if [[ -z "$PS1" ]]; then
    PS1='%{$(BG_COLOR $COLOR_BG)%}%$(FG_COLOR)F %n %S %25<$(echo "/${${PWD#/*}%%/*}/" | sed 's%\/home\/%\~\/%')...<%~ %s%k%f '
fi
if [[ "$ENABLE_RPS1" = "TRUE" ]]; then
    RPS1='$(EXIT_STATUS)$(GIT_STATUS)'
else
    unset RPS1
fi
###
### SETUP ZSH OPTIONS ###
setopt histignorealldups sharehistory menu_complete
# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e
###
### HISTORY FILE OPTIONS ###
# Keep 50000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=50000
SAVEHIST=50000
HISTFILE=~/.zsh_history
###
### SET TAB COMPLETION OPTIONS ###
zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select
zstyle ':completion:*' menu select=5
zstyle ":completion:*:descriptions" format "%B%d%b"
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl true
zstyle ':completion:*' verbose true
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
###
### ZSH ALIASES FILE ###
# Adds check for zsh aliases file for separate loading of aliases like bash
if [[ -f ~/.zsh_aliases ]]; then
    . ~/.zsh_aliases
fi
###

alias vi=micro
alias vim=micro

source ~/.config/zsh/antigen.zsh

antigen bundle zsh-users/zsh-history-substring-search
antigen bundle zdharma/fast-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen theme geometry-zsh/geometry

antigen apply
