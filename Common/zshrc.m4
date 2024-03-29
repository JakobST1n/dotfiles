# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin:$PATH:$HOME/go/bin
export KEYTIMEOUT=1

# Check if env setup file exists
if [ ! -f ~/.dotfiles_env ]; then
	echo "export ZSH=$HOME/.oh-my-zsh" > ~/.dotfiles_env
    echo "DEFAULT_USER=$USER" >> ~/.dotfiles_env
    echo "export GIT_EDITOR=\"DT_EDITOR\"" >> ~/.dotfiles_env
    echo "export GIT_AUTHOR_NAME=\"DT_GIT_USER\"" >> ~/.dotfiles_env
    echo "export GIT_AUTHOR_EMAIL=\"DT_GIT_EMAIL\"" >> ~/.dotfiles_env
fi

# Source env setup file
source ~/.zsh_env_setup

# Source powerlevel10k theme
m4_ifelse(OS_TYPE, `macos', `m4_dnl
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
')m4_dnl
m4_ifelse(OS_TYPE, `linux', `m4_dnl
ZSH_THEME="powerlevel10k/powerlevel10k"
')m4_dnl

COMPLETION_WAITING_DOTS="true"

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=7,bold"

# Setup plugins
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  #zsh-vi-mode
)

# zsh-vi-mode-setup
#ZVM_CURSOR_STYLE_ENABLED=false
# zvm_config() {
#     ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
#     ZVM_NORMAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
#     ZVM_VISUAL_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
#     ZVM_VISUAL_LINE_MODE_CURSOR=$ZVM_CURSOR_UNDERLINE
#     ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
# }

# Setup oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Modify locale and path
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set editor
export EDITOR="DT_EDITOR"

# Enable vim keybindings (This is enabled using zsh-vi-mode now.
# bindkey -v

# Add aliases
alias lsp="ps -ax | grep"
alias lsa="ls -la"
alias lsg="ls | grep"
alias lsag="ls -la | grep"
alias ls="tput setaf 3 && echo \"'lsa' for 'ls -la', \n'lsg' for 'ls | grep',\n'lsag' for 'ls -la | grep',\n'lsp' for 'ps -ax |grep'\" && tput sgr0 && ls"

alias _vi=$(which vi)
alias _vim=$(which vim)
alias vi=nvim
alias vim=nvim

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

ec2ssh() {
    __tm_command ec2ssh "$@"
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

m4_ifelse(OS_TYPE, `macos', `m4_dnl
path+=("$(readlink /Users/$DEFAULT_USER/bin)")
path+=("/Library/TeX/texbin")
path+=("/usr/local/share/dotnet")
path+=("/usr/local/sbin")
path+=("/Users/jakobstendahl/.deta/bin")
path+=("/Applications/Racket v8.2/bin")
path+=("/Users/jakobstendahl/Library/Python/3.9/bin/")
export PATH

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jakobstendahl/.sdkman"
[[ -s "/Users/jakobstendahl/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jakobstendahl/.sdkman/bin/sdkman-init.sh"
')m4_dnl
m4_ifelse(OS_TYPE, `linux', `m4_dnl
alias pbcopy="xsel --clipboard --input"
alias pbpaste="xsel --clipboard --output"
')m4_dnl

# start only one ssh-agent and reuse the created one
# this is used for sway, although keys added do not persist on reboot
SSH_DIR="$HOME"
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$SSH_DIR/ssh-agent.env"
fi
source "$SSH_DIR/ssh-agent.env" > /dev/null

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
