# Fix GTK+ application slow start
exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK

# screen locking
m4_changequote({, })m4_dnl
m4_ifelse(DT_SYSID, {1}, {m4_dnl
#exec swayidle -w \
#              timeout 300 'swaymsg "output * dpms off"' \
#              timeout 3600 physlock \
#              resume 'swaymsg "output * dpms on"' \
#              before-sleep physlock
#})m4_dnl
m4_changequote(`, ')m4_dnl

# notification centre
exec swaync

# system tray applets
exec blueman-applet
exec udiskie
exec nm-applet --indicator

# Wayland Overlay Bar, volume/brigtness bar
set $WOBSOCK $XDG_RUNTIME_DIR/wob.sock
exec rm -f $WOBSOCK && mkfifo $WOBSOCK && tail -f $WOBSOCK | wob

# use clipman for clipboard management
exec wl-paste -t text --watch clipman store --no-persist

# Nice color hues in the evenings
exec wlsunset -l 59.9614 -L 10.925 -t 4500 -T 6500 -g 1.0

# start nextcloud
exec_always nextcloud --background

# gnome keyring daemon
exec_always eval $(gnome-keyring-daemon --start)
exec_always export SSH_AUTH_SOCK

# IME
exec_always fcitx5 -d
