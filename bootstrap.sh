#!/bin/bash

echo "Initializing repo"

PKGS=(m4 make git)
echo "Waiting for required commands: ${PKGS[*]}"
for cmd in "${PKGS[@]}"; do
  until command -v "$cmd" >/dev/null 2>&1; do
    echo "  $cmd not yet available, waiting..."
    sleep 5
  done
done
echo "All required commands available."

mkdir -p "$HOME/.config/coderv2/dotfiles"

cat > "$HOME/.config/coderv2/dotfiles/config" <<EOF
DT_ALACRITTY=no
DT_AUTORANDR=no
DT_BASH=yes
DT_BSPWM=no
DT_DEADD=no
DT_DISTRO=debian
DT_DOTFILES_DIR=$HOME/.config/coderv2/dotfiles
DT_DOTFILES_TYPE=remote
DT_EDITOR=nvim
DT_FOOT=no
DT_GIT_EMAIL=${GIT_AUTHOR_EMAIL:-$(git config user.email)}
DT_GIT_USER=${GIT_AUTHOR_NAME:-$(git config user.name)}
DT_GOTIFY_TOKEN=NA
DT_GOTIFY_URL=NA
DT_GREETD_TUIGREET=no
DT_HOMEBIN=yes
DT_HOME_DIRECTORY=$HOME
DT_I3=no
DT_INPUTRC=yes
DT_MYCLI=no
DT_NEOVIM=yes
DT_NEWSBOAT=no
DT_OS=linux
DT_OTHER_SYMLINKS=yes
DT_POWERLINE=no
DT_POWERLINE_P10K=no
DT_QTILE=no
DT_ROFI=no
DT_SHELL=/bin/bash
DT_SWAY=no
DT_SXHKD=no
DT_SYSID=1
DT_TLP=no
DT_TMUX=yes
DT_TOOLS=yes
DT_VIM=yes
DT_WAYBAR=no
DT_ZSH=no
EOF

cd $HOME/.config/coderv2/dotfiles
m4 -P Makefile.m4 > Makefile
make
