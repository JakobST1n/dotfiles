m4_include(`system.m4')m4_dnl
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# Prompt
PS1='\w\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias ll='ls -l --color=auto'
    alias la='ls -A --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# man pages in colors
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
alias cda=". $HOME/bin/cd-archive"

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

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
