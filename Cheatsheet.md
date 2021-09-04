# Cheatsheet 
Cheatsheets for different things in this repo.

## ZSH 

These are things that are in my zshrc file and such.

#### Aliases

- `lsp` `ps -ax | grep `
- `lsa` `ls -la`
- `lsg` `ls | grep`
- `lsag` `ls -la | grep `

On linux `pbcopy` and `pbpase` behaves the same as they do on MacOS (given that `xsel` is installed).

## Vim

### General vim

https://vim.rtorr.com

### [jakobst1n's](https://github.com/jakobst1n/dotfiles) additional keymaps
- Leader key: `,`
- Fast save (`:w!`): `<leader>w`
- `:W` -> `sudo save`

#### Search
- Visual mode `*` or `#` searches for current selection
- Space: `/` (search)
- C-space: `?` (backward search)

#### Windows
- `<C-(j|k|h|l)>`  move between windows

#### Buffers
- `<leader>bd` Close current buffer.
- `<leader>ba` Close all buffers
- `<leader>l` next buffer
- `<leader>h` prev buffer

#### tabs
- `<leader>tn` new tab
- `<leader>to` tabonly
- `<leader>tc` close tab
- `<leader>tm` move tab
- `<leader>t<leader>` next tab
- `<leader>tl` Last used tab
- `<leader>te` Open new tab with current buffers path.

#### Working directory
- `<leader>cd` Set working directory to path of current buffer

#### Line moving
You can move a line of text using `ALT+[jk]` or `CMD+[jk]` on mac.

#### Spell checking
- `<leader>ss` Toggle spellcheck
- `<leader>sn` `]s`
- `<leader>sp` `[s`
- `<leader>sa` `zg`
- `<leader>s?` `z=`

#### Clipboard
- `<leader>pp` Toggle paste mode

#### NerdTree
- `<F3>` To toggle

#### FuzzyFinder
- `;` To open

#### CoC
- Use `<TAB>` for autocomplete
- `gd` Go to definition
- `gy` Go to type definition
- `gi` Go to implementation
- `gr` Go to references
- `K` To show documentation in preview window
- `<leader>rn` Rename symbol
- `<leader>f` format selected

#### Multiple-cursors
- `<C-d>`->`start_word_key`
- `<A-d>`->`select_all_word_key`
- `g<C-d>`->`start_key`
- `g<A-D>`->`select_all_key`
- `<C-d>`->`next_key`
- `<C-p>`->`prev_key`
- `<C-x>`->`skip_key`
- `<ESC>`->`quit_key`



## Tmux

### General Tmux
- Prefix `Ctrl`+`a`

####  Sessions
- `tmux`, `tmux new`, `tmux new-session`, `:new` new session.
- `tmux new -s <session-name>`, `:new -s <session-name>` new session with name.
- `tmux kill-ses -t <session-name>`, `tmux kill-session -t <session-name>` kill delete session with name.
- `tmux kill-session -a` kill/delete all sessions but the current.
- `tmux kill-session -a -t <session-name>` kill/delete all sessions but the named one.
- `prefix` `$` rename session.
- `prefix` `$`Detach from session.
- `:attach -d`Detach others on the session (Maximise window by detach other clients).
- `tmux ls`, `tmux list-sessions`, `prefix` `s` show all sessions.
- `tmux a`, `tmux at`, `tmux attach`, `tmux attach-session` attach to last session.
- `tmux a -t <session-name>`, `tmux at -t <session-name>`, `tmux attach -t <session-name>`, `tmux attach-session -t <session-name>` attach to a session with name.
- `prefix` `(` Move to previous session.
- `prefix` `)` Move to next session.

#### Windows

- `prefix` `c` Create window.
- `prefix` `,` Rename window.
- `prefix` `&` Close current window.
- `prefix` `p` Previous window.
- `prefix` `n` Next window.
- `prefix` `0`..`9` Switch/select window by number.
- `:swap-window -s 2 -t 1` Reorder window, swap window number 2(src) and 1(dst).
- `:swap-window -t -1` Move current window to the left by one position.

#### Panes

- `prefix` `;` Toggle last active pane.
- `prefix` `%` Split pane vertically.
- `prefix` `"` Split pane horizontally.
- `prefix` `{` Move the current pane left.
- `prefix` `}` Move the current pane right.
- `prefix` `up/down/right/left` swith to pane in direction.
- `:setw synchronize-panes` Toggle synchronized-panes.
- `prefix` `Space` Toggle between pane layouts.
- `prefix` `o` Switch to next pane.
- `prefix` `q` Show pane numbers.
- `prefix` `q` `0`..`9` Switch/select pane by number.
- `prefix` `z` Toggle pane zoom.
- `prefix` `!` Convert pane into a window.
- `prefix`+`arrow`, `prefix` `ctrl`+`arrow` resize current pane in direction.
- `prefix` `x` Close current pane.

#### Copy Mode

- `:setw -g mode-keys vi` use vi keys in buffer.
- `prefix` `[]` enter copy mode.
- `prefix` `PgUp` enter copy mode and scroll one page up.
- `q` Quit mode.
- `g` Go to top line.
- `G` Go to bottom line.
- `Up` Scroll up.
- `Down` Scroll down.
- `h/j/k/l` Move cursor.
- `w/b` Move cursor one word forward/back.
- `/`/`?` Search forward/backward.
- `n` next keyword occurrence.
- `N` Previous. occurrence.
- `Space` Start selection.
- `ESC` Clear selection.
- `Enter` Copy selection.
- `prefix` `]` Paste contents of buffer_0.
- `:show-buffer` Display buffer_0 contents.
- `:capture-pane` Copy entire visible contents of pane to a buffer.
- `:list-buffers` Show all buffers.
- `:choose-buffer` Show all buffers and paste selected.
- `:save-buffer <filename>` Save buffer contents to file.
- `:delete-buffer -b 1` Delete buffer 1.

#### Misc

- `prefix` `:` Enter command mode.
- `:set -g OPTION` Set OPTION for all sessions.
- `:setw -g OPTION` Set OPTION for all windows.

#### Help

- `tmux info` Show every session, window, pane, etc...
- `prefix` `?` Show shortcuts.