m4_include(`system.m4')m4_dnl
M4 := m4
M4_OPTS := -P
M4_COMMON_DEPS = system.m4
SRC_DIR := DOTFILES_DIR
HOME_DIR := HOME_DIRECTORY

.PHONY: install_packages update_packages

define M4_EXEC
	${M4} ${M4_OPTS} $< > $@
endef

define create_symlink
@if [ ! -L "$(2)" ]; then \
    echo "Creating new symlink $(2) -> $(1)"; \
    ln -isf $(1) $(2); \
elif [ "$$(readlink $(2))" != "$(1)" ]; then \
    echo "Symlink exists but points to a different source. Updating symlink $(2) -> $(1)"; \
    ln -sf $(1) $(2); \
fi
endef

define create_dotfile_symlink
	$(call create_symlink,${SRC_DIR}/$(1),${HOME_DIR}/$(2))
endef

all: install_packages m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.vimrc') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.vim') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/rofi') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/deadd') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/waybar') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/foot') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/alacritty') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/powerline') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/sxhkd') m4_dnl
m4_ifdef(`DT_OTHER_SYMLINKS', `$(HOME_DIR)/.config/bspwm') m4_dnl
m4_ifdef(`DT_HOMEBIN', `$(HOME_DIR)/bin') m4_dnl
m4_ifdef(`DT_ZSH', `$(HOME_DIR)/.zshrc') m4_dnl
m4_ifdef(`DT_ZSH', `$(HOME_DIR)/.p10k.zsh') m4_dnl
m4_ifdef(`DT_BASH', `$(HOME_DIR)/.bashrc') m4_dnl
m4_ifdef(`DT_TMUX', `$(HOME_DIR)/.tmux.conf') m4_dnl
m4_ifdef(`DT_QTILE', `$(HOME_DIR)/.config/qtile/config.py') m4_dnl
m4_ifdef(`DT_SWAY', `$(HOME_DIR)/.config/sway/config') m4_dnl
m4_ifdef(`DT_SWAY', `$(HOME_DIR)/.config/sway/hid') m4_dnl
m4_ifdef(`DT_SWAY', `$(HOME_DIR)/.config/sway/autostart') m4_dnl
m4_ifdef(`DT_NEOVIM', `$(HOME_DIR)/.config/nvim') m4_dnl


m4_ifdef(`DT_OTHER_SYMLINKS', `m4_dnl
$(HOME_DIR)/.vimrc: Common/vimrc
	$(call create_dotfile_symlink,Common/vimrc,.vimrc)

$(HOME_DIR)/.vim: Common/vim
	$(call create_dotfile_symlink,Common/vim,.vim)

$(HOME_DIR)/.config/rofi: linux/rofi
	$(call create_dotfile_symlink,linux/rofi,.config/rofi)

$(HOME_DIR)/.config/deadd: linux/deadd/
	$(call create_dotfile_symlink,linux/deadd,.config/deadd)

$(HOME_DIR)/.config/waybar: linux/waybar
	$(call create_dotfile_symlink,linux/waybar,.config/waybar)

$(HOME_DIR)/.config/foot: linux/foot
	$(call create_dotfile_symlink,linux/foot,.config/foot)

$(HOME_DIR)/.config/alacritty: linux/alacritty
	$(call create_dotfile_symlink,linux/alacritty,.config/alacritty)

$(HOME_DIR)/.config/powerline: linux/powerline_config
	$(call create_dotfile_symlink,linux/powerline_config,.config/powerline)

$(HOME_DIR)/.config/sxhkd: linux/sxhkd
	$(call create_dotfile_symlink,linux/sxhkd,.config/sxhkd)

$(HOME_DIR)/.config/bspwm: linux/bspwm
	$(call create_dotfile_symlink,linux/bspwm,.config/bspwm)
')

m4_ifdef(`DT_HOMEBIN', `m4_dnl
$(HOME_DIR)/bin: bin
	$(call create_dotfile_symlink,bin,bin)
')

m4_ifdef(`DT_BASH', `m4_dnl
Common/bashrc: Common/bashrc.m4                                                 \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.bashrc: Common/bashrc
	$(call create_dotfile_symlink,Common/bashrc,.bashrc)
')

m4_ifdef(`DT_ZSH', `m4_dnl
Common/zshrc: Common/zshrc.m4                                                 \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.zshrc: Common/zshrc
	$(call create_dotfile_symlink,Common/zshrc,.zshrc)

m4_ifdef(`DT_ZSH', `m4_dnl
$(HOME_DIR)/.p10k.zsh: Common/vim
	$(call create_dotfile_symlink,Common/p10k.zsh,.p10k.zsh)
')
')

m4_ifdef(`DT_TMUX', `m4_dnl
linux/tmux.conf: linux/tmux.conf.m4                                           \
                 ${M4_COMMON_DEPS}
	$(call M4_EXEC)
	$(call create_symlink,$(SRC_DIR)/Common/nvim,$(HOME_DIR)/.config/nvim)

$(HOME_DIR)/.tmux.conf: linux/tmux.conf
	$(call create_dotfile_symlink,linux/tmux.conf,.tmux.conf)
')

m4_ifdef(`DT_SWAY', `m4_dnl
linux/sway/%: linux/sway/%.m4                                                 \
                      ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.config/sway/%: linux/sway/config linux/sway/hid linux/sway/autostart
	$(call create_symlink,${SRC_DIR}/linux/sway,$(HOME_DIR)/.config/sway)

')m4_dnl

m4_ifdef(`DT_QTILE', `m4_dnl
linux/qtile/config/config.py: linux/qtile/config/config.py.m4                 \
                              linux/qtile/config/screen.m4.py                 \
                              linux/qtile/config/group.m4.py                  \
                              linux/qtile/config/layout.m4.py                 \
                              linux/qtile/config/keys.m4.py                   \
                              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.config/qtile/config.py: linux/qtile/config/config.py
	$(call create_symlink,$(SRC_DIR)/linux/qtile/config/,$(HOME_DIR)/.config/qtile/)
	sudo cp linux/qtile/qtile.desktop /usr/share/xsessions/qtile.desktop
	sudo cp linux/qtile/qtile-wayland.desktop /usr/share/wayland-sessions/qtile-wayland.desktop
')m4_dnl

m4_ifdef(`DT_NEOVIM', `m4_dnl
/usr/local/bin/nvim:
	git clone https://github.com/neovim/neovim /tmp/neovim
	git -C /tmp/neovim checkout tags/v0.9.5
	(cd /tmp/neovim && sudo make install)

$(HOME_DIR)/.config/nvim/: /usr/local/bin/nvim
	$(call create_symlink,$(SRC_DIR)/Common/nvim,$(HOME_DIR)/.config/nvim)
')m4_dnl

# Genereal package manager stuff
m4_ifelse(DISTRO, `debian', m4_dnl
DPKG_DEPENDENCIES := m4_dnl
m4_ifdef(`DT_TOOLS', `highlight atool w3m mediainfo curl zsh vim git python3-pip zsh tmux nodejs catimg ripgrep silversearcher-ag',) m4_dnl
m4_ifdef(`DT_GREETD_TUIGREET', `greetd',) m4_dnl
m4_ifdef(`DT_TLP', `tlp',) m4_dnl
m4_dnl
m4_ifdef(`DT_SWAY', `sway swayidle physlock alacritty blueman network-manager-gnome wob wlogout wofi brightnessctl clipman xwayland seahorse fcitx5',) m4_dnl
m4_dnl
m4_ifdef(`DT_QTILE', `python3-cffi python3-cairocffi pango pango-devel python3-dbus-next',) m4_dnl qtile core
m4_ifdef(`DT_QTILE', `python3_xcffib xsecurelock',) m4_dnl qtile x11
m4_ifdef(`DT_QTILE', `wlroots python3-wlroots python3-pywayland python3-xkbcommon xwayland',) m4_dnl qtile wayland


install_packages:
	@missing_packages=""; \
	for pkg in $(DPKG_DEPENDENCIES); do \
		if ! dpkg -s "$$pkg" >/dev/null 2>&1; then \
			missing_packages="$$missing_packages $$pkg"; \
		fi; \
	done; \
	if [ -n "$$missing_packages" ]; then \
		echo "Installing missing packages: $$missing_packages"; \
		sudo apt-get update; \
		sudo apt-get install -y $$missing_packages; \
	fi

update_packages:
	@echo "Updating all packages..."
	sudo apt-get update
	sudo apt-get upgrade -y $(DPKG_DEPENDENCIES)
)m4_dnl

