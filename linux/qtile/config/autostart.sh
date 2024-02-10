#!/bin/sh
nm-applet &
echo "Starting blueman-applet"
blueman-applet &
echo "Starting udiskie"
udiskie &
echo "Starting fcitx5"
fcitx5 -d &
echo "Starting nextcloud"
nextcloud --background &
