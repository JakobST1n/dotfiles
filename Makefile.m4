CONFIG_FILE := config
M4 := m4
M4_OPTS := -P
M4_SYSFILE := system.m4
M4_COMMON_DEPS = $(M4_SYSFILE)
SRC_DIR := DT_DOTFILES_DIR
HOME_DIR := DT_HOME_DIRECTORY

.PHONY: install_packages install_cargo_packages install_pip_packages update_packages update

define M4_EXEC
	echo "`m4_include'(\``system.m4'')`m4_dnl'" | cat - $< | ${M4} ${M4_OPTS} > $@
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

all: system.m4 install_packages m4_dnl
m4_ifelse(DT_VIM,            `yes', `$(HOME_DIR)/.vimrc') m4_dnl
m4_ifelse(DT_ROFI,           `yes', `$(HOME_DIR)/.config/rofi') m4_dnl
m4_ifelse(DT_DEADD,          `yes', `$(HOME_DIR)/.config/deadd') m4_dnl
m4_ifelse(DT_WAYBAR,         `yes', `$(HOME_DIR)/.config/waybar') m4_dnl
m4_ifelse(DT_FOOT,           `yes', `$(HOME_DIR)/.config/foot') m4_dnl
m4_ifelse(DT_POWERLINE,      `yes', `$(HOME_DIR)/.config/powerline') m4_dnl
m4_ifelse(DT_SXHKD,          `yes', `$(HOME_DIR)/.config/sxhkd') m4_dnl
m4_ifelse(DT_BSPWM,          `yes', `$(HOME_DIR)/.config/bspwm') m4_dnl
m4_ifelse(DT_INPUTRC,        `yes', `$(HOME_DIR)/.inputrc') m4_dnl
m4_ifelse(DT_HOMEBIN,        `yes', `$(HOME_DIR)/bin') m4_dnl
m4_ifelse(DT_ZSH,            `yes', `$(HOME_DIR)/.zshrc') m4_dnl
m4_ifelse(DT_ZSH,            `yes', `$(HOME_DIR)/.p10k.zsh') m4_dnl
m4_ifelse(DT_BASH,           `yes', `$(HOME_DIR)/.bashrc') m4_dnl
m4_ifelse(DT_TMUX,           `yes', `$(HOME_DIR)/.tmux.conf') m4_dnl
m4_ifelse(DT_QTILE,          `yes', `$(HOME_DIR)/.config/qtile/config.py') m4_dnl
m4_ifelse(DT_SWAY,           `yes', `$(HOME_DIR)/.config/sway/config') m4_dnl
m4_ifelse(DT_SWAY,           `yes', `$(HOME_DIR)/.config/sway/hid') m4_dnl
m4_ifelse(DT_SWAY,           `yes', `$(HOME_DIR)/.config/sway/autostart') m4_dnl
m4_ifelse(DT_NEOVIM,         `yes', `$(HOME_DIR)/.config/nvim') m4_dnl
m4_ifelse(DT_MYCLI,          `yes', `$(HOME_DIR)/.my.cnf') m4_dnl
m4_ifelse(DT_MYCLI,          `yes', `$(HOME_DIR)/.myclirc') m4_dnl
m4_ifelse(DT_NEWSBOAT,       `yes', `$(HOME_DIR)/.newsboat') m4_dnl
m4_ifelse(DT_ALACRITTY,      `yes', `$(HOME_DIR)/.config/alacritty') m4_dnl


$(M4_SYSFILE): $(CONFIG_FILE)
	@echo "Generating $(M4_SYSFILE) from $(CONFIG_FILE)"
	@> $(M4_SYSFILE)
	@while IFS='=' read -r key value; do \
		echo "`m4_define'(\``$$key'', \``$$value'')`m4_dnl'" >> $(M4_SYSFILE); \
	done < $(CONFIG_FILE)

Makefile: Makefile.m4 $(M4_SYSFILE)
	$(call M4_EXEC)

m4_ifelse(DT_VIM, `yes', `m4_dnl
$(HOME_DIR)/.vimrc: Common/vimrc
	$(call create_dotfile_symlink,Common/vimrc,.vimrc)

')m4_dnl
m4_ifelse(DT_ROFI, `yes', `m4_dnl
$(HOME_DIR)/.config/rofi: linux/rofi
	$(call create_dotfile_symlink,linux/rofi,.config/rofi)

')m4_dnl
m4_ifelse(DT_DEADD, `yes', `m4_dnl
$(HOME_DIR)/.config/deadd: linux/deadd/
	$(call create_dotfile_symlink,linux/deadd,.config/deadd)

')m4_dnl
m4_ifelse(DT_WAYBAR, `yes', `m4_dnl
$(HOME_DIR)/.config/waybar: linux/waybar
	$(call create_dotfile_symlink,linux/waybar,.config/waybar)

')m4_dnl
m4_ifelse(DT_FOOT, `yes', `m4_dnl
$(HOME_DIR)/.config/foot: linux/foot
	$(call create_dotfile_symlink,linux/foot,.config/foot)

')m4_dnl
m4_ifelse(DT_POWERLINE, `yes', `m4_dnl
$(HOME_DIR)/.config/powerline: linux/powerline_config
	$(call create_dotfile_symlink,linux/powerline_config,.config/powerline)

')m4_dnl
m4_ifelse(DT_SXHKD, `yes', `m4_dnl
$(HOME_DIR)/.config/sxhkd: linux/sxhkd
	$(call create_dotfile_symlink,linux/sxhkd,.config/sxhkd)

')m4_dnl
m4_ifelse(DT_BSPWM, `yes', `m4_dnl
$(HOME_DIR)/.config/bspwm: linux/bspwm
	$(call create_dotfile_symlink,linux/bspwm,.config/bspwm)

')m4_dnl
m4_ifelse(DT_HOMEBIN, `yes', `m4_dnl
M4_BINFILES := $(patsubst bin/%.m4,bin/%,$(wildcard bin/*.m4))

$(HOME_DIR)/bin: bin ${M4_BINFILES}
	$(call create_dotfile_symlink,bin,bin)

bin/%: bin/%.m4                                                              \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)
	chmod +x $@

')m4_dnl
m4_ifelse(DT_BASH, `yes', `m4_dnl
Common/bashrc: Common/bashrc.m4                                                 \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.bashrc: Common/bashrc
	$(call create_dotfile_symlink,Common/bashrc,.bashrc)

$(HOME_DIR)/.inputrc: linux/inputrc 
	$(call create_dotfile_symlink,linux/inputrc,.inputrc)

')m4_dnl
m4_ifelse(DT_ZSH, `yes', `m4_dnl
Common/zshrc: Common/zshrc.m4                                                 \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.zshrc: Common/zshrc
	$(call create_dotfile_symlink,Common/zshrc,.zshrc)

m4_ifelse(DT_ZSH, `yes', `m4_dnl
$(HOME_DIR)/.p10k.zsh: 
	$(call create_dotfile_symlink,Common/p10k.zsh,.p10k.zsh)

')m4_dnl
')m4_dnl
m4_ifelse(DT_TMUX, `yes', `m4_dnl
linux/tmux.conf: linux/tmux.conf.m4                                           \
                 ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.tmux.conf: linux/tmux.conf
	$(call create_dotfile_symlink,linux/tmux.conf,.tmux.conf)

')m4_dnl
m4_ifelse(DT_SWAY, `yes', `m4_dnl
linux/sway/%: linux/sway/%.m4                                                 \
                      ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.config/sway/%: linux/sway/config linux/sway/hid linux/sway/autostart
	$(call create_symlink,${SRC_DIR}/linux/sway,$(HOME_DIR)/.config/sway)

')m4_dnl
m4_ifelse(DT_QTILE, `yes', `m4_dnl
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
m4_ifelse(DT_NEOVIM, `yes', `m4_dnl
/usr/local/bin/nvim:
	git clone https://github.com/neovim/neovim /tmp/neovim
	git -C /tmp/neovim checkout tags/v0.9.0
	(cd /tmp/neovim && sudo make install)

$(HOME_DIR)/.config/nvim/: /usr/local/bin/nvim
	$(call create_symlink,$(SRC_DIR)/Common/nvim,$(HOME_DIR)/.config/nvim)

')m4_dnl
m4_ifelse(DT_HELIX, `yes', `m4_dnl
$(HOME_DIR)/.config/helix: Common/helix
	$(call create_dotfile_symlink,Common/helix,.config/helix)

')m4_dnl
m4_ifelse(DT_MYCLI, `yes', `m4_dnl
$(HOME_DIR)/.my.cnf: Common/my.cnf
	$(call create_dotfile_symlink,Common/my.cnf,.my.cnf)

$(HOME_DIR)/.myclirc: Common/myclirc
	$(call create_dotfile_symlink,Common/myclirc,.myclirc)

')m4_dnl
m4_ifelse(DT_NEWSBOAT, `yes', `m4_dnl
Common/newsboat/config: Common/newsboat/config.m4                                                 \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

$(HOME_DIR)/.newsboat: Common/newsboat Common/newsboat/config
	$(call create_dotfile_symlink,Common/newsboat,.newsboat)

')m4_dnl
m4_ifelse(DT_ALACRITTY, `yes', `m4_dnl
$(HOME_DIR)/.config/alacritty: linux/alacritty
	$(call create_dotfile_symlink,linux/alacritty,.config/alacritty)

')m4_dnl
# General package manager stuff
m4_ifelse(DT_DISTRO, `debian', `m4_dnl
DPKG_DEPENDENCIES := m4_dnl
m4_ifelse(DT_TOOLS, `yes', `highlight atool w3m mediainfo curl zsh vim git python3-pip zsh tmux nodejs catimg ripgrep silversearcher-ag',) m4_dnl
m4_ifelse(DT_GREETD_TUIGREET, `yes', `greetd',) m4_dnl
m4_ifelse(DT_TLP, `yes', `tlp',) m4_dnl
m4_dnl
m4_ifelse(DT_SWAY, `yes', `sway swayidle physlock blueman network-manager-gnome wob wlogout wofi brightnessctl clipman xwayland seahorse fcitx5',) m4_dnl
m4_dnl
m4_ifelse(DT_QTILE, `yes', `python3-cffi python3-cairocffi pango pango-devel python3-dbus-next',) m4_dnl qtile core
m4_ifelse(DT_QTILE, `yes', `python3_xcffib xsecurelock',) m4_dnl qtile x11
m4_ifelse(DT_QTILE, `yes', `wlroots python3-wlroots python3-pywayland python3-xkbcommon xwayland',) m4_dnl qtile wayland


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
')m4_dnl

m4_ifelse(DT_DISTRO, `fedora', `m4_dnl
DPKG_DEPENDENCIES := m4_dnl
m4_ifelse(DT_TOOLS, `yes', `highlight atool w3m mediainfo curl zsh vim-enhanced git python3-pip zsh tmux nodejs catimg ripgrep the_silver_searcher',) m4_dnl
m4_ifelse(DT_GREETD_TUIGREET, `yes', `greetd',) m4_dnl
m4_ifelse(DT_TLP, `yes', `tlp',) m4_dnl
m4_ifelse(DT_MYCLI, `yes', `mycli pspg',) m4_dnl
m4_dnl
m4_ifelse(DT_SWAY, `yes', `sway swayidle blueman wob wlogout wofi brightnessctl clipman seahorse fcitx5 imsettings',) m4_dnl
m4_dnl
m4_ifelse(DT_QTILE, `yes', `python3-cffi python3-cairocffi pango pango-devel python3-dbus-next',) m4_dnl qtile core
m4_ifelse(DT_QTILE, `yes', `python3-xcffib xsecurelock',) m4_dnl qtile x11
m4_ifelse(DT_QTILE, `yes', `wlroots python3-pywayland python3-xkbcommon',) m4_dnl qtile wayland


install_packages:
	@missing_packages=""; \
	for pkg in $(DPKG_DEPENDENCIES); do \
		if ! rpm -q "$$pkg" >/dev/null 2>&1; then \
			missing_packages="$$missing_packages $$pkg"; \
		fi; \
	done; \
	if [ -n "$$missing_packages" ]; then \
		echo "Installing missing packages: $$missing_packages"; \
		sudo dnf install -y $$missing_packages; \
	fi

update_packages:
	@echo "Updating all packages..."
	sudo dnf upgrade -y $(DPKG_DEPENDENCIES)
')m4_dnl
# Global pip packages
PIP := pip
PIP_FLAGS := m4_ifelse(DT_DISTRO, `debian', `--break-system-packages')
PIP_DEPENDENCIES := m4_dnl
m4_ifelse(DT_QTILE, `yes', `qtile qtile_extras',) m4_dnl qtile core


install_pip_packages:
	@missing_packages=""; \
	for pkg in $(PIP_DEPENDENCIES); do \
		if [ "$($PIP list | grep -sw "$$pkg" | wc -l)" = "0" ]; then \
			missing_packages="$$missing_packages $$pkg"; \
		fi; \
	done; \
	if [ -n "$$missing_packages" ]; then \
		echo "Installing missing packages: $$missing_packages"; \
		sudo $PIP $PIP_FLAGS install $$missing_packages; \
	fi

# Global rust packages
DT_HOME_DIRECTORY/.cargo/bin/cargo:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

CARGO := cargo
CARGO_FLAGS := 
CARGO_DEPENDENCIES := m4_dnl
m4_ifelse(DT_ALACRITTY, `yes', `alacritty',)

install_cargo_packages: DT_HOME_DIRECTORY/.cargo/bin/cargo
	@missing_packages=""; \
	for pkg in $(CARGO_DEPENDENCIES); do \
		if [ "$($$CARGO install --list | grep -sw "$$pkg" | wc -l)" = "0" ]; then \
			missing_packages="$$missing_packages $$pkg"; \
		fi; \
	done; \
	if [ -n "$$missing_packages" ]; then \
		echo "Installing missing packages: $$missing_packages"; \
		sudo $CARGO $CARGO_FLAGS install $$missing_packages; \
	fi
