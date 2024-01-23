#!/bin/bash

function dlgYN() {
    tput sc
    tput setaf 4
    printf "$1 (y/n)? "
    while :
    do
        read -n 1 -p "" YNQuestionAnswer
        if [[ $YNQuestionAnswer == "y" ]]; then
            tput rc; tput el
            printf "$1?: \e[0;32mYes\e[0m\n"
            tput sc
            eval $2=1 # Set parameter 2 of input to the return value
            break
        elif [[ $YNQuestionAnswer == "n" ]]; then
            tput rc; tput el
            printf "$1?: \e[0;31mNo\e[0m\n"
            eval $2=0 # Set parameter 2 of input to the return value
            break
        fi
    done
}

dlgYN "> Install \"Highlight, atool, w3m, mediainfo, vim, git\"" res
if [ $res -eq 1 ]; then
    tput sc
    $INST_PM highlight atool w3m mediainfo curl zsh vim git python3-pip zsh tmux nodejs
    tput rc; tput ed
fi

dlgYN "> Install Oh-My-Zsh" res
if [ $res -eq 1 ]; then
    tput sc
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    # Zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    # Zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    # Zsh-vi-mode
    git clone https://github.com/jeffreytse/zsh-vi-mode ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-vi-mode

    tput rc; tput ed
fi

dlgYN "> Install Powerline and Powerlevel10k" res
if [ $res -eq 1 ]; then
    tput sc
    pip3 install pygments
    pip3 install powerline-status
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    tput rc; tput ed
fi

dlgYN "> autorandr" res
if [ $res -eq 1 ]; then
    tput sc
    pip install autorandr
    tput rc; tput ed
fi

dlgYN "> Install greetd and tuigreet" res
if [ $res -eq 1 ]; then
    tput sc
    $INST_PM greetd
    sudo curl https://github.com/apognu/tuigreet/releases/download/0.8.0/tuigreet-0.8.0-x86_64 -o /usr/local/bin/tuigreet
    sudo chmod +x /usr/local/bin/tuigreet
    sudo cp /etc/greetd/config.toml /etc/greetd.config.toml.orig
    sudo ln -isf "$CWD/linux/greetd.toml" /etc/greetd/config.toml
    sudo systemctl enable greetd
    tput rc; tput ed
fi

dlgYN "> Install tlp" res
if [ $res -eq 1 ]; then
    tput sc
    $INST_PM tlp
    systemctl enable --now tlp
    tput rc; tput ed
fi

dlgYN "> Install sway" res
if [ $res -eq 1 ]; then
    tput sc
    $INST_PM sway swayidle physlock alacritty blueman network-manager-gnome wob wlogout wofi brightnessctl clipman
    tput rc; tput ed
fi

dlgYN "> Create symlinks" res
if [ $res -eq 1 ]; then
    CWD=$(pwd)
    tput sc
    ln -isf "$CWD/bin" ~/bin
    ln -isf "$CWD/linux/tmux.conf" ~/.tmux.conf
    ln -isf "$CWD/Common/zshrc" ~/.zshrc
    ln -isf "$CWD/Common/vimrc" ~/.vimrc
    ln -isf "$CWD/Common/vim" ~/.vim
    ln -isf "$CWD/Common/p10k.zsh" ~/.p10k.zsh
    ln -isf "$CWD"/Common/i3/config/* ~/.config/
    ln -isf "$CWD/Common/i3/urxvt" ~/.urxvt
    ln -isf "$CWD/Common/i3/Xresources" ~/.Xresources
    ln -isf "$CWD/Common/i3/xsettingsd" ~/.xsettingsd
    ln -isf "$CWD/Common/rofi" ~/.config/rofi
    ln -isf "$CWD/Common/deadd" ~/.config/deadd
    ln -isf "$CWD/Common/nvim" ~/.config/nvim
    ln -isf "$CWD/Common/sway" ~/.config/sway
    ln -isf "$CWD/Common/waybar" ~/.config/waybar
    ln -isf "$CWD/Common/foot" ~/.config/foot
    ln -isf "$CWD/Common/alacritty" ~/.config/alacritty
    ln -isf "$CWD/Common/powerline_config" ~/.config/powerline
    ln -isf "$CWD/Common/sxhkd" ~/.config/sxhkd
    ln -isf "$CWD/Common/bspwm" ~/.config/bspwm
    ln -isf "$CWD/Common/polybar" ~/.config/polybar
    tput rc; tput ed
fi

tput setaf 3
echo "\nPlease install the font Roboto mono nerd, and enable it in your terminal."
echo "\nPlease run ':PlugInstall' in vim"
echo "\nTo to start greetd, reboot system"
tput sgr0
