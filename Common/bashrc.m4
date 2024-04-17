m4_include(`system.m4')m4_dnl
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Check if env setup file exists
if [ ! -f ~/.dotfiles_env ]; then
    echo "DEFAULT_USER=$USER" >> ~/.zsh_env_setup
    echo "export GIT_EDITOR=\"DT_EDITOR\"" >> ~/.dotfiles_env
    echo "export GIT_AUTHOR_NAME=\"DT_GIT_USER\"" >> ~/.dotfiles_env
    echo "export GIT_AUTHOR_EMAIL=\"DT_GIT_EMAIL\"" >> ~/.dotfiles_env
fi

export XDG_CONFIG_HOME="${HOME}/.config"

# Source env setup file
source ~/.dotfiles_env

# Add some commons to PATH
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/go/bin

# Modify locale and path
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set editor
export EDITOR="DT_EDITOR"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Prompt
PS1='\w\$ '

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
alias cda=". $HOME/bin/cd-archive"

# Make tmux window title show the ssh hostname
# Make short hostname only if its not an IP address
__tm_get_hostname(){
    local HOST="$(echo $* | rev | cut -d ' ' -f 1 | rev)"
    if echo $HOST | grep -P "^([0-9]+\.){3}[0-9]+" -q; then
        echo $HOST
    else
        echo $HOST| cut -d . -f 1
    fi
}

__tm_get_current_window(){
    tmux list-windows| awk -F : '/\(active\)$/{print $1}'
}

# Rename window according to __tm_get_hostname and then restore it after the command
__tm_command() {
    if [ "$(ps -p $(ps -p $$ -o ppid=) -o comm=| cut -d : -f 1)" = "tmux" ]; then
        __tm_window=$(__tm_get_current_window)
        # Use current window to change back the setting. If not it will be applied to the active window
        trap "tmux set-window-option -t $__tm_window automatic-rename on 1>/dev/null" EXIT HUP INT QUIT PIPE TERM
        tmux rename-window "$(__tm_get_hostname $*)"
    	command "$@"
        tmux set-window-option -t $__tm_window automatic-rename on 1>/dev/null
	else
    	command "$@"
    fi
}

ssh() {
    __tm_command ssh "$@"
}

# start only one ssh-agent and reuse the created one
# this is used for sway, although keys added do not persist on reboot
SSH_DIR="$HOME"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$SSH_DIR/ssh-agent.env"
fi
source "$SSH_DIR/ssh-agent.env" > /dev/null

# enable cargo things
. "$HOME/.cargo/env"

# Enable FZF history
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
m4_ifelse(DT_DISTRO, `fedora', m4_dnl
source /usr/share/fzf/shell/key-bindings.bash
)m4_dnl

# Autocompletion
source DT_DOTFILES_DIR/auto_completion/cd-archive
