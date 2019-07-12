echo "Install Oh-My-Zsh"
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

echo "Install zsh-autosuggestions"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Install powerlevel9k"
sudo pacman -S zsh-theme-powerlevel9k

sudo pacman -S highlight atool w3m mediainfo

ln -i zshrc ~/.zshrc


echo "Please install the font Roboto mono nerd, and enable it in your terminal."
