M4 := m4
M4_OPTS := -P
M4_COMMON_DEPS = system.m4

define M4_EXEC
	${M4} ${M4_OPTS} $< > $@
endef

TARGETS := linux/tmux.conf                                                    \
		   Common/zshrc                                                       \
		   linux/qtile/config/config.py                                       \
		   linux/sway/autostart                                               \
		   linux/sway/hid

all: $(TARGETS)

linux/tmux.conf: linux/tmux.conf.m4                                           \
                 ${M4_COMMON_DEPS}
	$(call M4_EXEC)

Common/zshrc: Common/zshrc.m4                                                 \
              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

linux/qtile/config/config.py: linux/qtile/config/config.py.m4                 \
                              linux/qtile/config/screen.m4.py                 \
                              linux/qtile/config/group.m4.py                  \
                              linux/qtile/config/layout.m4.py                 \
                              linux/qtile/config/keys.m4.py                   \
                              ${M4_COMMON_DEPS}
	$(call M4_EXEC)

linux/sway/autostart: linux/sway/autostart.m4                                 \
                      ${M4_COMMON_DEPS}
	$(call M4_EXEC)

linux/sway/hid: linux/sway/hid.m4                                             \
                ${M4_COMMON_DEPS}
	$(call M4_EXEC)
