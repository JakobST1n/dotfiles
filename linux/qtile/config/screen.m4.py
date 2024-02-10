from Xlib import display as xdisplay

def get_monitors():
  display = xdisplay.Display()
  screen = display.screen()
  resources = screen.root.xrandr_get_screen_resources()
  return [display.xrandr_get_output_info(output, resources.config_timestamp)
          for output in resources.outputs]


# See https://github.com/qtile/qtile/wiki/screens
def get_num_monitors():
    num_monitors = 0
    try:
        for monitor in get_monitors():
            preferred = False
            if hasattr(monitor, 'preferred'):
                preferred = monitor.preferred
            elif hasattr(monitor, 'num_preferred'):
                preferred = monitor.num_preferred
            if preferred:
                num_monitors += 1
    except Exception as e:
        logger.error(e)
        # always setup at least one monitor
        return 1
    else:
        return num_monitors


widget_defaults = dict(
    font="sans",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()
widget_systray = widget.Systray()
widget_pomodoro = widget.Pomodoro()

def get_widgets(systray: bool = False):
    w = list()
    w.append(widget.CurrentLayout())
    w.append(widget.GroupBox(
        highlight_method="line",
        hide_unused=True,
    ))
    w.append(widget.Prompt())
    w.append(widget.Chord(
        chords_colors={
            "launch": ("#ff0000", "#ffffff"),
        },
        name_transform=lambda name: name.upper(),
    ))

    w.append(widget.Spacer())
    w.append(widget.Clock(format="%H:%M (%d-%m-%Y)"))
    w.append(widget.Spacer())

    w.append(widget.Notify())
    w.append(widget.Sep())
    w.append(widget_pomodoro)
    w.append(widget.Sep())
    w.append(widget.Volume())
    w.append(widget.Sep())
    w.append(UPowerWidget())
    w.append(widget.Sep())

    # NB Systray is incompatible with Wayland, consider using StatusNotifier instead
    #w.append(widget.StatusNotifier())
    if systray:
        global widget_systray
        w.append(widget_systray)
    #w.append(widget.QuickExit())
    return w

def make_bar(systray: bool = False):
    return bar.Bar(
        get_widgets(systray),
        24,
        background="#2b303b",
        # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
        # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
    )

def make_screen(systray: bool = False):
    return Screen(
       top=make_bar(systray),
       # you can uncomment this variable if you see that on x11 floating resize/moving is laggy
       # by default we handle these events delayed to already improve performance, however your system might still be struggling
       # this variable is set to none (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
       # x11_drag_polling_rate = 60,
        wallpaper=wallpapers.WALLPAPER_TILES,
        wallpaper_mode="fill",
    )

def run_screen_reconfiguration():
    logger.warn("reconfiguring screens")

    global screens
    screens = [make_screen(True)]

    global num_monitors
    num_monitors = get_num_monitors()
    if num_monitors > 1:
        for i in range(num_monitors - 1):
            logger.warn(f"Adding additional screen {i+1} of {num_monitors-1}")
            screens.append(make_screen(False))

run_screen_reconfiguration()

# Reload on screen change
@hook.subscribe.screens_reconfigured
def screen_reconf(_):
    run_screen_reconfiguration()
    qtile.cmd_reload_config()
