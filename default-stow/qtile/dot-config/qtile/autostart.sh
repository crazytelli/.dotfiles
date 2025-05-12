#!/bin/sh

# Setting Background image
# feh --bg-scale /home/victor/Pictures/wallpapers/0uttnZl.jpg
# feh --bg-scale /usr/share/backgrounds/archlinux/wave.png
nitrogen --restore &
# Using pywal to set colorscheme matching the image
# wal -i /home/crazytelli/pictures/wallpapers/c4hLdu3.jpg
# You can create a function for this in your shellrc (.bashrc, .zshrc).
# wal-tile() {
#     wal -n -i "$@"
#     feh --bg-tile "$(< "${HOME}/.cache/wal/wal")"
# }

# Usage:
# wal-tile "/home/victor/Pictures/wallpapers/c4hLdu3.jpg"

picom & disown # --experimental-backends --vsync should prevent screen tearing on most setups if needed

# Network Manager
nm-applet & disown

# Blueman - bluetooth applet
blueman-applet & disown

dunst &

udiskie -ns &

# Low battery notifier
# ~/.config/qtile/scripts/check_battery.sh & disown
~/.config/qtile/xscreensaverstopper.sh &

# start polkit agent from GNOME
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

gnome-keyring-daemon --start --components=secrets &

