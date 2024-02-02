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
    $INST_PM highlight atool w3m mediainfo curl zsh vim git python3-pip zsh tmux nodejs catimg ripgrep silversearcher-ag
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
    if [ "$distro" == "fedora" ]; then
        $INST_PM sway swayidle  alacritty blueman wob wlogout wofi brightnessctl clipman xwayland seahorse fcitx5 im-config
    else
        $INST_PM sway swayidle physlock alacritty blueman network-manager-gnome wob wlogout wofi brightnessctl clipman xwayland seahorse fcitx5 imsettings
    fi
    tput rc; tput ed
fi

dlgYN "> Create symlinks" res
if [ $res -eq 1 ]; then
    function createOrUpdateSymlink() {
        if [ -L "$2" ]; then
            unlink $2
        fi
        if [ -e "$2" ]; then
            echo "Directory $2 exists already!"
            return
        fi
        ln -isf "$1" "$2"
    }

    CWD=$(pwd)
    tput sc
    createOrUpdateSymlink "$CWD/bin" ~/bin
    createOrUpdateSymlink "$CWD/Common/zshrc" ~/.zshrc
    createOrUpdateSymlink "$CWD/Common/vimrc" ~/.vimrc
    createOrUpdateSymlink "$CWD/Common/vim" ~/.vim
    createOrUpdateSymlink "$CWD/Common/nvim" ~/.config/nvim
    createOrUpdateSymlink "$CWD/Common/p10k.zsh" ~/.p10k.zsh
    createOrUpdateSymlink "$CWD/linux/tmux.conf" ~/.tmux.conf
    createOrUpdateSymlink "$CWD"/linux/i3/config/* ~/.config/
    createOrUpdateSymlink "$CWD/linux/i3/urxvt" ~/.urxvt
    createOrUpdateSymlink "$CWD/linux/i3/Xresources" ~/.Xresources
    createOrUpdateSymlink "$CWD/linux/i3/xsettingsd" ~/.xsettingsd
    createOrUpdateSymlink "$CWD/linux/rofi" ~/.config/rofi
    createOrUpdateSymlink "$CWD/linux/deadd" ~/.config/deadd
    createOrUpdateSymlink "$CWD/linux/sway" ~/.config/sway
    createOrUpdateSymlink "$CWD/linux/waybar" ~/.config/waybar
    createOrUpdateSymlink "$CWD/linux/foot" ~/.config/foot
    createOrUpdateSymlink "$CWD/linux/alacritty" ~/.config/alacritty
    createOrUpdateSymlink "$CWD/linux/powerline_config" ~/.config/powerline
    createOrUpdateSymlink "$CWD/linux/sxhkd" ~/.config/sxhkd
    createOrUpdateSymlink "$CWD/linux/bspwm" ~/.config/bspwm
    createOrUpdateSymlink "$CWD/linux/polybar" ~/.config/polybar
    tput rc; tput ed
fi

tput setaf 3
echo "\nPlease install the font Roboto mono nerd, and enable it in your terminal."
echo "\nPlease run ':PlugInstall' in vim"
echo "\nTo to start greetd, reboot system"
tput sgr0
