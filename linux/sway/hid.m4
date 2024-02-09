m4_include(`system.m4')m4_dnl

output eDP-1 {
    scale m4_ifelse(SYSID, `1', `1.4', `1.0')
}

input "type:keyboard" {
  xkb_layout us,no
  repeat_delay 300
  repeat_rate 40
  xkb_capslock disabled
  xkb_numlock disabled
}

input "type:touchpad" {
  pointer_accel 0.0
  natural_scroll enabled
  scroll_factor 1.0
  scroll_method two_finger
  left_handed disabled
  tap enabled
  tap_button_map lrm
  drag enabled
  drag_lock disabled
  dwt enabled
  middle_emulation enabled
}

input "type:pointer" {
  natural_scroll disabled
  scroll_factor 1.0
  left_handed disabled
}
