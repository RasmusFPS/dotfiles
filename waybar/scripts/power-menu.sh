#!/bin/bash

# Define the options for the wofi menu in your desired order
entries="⏻ Shutdown\n⏾ Sleep\n⭮ Reboot"

# Show the wofi menu and get the selected option
selected=$(echo -e $entries | wofi --style ~/.config/wofi/power.css --dmenu --prompt "Power Menu")

# The case statement handles the logic regardless of order
case $selected in
  "⏾ Sleep")
    systemctl suspend
    ;;
  "⭮ Reboot")
    systemctl reboot
    ;;
  "⏻ Shutdown")
    systemctl poweroff
    ;;
esac
