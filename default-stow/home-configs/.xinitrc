#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Make sure this is before the 'exec' command or it won't be sourced.
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile


# Start D-Bus (important for Polkit)
if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
    eval "$(dbus-launch --sh-syntax --exit-with-session)"
fi

#eval "$(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)"
#export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID SSH_AUTH_SOCK


/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
gnome-keyring-daemon --start --components=secrets &


# Launch the window manager through ly
case "$XDG_SESSION_DESKTOP" in
    dwm)
	#dwm 2>/dev/null
	#dwm
	dwm >/dev/null 2>&1
        ;;
    chadwm)
        exec chadwm
        ;;
    qtile)
	qtile start
        ;;
    *)
        exec xterm  # Fallback
        ;;
esac

