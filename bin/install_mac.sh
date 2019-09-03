#!/bin/sh


/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"



ln -i tmux.conf ~/.tmux.conf
ln -i bashrc ~/.bashrc
ln -i vim/vimrc ~/.vimrc
ln -i Hyperterm/hyper.js ~/.hyper.js

ln -i Hyperterm/local ~/.hyper_plugins/local
