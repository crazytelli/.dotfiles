from typing import List  # noqa: F401

from libqtile import bar, layout, widget, qtile

from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
# not in use currently as terminal is being defined explicitly
# from libqtile.utils import guess_terminal 
from libqtile import hook
import subprocess
import os
import psutil # for swallow hook

# Theme Choice
from themes import dracula

colors = dracula.init_colors()

# # Using pywal to set qtile's colorschemes:
# colors = []
# cache = os.path.expanduser("~/.cache/wal/colors")
#
#
# def load_colors(cache):
#     with open(cache, "r") as file:
#         for _ in range(16):
#             colors.append(file.readline().strip())
#     colors.append("#ffffff")
#     lazy.reload()
#
#
# load_colors(cache)

# from myscreens import screens

mod = "mod4"
# terminal = guess_terminal()
terminal = "kitty"

keys = [
    
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "f", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "d", lazy.spawn("rofi -show drun"), desc="spawn rofi"),
    #Key( [mod, "shift"], "d", lazy.spawncmd(), desc="Spawn a command using a dmenu prompt widget"),

    # Switch between windows
    Key( [mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key( [mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key( [mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key( [mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key( [mod], "space", lazy.layout.next(), desc="Move window focus to other window"),

    # Move windows around
    Key( [mod, "shift" ], "h", lazy.layout.shuffle_left().when(layout=['columns']), desc="Move window to the left"),
    Key( [mod, "shift" ], "l", lazy.layout.shuffle_right().when(layout=['columns']), desc="Move window to the right",),
    Key( [mod, "shift" ], "k", lazy.layout.shuffle_down(), desc="Move window down"),
    Key( [mod, "shift" ], "j", lazy.layout.shuffle_up(), desc="Move window up") ,
    Key( [mod, "shift" ], "n", lazy.screen.next_group(skip_empty=True), desc="Cycle to next workspace "),
    Key( [mod, "shift" ], "p", lazy.screen.prev_group(skip_empty=True), desc="Cycle to previous workspace ",),
    Key( [mod, "shift"], "f", lazy.window.toggle_floating(), desc="Toggle floating",),

    # Tile layout specific cofiguration
    Key( [mod, "shift" ], "r", lazy.layout.reset().when(layout=['tile']), desc = "Increases the size of master when in Tile Layout"),
    Key( [mod, "shift" ], "i", lazy.layout.increase_ratio().when(layout=['tile']), desc = "Increases the ratio of master when in Tile Layout"),
    Key( [mod, "shift" ], "d", lazy.layout.decrease_ratio().when(layout=['tile']), desc = "Decreases the ratio of master when in Tile Layout"),
    # conflict with next workspace
    #Key( [mod, "shift" ], "n", lazy.layout.normalize(), desc="Reset all window sizes"),

    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key( [mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key( [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key( [mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key( [mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key( [mod], "b", lazy.hide_show_bar(), desc="Toggle hide/show the bar"),
    Key(
        [mod],
        "x",
        lazy.spawn("slock"),
        desc="Locks the screen with slock - suckless.org",
    ),
    Key(
        [mod, "shift"],
        "z",
        lazy.spawn("systemctl suspend"),
        desc="Suspends the computer screen with slock and a systemd service at /etc/systemd/system/slock@.service",
    ),
    # Fn Keys:
    Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer -i 5")),
    Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer -d 5")),
    Key([], "XF86AudioMute", lazy.spawn("pamixer -t")),

    Key(
        [],
        "XF86MonBrightnessUp",
        lazy.spawn("brightnessctl set +10%"),
        desc="Increase display brightness",
    ),

    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("brightnessctl set 10%-"),
        desc="Decrease display brightness",
    ),

    # Launch apps key bindings:
    Key(
        [mod, "shift"],
        "Return",
        lazy.spawn(f"{terminal} -e ranger"),
        desc="Launches Ranger file manager",
    ),
]

# Groups config
groups = [Group(i) for i in "123456789"]
for i in groups:
    keys.extend(
        [
            # mod1 + letter of group = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc="Switch to group {}".format(i.name),
            ),
            # mod1 + shift + letter of group = switch to & move focused window to group
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc="Switch to & move focused window to group {}".format(i.name),
            ),
        ]
    )


def init_layout_theme():
    return {
        "border_width": 3,
        "margin": 20,
        "border_focus": colors[1],
        "border_normal": colors[13],
    }


layout_theme = init_layout_theme()


# Layouts config
layouts = [
    #layout.Columns(**layout_theme),
    #layout.MonadTall(**layout_theme, align=layout.MonadTall._left),
    layout.Tile(**layout_theme), 
    layout.Max( border_width = 0, margin = 0), 
]

widget_defaults = dict(
    font="JetBrains Mono",
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()


floating_layout = layout.Floating(
    **layout_theme,
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
        Match(title="win0"),  # Pycharm launching screen
        Match(title="Python Turtle Graphics"),  # Python Graphics Tk module
    ],
)

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                    font="Hack Nerd Font Bold",
                    fontsize=18,
                    highlight_method="line",
                    this_screen_border=colors[4],
                    this_current_screen_border=colors[11],
                    active=colors[10],
                    inactive=colors[1],
                    background=colors[13],
                    hide_unused=True,
                ),
                # Dmenu run prompt
                widget.CurrentLayoutIcon(scale=0.8),
                widget.Prompt(
                    font="Hack Nerd Font Bold",
                    fontsize=18
                    ),

                widget.Spacer(length=20),
                widget.WindowName(font="Hack Nerd Font Bold", fontsize=18),
                widget.Chord(
                    chords_colors={
                        "launch": (colors[3], colors[10]),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.Chord(),
                widget.Systray(icon_size=24, padding=5),
                widget.DF(warn_space=40,visible_on_warn=False, 
                    font="Hack Nerd Font Bold",
                    fontsize=18,
                    format=' :({uf}{m}|{r:.0f}%)',
                    foreground=colors[5],
                    warn_color=colors[3],
                ),
                widget.Spacer(length=5),
                widget.Memory(
                    font="Hack Nerd Font Bold",
                    fontsize=18,
                    # background=colors[13],
                    foreground=colors[1],
                    format="󰍛:{MemUsed:.0f} MB",
                    padding_y=4,
                ),
                widget.Clock(
                    format="%d-%m-%Y %a %H:%M",
                    foreground=colors[15],
                    font="Hack Nerd Font Bold",
                    fontsize=18,
                ),
                widget.Spacer(length=5),
                widget.Battery(
                    battery=1,
                    charge_char="󱟦",
                    discharge_char="󱟤",
                    empty_char="",
                    #full_char="",
                    full_char="󱟢",
                    unknown_char="",
                    font="Hack Nerd Font Bold",
                    fontsize=18,
                    foreground=colors[7],
                    # background=colors[14],
                    format="{char} {percent:2.0%}",
                    low_percentage=0.2,
                    low_foreground="#FF0000",
                    show_short_text=False,
                    # hide_threshold=0.8,
                ),
            ],
            30,
            background=colors[13],
            # opacity=0.75,
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=[ "ff00ff", "000000", "ff00ff", "000000", ],  # Borders are magenta
        ),
    ),
]

# Drag floating layouts.
mouse = [
    Drag(
        [mod],
        "Button1",
        lazy.window.set_position_floating(),
        start=lazy.window.get_position(),
    ),
    Drag(
        [mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()
    ),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False

auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True


# Window Swallow
# Didn't actually managed to make it work
# https://github.com/qtile/qtile/issues/1771
# @hook.subscribe.client_new
# def _swallow(window):
#     pid = window.get_net_wm_pid()
#     ppid = psutil.Process(pid).ppid()
#     cpids = {c.window.get_net_wm_pid(): wid for wid, c in window.qtile.windows_map.items()}
#     for i in range(5):
#         if not ppid:
#             return
#         if ppid in cpids:
#             parent = window.qtile.windows_map.get(cpids[ppid])
#             parent.minimized = True
#             window.parent = parent
#             return
#         ppid = psutil.Process(ppid).ppid()
#
# @hook.subscribe.client_killed
# def _unswallow(window):
#     if hasattr(window, 'parent'):
#         window.parent.minimized = False
#

@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser("~/.config/qtile/autostart.sh")
    subprocess.call([home])


# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
