This is just all my dotfiles, do what you want with them. 

Personally i use to pull this repo and install them all, but you can use them for inspiration or whatever you want.

I only use mac and fedora atm (arch is still pretty much the same), and i haven't fiddled with windows files for the past few years.


Run `./install.sh` as your main user (__NOT AS ROOT__, sudo has to be installed and is used for privilege escalation).
You will then be asked for which os/distro you are using, and then it will ask you for each install-step if you want
to install that part or not.

## Installer
This should be the steps for all os', but it might not be updated for all the installers.
(The last time i wrote in this readme the fedora and mac scripts were up to date)
- Install `homebrew` on mac
- Install `highlight`, `atool`, `w3m`, `mediainfo`, `vim`, `git`, `zsh`, `tmux`
- Install `Oh-My-Zsh`, `zsh-autosuggestions`, `zsh-syntax-highlighting`
- Install `Powerline`, `Powerlevel10k`
- Create symlinks for dotfiles and folders.

- You then need to run `:PlugInstall` in vim.
- And install the font, in `fonts` on your system.
- You can then install the mac terminal theme from the `themer/gen` folder if you want
