#!/bin/sh

nitrogen --restore &

xset r rate 200 50 &

picom &

nm-applet &

blueman-applet &

dunst &

udiskie -ns &

slstatus &

# stops screen going black when watching somethhing on fullscreen
~/.local/bin/xscreensaverstopper.sh &

# start polkit agent from GNOME
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

gnome-keyring-daemon --start --components=secrets &

# Restarts dwm but not the stuff above
# while true; do
#     # Log stderror to a file 
#     dwm 2> ~/.dwm.log
#     # No error logging
#     #dwm >/dev/null 2>&1
# done

# while type dwm >/dev/null; do dwm && continue || break; done

