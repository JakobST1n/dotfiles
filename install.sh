#!/bin/bash

M4_DEF_FILE="system.m4"
echo "m4_define(\`DEFAULT_SHELL', \`/usr/bin/zsh')m4_dnl" > ${M4_DEF_FILE}
read -p "Enter dotfiles type: " dotfiles_type
echo "m4_define(\`DOTFILES_TYPE', \`${dotfiles_type}')m4_dnl" >> ${M4_DEF_FILE}
read -p "Enter git user: " git_user
echo "m4_define(\`GIT_USER', \`${git_user}')m4_dnl" >> ${M4_DEF_FILE}
read -p "Enter git email: " git_email
echo "m4_define(\`GIT_EMAIL', \`${git_email}')m4_dnl" >> ${M4_DEF_FILE}
read -p "Enter default editor: " default_editor
echo "m4_define(\`DEFAULT_EDITOR', \`${default_editor}')m4_dnl" >> ${M4_DEF_FILE}
read -p "Enter sysid: " sysid
echo "m4_define(\`SYSID', \`${sysid}')m4_dnl" >> ${M4_DEF_FILE}

if [ "$EUID" -eq 0 ]; then
    echo "Please don't run this as root, let sudo handle privilege escalation"
    exit 1
fi
if ! command -v sudo &> /dev/null; then
    echo "Could not find sudo, please make sure it is installed and set up correctly."
    exit
fi

case "$OSTYPE" in
    darwin*)
        echo "m4_define(\`OS_TYPE', \`macos')m4_dnl" >> ${M4_DEF_FILE}
        export INSTALLER_PM="brew"
        echo "Detected your OS as \"mac\"."
	    ./install/install_mac.sh
    ;;
    linux*)
        echo "m4_define(\`OS_TYPE', \`linux')m4_dnl" >> ${M4_DEF_FILE}
        echo "I detected that you are running linux, please enter your distro."
        tput setaf 4
        echo "Please enter: \"arch\", \"fedora\" or \"debian\""
        tput setaf 3
        printf "> "
        read distro
        printf "\n"
        tput sgr0

        if [ $distro == "arch" ]; then
            export INST_PM="sudo packman -S"
        elif [ $distro == "debian" ]; then
            export INST_PM="sudo apt-get -y install"
        elif [ $distro == "fedora" ]; then
            export INST_PM="sudo dnf -qy install"
        else
            echo "Unknown distro."
            echo "If you know what os you have, you can run the install script manually."
            echo "first run `export INST_PM=\"<sudo package-manager>\"` to indicate the package manager to the install script."
            exit 1
        fi

        ./install/install_linux.sh
    ;;
    *)
        echo "Unkown OS..."
        echo "If you know what os you have, you can run the install script manually."
        echo "first run `export INST_PM=\"<sudo package-manager>\"` to indicate the package manager to the install script."
    ;;
esac

make
