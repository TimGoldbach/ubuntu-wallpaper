#!/bin/sh

EUID=$(id --real --user)
PID=$(pgrep --euid $EUID gnome-session)
export $(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ)
connectedScreens=$(xrandr --listactivemonitors)
widePixels="6880"
laptopPixels="3840"

if [ -z "${connectedScreens##*$widePixels*}" ]; then
  folder="/home/tim/Pictures/wallpapersWide"
elif [ -z "${connectedScreens##*$laptopPixels*}" ]; then
  folder="/home/tim/Pictures/wallpapers"
else
  folder="/home/tim/Pictures/wallpapers"
fi


pic=$(ls $folder/* | shuf -n1)

gsettings set org.gnome.desktop.background picture-options 'scaled'
gsettings set org.gnome.desktop.background picture-uri "file://$pic"