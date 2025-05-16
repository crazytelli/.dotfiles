#!/bin/sh

nitrogen --restore &

xset r rate 200 50 &

# position of hdmi monitor
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 1920x1080 --pos 1920x0 --rotate normal &


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

