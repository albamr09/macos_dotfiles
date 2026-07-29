#!/bin/sh

# Imports
. "$CONFIG_DIR/config.sh"


# Plugin

DISK_USAGE=$(df -lh | grep /dev/disk3s5 | awk '{ printf ("%02.0f\n", $5) }')

sketchybar -m --set "$NAME" label="$DISK_USAGE%"

if [ "$DISK_USAGE" -gt "80" ]; then 
    sketchybar -m --set "$NAME" label.color="$RED"
else 
    sketchybar -m --set "$NAME" label.color="$LABEL_COLOR"
fi
