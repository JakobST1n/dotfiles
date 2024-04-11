# -- general -------------------------------------------------------------------
# Options are 'screen-256color', 'screen-256color-bce'
set -g default-terminal "xterm-256color"
# Options are ',*:U8=0', ',xterm-256color:Tc', 'xterm-256color:RGB'
set-option -ga terminal-overrides ",xterm-256color:Tc"

set -s escape-time 0   # faster command sequences
set -s focus-events on

# -- display -------------------------------------------------------------------
set -g base-index 1
setw -g pane-base-index 1
setw -g automatic-rename on # rename window to reflect current program
set -g renumber-windows on # renumber windows when a window is closed

set -g display-panes-time 800 # slightly longer pane indicators display time
set -g display-time 1000      # slightly longer status messages display time

set -g status-interval 10     # redraw status linebg every 10 seconds
set-option -g history-limit 5000

set-option -g default-shell DT_SHELL

# -- navigation ----------------------------------------------------------------

# Set window notification
setw -g monitor-activity on
set -g visual-activity off

m4_ifelse(DT_DOTFILES_TYPE, `local', `m4_dnl
unbind C-b
set -g prefix C-a
bind C-a send-prefix
')m4_dnl

# Set copying settings
setw -g mode-keys vi
set-option -s set-clipboard off
bind P paste-buffer
bind-key -T copy-mode-vi 'v' send -X begin-selection
bind-key -T copy-mode-vi 'r' send -X rectangle-toggle
bind-key -T copy-mode-vi 'y' send -X copy-pipe-and-cancel 'xclip -sel clip -i'
unbind -T copy-mode-vi Enter
bind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -se c -ind-key -T copy-mode-vi Enter send-keys -X copy-pipe-and-cancel 'xclip -se c -i'
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -se c -i''

# Bells
set -g visual-bell on
set -g bell-action any

# Sync panes
bind-key = set-window-option synchronize-panes

# -- macros --------------------------------------------------------------------
bind-key s send-keys "DT_GIT_USER <DT_GIT_EMAIL>"

m4_changequote({, })m4_dnl
m4_ifelse(DT_TMUX_NAVIGATOR, `yes', {
# -- vim-tmux-navigator --------------------------------------------------------
# Smart pane switching with awareness of Vim splits.
# this doesn't work, haven't checked why. chaning from vim to neovim could be it
# See: https://github.com/christoomey/vim-tmux-navigator
is_vim="ps -o state= -o comm= -t '#{pane_tty}' \
    | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
bind-key -n 'C-h' if-shell "$is_vim" 'send-keys C-h'  'select-pane -L'
bind-key -n 'C-j' if-shell "$is_vim" 'send-keys C-j'  'select-pane -D'
bind-key -n 'C-k' if-shell "$is_vim" 'send-keys C-k'  'select-pane -U'
bind-key -n 'C-l' if-shell "$is_vim" 'send-keys C-l'  'select-pane -R'
tmux_version='$(tmux -V | sed -En "s/^tmux ([0-9]+(.[0-9]+)?).*/\1/p")'
if-shell -b '[ "$(echo "$tmux_version < 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\'  'select-pane -l'"
if-shell -b '[ "$(echo "$tmux_version >= 3.0" | bc)" = 1 ]' \
    "bind-key -n 'C-\\' if-shell \"$is_vim\" 'send-keys C-\\\\'  'select-pane -l'"

bind-key -T copy-mode-vi 'C-h' select-pane -L
bind-key -T copy-mode-vi 'C-j' select-pane -D
bind-key -T copy-mode-vi 'C-k' select-pane -U
bind-key -T copy-mode-vi 'C-l' select-pane -R
bind-key -T copy-mode-vi 'C-\' select-pane -l
})m4_dnl
m4_changequote(`, ')m4_dnl

# -- Utility ------------------------------------------------------------------
bind-key r source-file ~/.tmux.conf

bind -n M-w display-popup -E "nvim -c VimwikiIndex -c Calendar -c 'wincmd p'"
bind -n M-C-w display-popup -E "nvim -c VimwikiMakeDiaryNote -c Calendar -c 'wincmd p' -c 'call append(1, strftime(\"- **%T** - **\"))' -c 'call append(2, \"\")' -c 'execute \"normal! 2GA\"'"
bind -n M-C-i display-popup -E "nvim -c 'e ~/Nextcloud/wiki/I45/Hendelser.md' -c 'call append(1, strftime(\"- **%d.%m.%Y (%T)** - **\"))' -c 'call append(2, \"\")' -c 'execute \"normal! 2GA\"'"

bind-key T run-shell "toggle-theme"

m4_changequote({, })m4_dnl
m4_ifelse(DT_DOTFILES_TYPE, {local}, {
set-hook -g session-window-changed 'run-shell "update-theme"'
set-hook -g window-renamed 'run-shell "update-theme"'
bind-key C-p run-shell "tmux display-message -p '#W' | grep -q '^PROD' || tmux rename-window 'PROD #{window_name}'"
bind-key C-S run-shell "tmux display-message -p '#W' | grep -q '^STAGING' || tmux rename-window 'STAGING #{window_name}'"
})m4_dnl
m4_changequote(`, ')m4_dnl

# -- Theme --------------------------------------------------------------------
m4_ifelse(DT_DOTFILES_TYPE, `local', `m4_dnl
set -g status-justify left
set -g status-interval 2
set -g status-position bottom
#set -g status-bg "#f8f8f8"
set -g status-bg "#F2EEDE"
set -g status-fg colour16

set -g status-left "#[fg=colour232,bg=colour3,bold]#{?client_prefix,C-a,}#[default] #[fg=colour0,bg=colour7,bold][#S]#[default] "
set -g status-left-length 20

set -g status-right "#[fg=colour0,bg=colour7,bold] #(hostname) #[default] #[fg=colour0,bg=colour7,bold] %d/%m/%y #[default] #[fg=colour0,bg=colour7,bold] %H:%M:%S #[default] #[bg=colour7,bold] #(cat /sys/class/power_supply/BAT0/capacity)% #[default] "
set -g status-right-length 50

setw -g window-status-format " #I:#W#F "
setw -g window-status-current-format " #I:#W#F "

setw -g window-status-current-style "bg=colour0,fg=colour15"
setw -g window-status-style "bg=colour7,fg=colour0"
setw -g window-status-bell-style "bg=colour23,fg=colour15"
#setw -g window-status-activity-style "bg=colour23,fg=colour15"
setw -g window-status-activity-style "bg=colour243,fg=colour15"
')m4_dnl
m4_ifelse(DT_DOTFILES_TYPE, `remote', `m4_dnl
set -g status-bg "purple"
set -g status-fg "white"
')m4_dnl
