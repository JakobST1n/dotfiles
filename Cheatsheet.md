# Cheatsheet 
Cheatsheets for different terminal things. 

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