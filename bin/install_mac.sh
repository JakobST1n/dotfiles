#!/bin/sh

echo "> Install Homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "> Install \"Highlight, atool, w3m, mediainfo\""
bew install highlight atool w3m mediainfo

echo "> Install Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "> Install zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "> Install powerlevel9k"
brew tap sambadevi/powerlevel9k

echo "> Install our dotfiles"
ln -i mac/zshrc ~/.zshrc
ln -i mac/tmux.conf ~/.tmux.conf
ln -i mac/Hyperterm/hyper.js ~/.hyper.js
ln -i mac/Hyperterm/local/ ~/.hyper_plugins/local/

echo "\nPlease install the font Roboto mono nerd, and enable it in your terminal."
