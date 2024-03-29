from typing import List  # noqa: F401

from libqtile import bar, layout, widget, qtile

# from libqtile import layout
from libqtile.config import Click, Drag, Group, Key, KeyChord, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
from libqtile import hook
import subprocess
import os

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
terminal = guess_terminal()

keys = [
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key(
        [mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"
    ),
    Key(
        [mod, "shift"],
        "l",
        lazy.layout.shuffle_right(),
        desc="Move window to the right",
    ),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key(
        [mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"
    ),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key([mod], "b", lazy.hide_show_bar(), desc="Toggle hide/show the bar"),
    Key(
        [mod, "shift"],
        "f",
        lazy.window.toggle_floating(),
        desc="Toggle floating",
    ),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    # Key(
    #     [mod, "shift"],
    #     "Return",
    #     lazy.layout.toggle_split(),
    #     desc="Toggle between split and unsplit sides of stack",
    # ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "m", lazy.window.toggle_fullscreen(), desc="Toggle fullscreen"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawn("rofi -show drun"), desc="spawn rofi"),
    Key(
        [mod, "shift"],
        "r",
        lazy.spawncmd(),
        desc="Spawn a command using a prompt widget",
    ),
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
        lazy.spawn("xbacklight -inc 10"),
        desc="Increase display brightness",
    ),
    Key(
        [],
        "XF86MonBrightnessDown",
        lazy.spawn("xbacklight -dec 10"),
        desc="Increase display brightness",
    ),
    # Launch apps key bindings:
    Key(
        [mod, "shift"],
        "Return",
        lazy.spawn(f"{terminal} -e ranger"),
        desc="Launches Ranger file manager",
    ),
    # Key Chord application launcher with alt + k
    KeyChord(
        ["mod1"],
        "k",
        [
            Key(
                [],
                "b",
                lazy.spawn("brave"),
            ),
            Key(
                [],
                "f",
                lazy.spawn("firefox"),
            ),
            Key(
                [],
                "p",
                lazy.spawn("pcmanfm"),
            ),
            Key(
                [],
                "q",
                lazy.spawn("qbittorrent"),
            ),
            Key(
                [],
                "o",
                lazy.spawn("flatpak run md.obsidian.Obsidian"),
            ),
        ],
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
        "margin": 4,
        "border_focus": colors[1],
        "border_normal": colors[13],
    }


layout_theme = init_layout_theme()


# Layouts config
layouts = [
    layout.Columns(**layout_theme),
    layout.Max(),
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
                    highlight_method="line",
                    this_screen_border=colors[4],
                    this_current_screen_border=colors[11],
                    active=colors[10],
                    inactive=colors[1],
                    background=colors[13],
                    hide_unused=True,
                ),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.Prompt(font="Hack Nerd Font Bold"),
                widget.Spacer(length=10),
                widget.WindowName(font="Hack Nerd Font Bold"),
                widget.Chord(
                    chords_colors={
                        "launch": (colors[3], colors[10]),
                    },
                    name_transform=lambda name: name.upper(),
                ),
                widget.CurrentLayoutIcon(scale=0.65),
                widget.CheckUpdates(
                    update_interval=1800,
                    distro="Arch_yay",
                    display_format="{updates} Updates",
                    foreground=colors[4],
                    mouse_callbacks={
                        "Button1": lambda: qtile.cmd_spawn(terminal + " -e yay -Syu")
                    },
                    background=colors[13],
                ),
                widget.Chord(),
                widget.Systray(),
                widget.Spacer(length=5),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.Memory(
                    font="Hack Nerd Font Bold",
                    fontsize=14,
                    # background=colors[13],
                    foreground=colors[6],
                    format="󰍛{MemUsed: .0f} MB ",
                    padding_y=4,
                ),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                # widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.Clock(
                    format="%d-%m-%Y %a %H:%M",
                    foreground=colors[15],
                    font="Hack Nerd Font Bold",
                    fontsize=14,
                ),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.TextBox(text="", padding=0, fontsize=20, foreground="#2f343f"),
                widget.Battery(
                    battery=1,
                    charge_char="󱟦",
                    discharge_char="󱟤",
                    empty_char="",
                    full_char="",
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
            24,
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
