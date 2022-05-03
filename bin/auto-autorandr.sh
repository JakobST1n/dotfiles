#!/bin/bash

sleep 1
export DISPLAY=:0
export XAUTHORITY=`ls /run/user/1000/gdm/Xauthority`
su -c 'autorandr --change >> /tmp/autorandr.log 2>&1' jakob >> /tmp/auto_autorandr.log 2>&1
sleep 1
su -c 'wallpaper.sh' jakob
