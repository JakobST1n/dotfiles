#!/bin/sh

echo "Install the dependencies and symlink the dotfiles"
tput setaf 4
echo "Install on wich system? Enter either \"mac\", \"arch\":"
tput setaf 3
printf "> "
read platform
printf "\n"
tput sgr0

if [ $platform == "mac" ]; then
	./install/install_mac.sh
fi

if [ $platform == "arch" ]; then
	./install/install_arch.sh
fi
