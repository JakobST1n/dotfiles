This is just all my dotfiles, do what you want with them. 

Personally i use to pull this repo and install them all, but you can use them for inspiration or whatever you want.

I only use mac and linux arch atm, and so i haven't fiddled with windows files for the past year.
Run `./install.sh` and type what os it should be installed to.

## Installer
### Mac
- Install `homebrew`
- Install `highlight`, `atool`, `w3m`, `mediainfo`
- Install `Oh-My-Zsh`
- Install `zsh-autosuggestions`
- Install `Powerline python thingy`
- Install `Powerlevel9k`
- Create symlinks for dotfiles and folders.
  - `mac/tmux.conf` -> `~/.tmux.conf`
  - `mac/Hyperterm/hyper.js` -> `~/.hyper.js`
  - `mac/Hyperterm/local` -> `~/.hyper_plugins/local` (dir)
  - `Common/vimrc` -> `~/.vimrc`
  - `Common/vim` -> `~/.vim` (dir)

- You then need to run `:PlugInstall` in vim.
- And install the font, in `fonts` on your system.
- You can then install the mac terminal theme from the `themer/gen` folder

### Arch (most of the files are the same.)
Not fully working at the moment.
- Install `Oh-My-Zsh`
- Install `zsh-autosuggestions`
- Install `highligh`, `atool`, `w3m`, `mediainfo`
- Create symlinks

## Things
### zsh
`zshrc` the file for mac and linux are really the same, except the paths.
Which someone else would have to change anyway, because the don't have the same username as me (probably).
### tmux
`tmuxrc` the file for mac and linux are really the same, except the paths.
Which someone else would have to change anyway, because the don't have the same username as me (probably).
### vim
### bash
I use zsh now, so yeah.
### Hyper js
### bash
