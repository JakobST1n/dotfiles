!#/bin/bash

#LAYOUT=$(setxkbmap -query)

setxkbmap -layout "$1"
notify-send.py "Keyboard layout: $1" 
