# -- general -------------------------------------------------------------------
set -g default-terminal "tmux-256color"
set -as terminal-overrides ",xterm-256color:Tc"  # don't remember
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

set -s escape-time 0   # faster command sequences, vim is really annoying without it
setw -g automatic-rename on
set-option -g history-limit 10000
set-option -g default-shell DT_SHELL
set -s focus-events on

# -- navigation ----------------------------------------------------------------
setw -g monitor-activity on
set -g visual-activity off
set -g visual-bell on
set -g bell-action any

setw -g mode-keys vi

m4_ifelse(DT_DOTFILES_TYPE, `local', `m4_dnl
unbind C-b
set -g prefix C-a
bind C-a send-prefix
')m4_dnl

# -- macros --------------------------------------------------------------------
bind-key = set-window-option synchronize-panes
bind-key r source-file ~/.tmux.conf

m4_changequote({, })m4_dnl
m4_ifelse(DT_DOTFILES_TYPE, {local}, {m4_dnl
bind-key S send-keys "DT_GIT_USER <DT_GIT_EMAIL>"
bind -n M-w display-popup -E "nvim -c VimwikiIndex -c Calendar -c 'wincmd p'"
bind -n M-C-w display-popup -E "nvim -c VimwikiMakeDiaryNote -c Calendar -c 'wincmd p' -c 'call append(1, strftime(\"- **%T** - **\"))' -c 'call append(2, \"\")' -c 'execute \"normal! 2GA\"'"
bind -n M-C-i display-popup -E "nvim -c 'e ~/Nextcloud/wiki/I45/Hendelser.md' -c 'call append(1, strftime(\"- **%d.%m.%Y (%T)** - **\"))' -c 'call append(2, \"\")' -c 'execute \"normal! 2GA\"'"

# Theme toggling
bind-key T run-shell "toggle-theme"
set-hook -g session-window-changed 'run-shell "update-theme"'
set-hook -g window-renamed 'run-shell "update-theme"'
bind-key C-p run-shell "tmux display-message -p '#W' | grep -q '^PROD' || tmux rename-window 'PROD #{window_name}'"
bind-key C-s run-shell "tmux display-message -p '#W' | grep -q '^STAGING' || tmux rename-window 'STAGING #{window_name}'"
})m4_dnl
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

# -- Theme --------------------------------------------------------------------
m4_ifelse(DT_DOTFILES_TYPE, `local', `m4_dnl
set -g status-left "#{?client_prefix,C-a ,}[#S] "
set -g status-right "%d/%m/%y %H:%M:%S [#(cat /sys/class/power_supply/BAT0/capacity)%]"
set -g status-style "fg=colour255,bold,bg=black"
')m4_dnl
m4_ifelse(DT_DOTFILES_TYPE, `remote', `m4_dnl
set -g status-left "#{?client_prefix,C-b ,}[#S] "
set -g status-style "fg=colour255,bold,bg=purple"
')m4_dnl
