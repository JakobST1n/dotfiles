include autostart
include hid

# border & title
for_window [title="^.*"] title_format "<b> %class >> %title </b>"
for_window [floating] border 1, border normal
default_border pixel 2
default_floating_border normal
smart_borders on

client.focused          #4c7899 #539ce0    #ffffff #5fe327   #539ce0
client.focused_inactive #333333 #5f676a    #ffffff #484e50   #5f676a
client.unfocused        #333333 #222222    #888888 #292d2e   #222222

# gaps
gaps outer 0
gaps inner 0
smart_gaps off

# font
font pango:monospace 11

# mod key used for most binds
# Mod1 = Alt
# Mod4 = Super
set $Mod Mod4

# direction keys
set $up k
set $down j
set $left h
set $right l

### Turn off screen on lid closed
set $laptop eDP-1
bindswitch lid:on output $laptop disable
bindswitch lid:off output $laptop enable

#############         Bindings           ##################

# kill focused window
bindsym $Mod+Shift+q kill
bindsym Mod1+F4 kill

# core applications
bindsym $Mod+Return       exec alacritty
bindsym $Mod+w            exec firefox
bindsym $Mod+f            exec thunar
bindsym $Mod+c            exec swaync-client -t
bindsym Mod1+l            exec m4_ifelse(DT_SYSID, `2', `nwg-lock', physlock)
bindsym $Mod+d            exec wofi --show=drun

# Exit menu
bindsym $Mod+p exec wlogout

# Exit sway (default way to log you out of your Wayland session)
bindsym $Mod+Shift+e exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'

# screenshot
bindsym Print exec screenshot fullscreen
bindsym Control+Print exec screenshot display
bindsym Shift+Control+Print exec grim -g "$(slurp)" - | swappy -f -
bindsym $Mod+Shift+Control+Print exec screenshot focused

# audio
bindsym XF86AudioRaiseVolume exec amixer sset Master 5%+ | sed -En 's/.*\[([0-9]+)%\].*/\1/p' | head -1 > $WOBSOCK
bindsym XF86AudioLowerVolume exec amixer sset Master 5%- | sed -En 's/.*\[([0-9]+)%\].*/\1/p' | head -1 > $WOBSOCK
bindsym XF86AudioMute exec amixer sset Master toggle | sed -En '/\[on\]/ s/.*\[([0-9]+)%\].*/\1/ p; /\[off\]/ s/.*/0/p' | head -1 > $WOBSOCK
bindsym XF86AudioMicMute exec amixer set Capture toggle

# backlight
bindsym XF86MonBrightnessDown exec brightnessctl set 5%- | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK
bindsym XF86MonBrightnessUp exec brightnessctl set +5% | sed -En 's/.*\(([0-9]+)%\).*/\1/p' > $WOBSOCK

# Open wdisplays
bindsym XF86Display exec --no-startup-id "wdisplays"

# Reload the configuration file
bindsym $Mod+Shift+c reload

# Shortcut to tt gui
bindsym $Mod+Shift+Return exec /home/jakob/.local/bin/tt-g

# Keyboard layout
#bindsym $Mod+Shift+Space input "1:1:AT_Translated_Set_2_keyboard" xkb_switch_layout next


###########          Workspace Bindings          ###############

# switch to workspace
bindsym $Mod+1 workspace number 1
bindsym $Mod+2 workspace number 2
bindsym $Mod+3 workspace number 3
bindsym $Mod+4 workspace number 4
bindsym $Mod+5 workspace number 5
bindsym $Mod+6 workspace number 6
bindsym $Mod+7 workspace number 7
bindsym $Mod+8 workspace number 8
bindsym $Mod+9 workspace number 9

# switch to workspace - numpad alternatives
bindsym $Mod+Mod2+KP_1 workspace number 1
bindsym $Mod+Mod2+KP_2 workspace number 2
bindsym $Mod+Mod2+KP_3 workspace number 3
bindsym $Mod+Mod2+KP_4 workspace number 4
bindsym $Mod+Mod2+KP_5 workspace number 5
bindsym $Mod+Mod2+KP_6 workspace number 6
bindsym $Mod+Mod2+KP_7 workspace number 7
bindsym $Mod+Mod2+KP_8 workspace number 8
bindsym $Mod+Mod2+KP_9 workspace number 9

# switch to next or previous workspace
bindsym $Mod+Mod1+Left workspace prev
bindsym $Mod+Mod1+Right workspace next

# move focused container to workspace
bindsym $Mod+Shift+1 move container to workspace number 1; workspace number 1
bindsym $Mod+Shift+2 move container to workspace number 2; workspace number 2
bindsym $Mod+Shift+3 move container to workspace number 3; workspace number 3
bindsym $Mod+Shift+4 move container to workspace number 4; workspace number 4
bindsym $Mod+Shift+5 move container to workspace number 5; workspace number 5
bindsym $Mod+Shift+6 move container to workspace number 6; workspace number 6
bindsym $Mod+Shift+7 move container to workspace number 7; workspace number 7
bindsym $Mod+Shift+8 move container to workspace number 8; workspace number 8
bindsym $Mod+Shift+9 move container to workspace number 9; workspace number 9

# move focused container to workspace - numpad alternatives
bindsym $Mod+Shift+Mod2+KP_End   move container to workspace number 1; workspace number 1
bindsym $Mod+Shift+Mod2+KP_Down  move container to workspace number 2; workspace number 2
bindsym $Mod+Shift+Mod2+KP_Next  move container to workspace number 3; workspace number 3
bindsym $Mod+Shift+Mod2+KP_Left  move container to workspace number 4; workspace number 4
bindsym $Mod+Shift+Mod2+KP_Begin move container to workspace number 5; workspace number 5
bindsym $Mod+Shift+Mod2+KP_Right move container to workspace number 6; workspace number 7
bindsym $Mod+Shift+Mod2+KP_Home  move container to workspace number 7; workspace number 7
bindsym $Mod+Shift+Mod2+KP_Up    move container to workspace number 8; workspace number 8

############      Container/Window control  ############

# Scratchpad, Floating
bindsym $Mod+space floating toggle
floating_modifier $Mod normal

bindsym $Mod+Shift+t sticky toggle

# Sway has a "scratchpad", which is a bag of holding for windows.
# You can send windows there and get them back later.

# Move the currently focused window to the scratchpad
bindsym $Mod+Shift+z move scratchpad

# Show the next scratchpad window or hide the focused scratchpad window.
# If there are multiple scratchpad windows, this command cycles through them.
bindsym $Mod+z scratchpad show

# change focus
# bindsym $Mod+$left  focus left
# bindsym $Mod+$down  focus down
# bindsym $Mod+$up    focus up
# bindsym $Mod+$right focus right

# alternatively, you can use the cursor keys:
bindsym $Mod+Left   focus left
bindsym $Mod+Down   focus down
bindsym $Mod+Up     focus up
bindsym $Mod+Right  focus right

# move focused window
# bindsym $Mod+Shift+$left  move left
# bindsym $Mod+Shift+$down  move down
# bindsym $Mod+Shift+$up    move up
# bindsym $Mod+Shift+$right move right

# alternatively, you can use the cursor keys:
bindsym $Mod+Shift+Up    move up
bindsym $Mod+Shift+Down  move down
bindsym $Mod+Shift+Left  move left
bindsym $Mod+Shift+Right move right

# Resizing containers
mode "resize" {
    bindsym $left resize shrink width 10px
    bindsym $down resize grow height 10px
    bindsym $up resize shrink height 10px
    bindsym $right resize grow width 10px

    # Ditto, with arrow keys
    bindsym Left resize shrink width 10px
    bindsym Down resize grow height 10px
    bindsym Up resize shrink height 10px
    bindsym Right resize grow width 10px

    # Return to default mode
    bindsym Return mode "default"
    bindsym Escape mode "default"
}
bindsym $Mod+r mode "resize"

# Size
# bindsym Mod1+Up    resize shrink height 10 px or 1 ppt
# bindsym Mod1+Down  resize grow   height 10 px or 1 ppt
# bindsym Mod1+Left  resize shrink width  10 px or 1 ppt
# bindsym Mod1+Right resize grow   width  10 px or 1 ppt

# layout toggle
bindsym Mod1+Tab layout toggle splith splitv
bindsym $Mod+Tab layout toggle all

# switch to workspace with urgent window
for_window [urgent="latest"] focus
focus_on_window_activation   focus

# container layout
bindsym $Mod+h split h
bindsym $Mod+v split v
#bindsym $Mod+Shift+t layout tabbed
#bindsym $Mod+Shift+s layout stacking
#bindsym $Mod+Shift+h layout toggle split


default_orientation horizontal

# make the current focus fullscreen
bindsym $Mod+Shift+f fullscreen

###############      Border & Gaps     ###############

# changing border style
bindsym $Mod+b border toggle

############    bar settings   ############
bar {
    swaybar_command "waybar"
}

############    application settings   ############

# focus, floating, & sticky
for_window [app_id="(?i)(?:blueman-manager|azote|gnome-disks|Thunar|wdisplays)"] floating enable
for_window [app_id="(?i)(?:pavucontrol|nm-connection-editor|gsimplecal|galculator|gnome-calculator|calculator)"] floating enable
for_window [title="(?i)(?:copying|deleting|moving)"] floating enable
for_window [title="(?i)(?:Cssh|cssh)"] floating enable
for_window [app_id="(?i)(?:Cssh|cssh)"] floating enable
for_window [title="CSSH"] floating enable

# Make it easier to spot X11 windows
for_window [shell="xwayland"] title_format "[XWayland] %title"

popup_during_fullscreen smart
