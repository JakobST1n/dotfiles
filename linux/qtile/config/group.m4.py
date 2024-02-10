groups = [
    Group(name="1"),
    Group(name="2"),
    Group(name="3"),
    Group(name="4"),
    Group(name="5"),
    Group(name="6"),
    Group(name="7"),
    Group(name="8"),
    Group(name="9"),
]

group_screen_map = dict()

def to_group(name: str):
    def _inner(qtile):
        g = qtile.groups_map[name]
        if (sc := group_screen_map[name]) is not None:
            if sc < num_monitors:
                qtile.to_screen(sc)
        g.toscreen()
    return _inner


for g in groups:
    group_screen_map[g.name] = None
    keys.extend(
        [
            Key(
                [mod],
                g.name,
                lazy.function(to_group(g.name)),
                desc="Switch to group {}".format(g.name),
            ),
            Key(
                [mod, "shift"],
                g.name,
                lazy.window.togroup(g.name),
                desc="move focused window to group {}".format(g.name)
            ),
        ]
    )

@hook.subscribe.group_window_add
def group_window_add(group, window):
    groups = qtile.get_groups()
    global group_screen_map
    group_screen_map[group.name] = groups[group.name]["screen"]
    logger.warning(group_screen_map)


@hook.subscribe.delgroup
def group_deleted(group_name):
    send_notification("qtile", f"Group deleted: {group_name}")

@hook.subscribe.setgroup
def setgroup():
    send_notification("qtile", "Group set")


@hook.subscribe.changegroup
def change_group():
    send_notification("qtile", "Change group event")

@hook.subscribe.addgroup
def group_added(group_name):
    send_notification("qtile", f"New group added: {group_name}")
