#!/bin/sh

echo "Install the dependencies and symlink the dotfiles"
tput setaf 4
echo "Install on wich system? Enter either \"mac\", \"debian\", \"arch\", \"fedora\":"
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

if [ $platform == "debian" ]; then
	./install/install_debian.sh
fi

if [ $platform == "fedora" ]; then
	./install/install_fedora.sh
fi
