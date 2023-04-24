#!/bin/bash

if [ "$1" == "inc" ]; then
    brightnessctl s +5%
fi

if [ "$1" == "dec" ]; then
    brightnessctl s 5%-
fi

BRIGHTNESS=$(brightnessctl g)
BRIGHTNESSMAX=$(brightnessctl m)
let fullb=BRIGHTNESS*100
let brightnessperc=fullb/BRIGHTNESSMAX
BRIGHTNESS=${brightnessperc%.*}
#NOTI_ID=$(notify-send.py "Brightness" "$BRIGHTNESS/100" \
#                         --hint string:image-path:video-display boolean:transient:true \
#                                int:has-percentage:$BRIGHTNESS \
#                         --replaces-process "brightness-popup")
#notify-send.py "Brightness" "$BRIGHTNESS%" --hint boolean:transient:true int:value:$BRIGHTNESS --replaces-process "brightness-popup"
echo $BRIGHTNESS > $2
