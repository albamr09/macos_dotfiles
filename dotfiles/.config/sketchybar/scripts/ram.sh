#!/bin/sh

# Imports
. "$CONFIG_DIR/config.sh"

RAM_USAGE=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{ printf("%02.0f\n", 100-$5"%") }')

# Plugin
sketchybar -m --set "$NAME" label="$RAM_USAGE%"

if [ "$RAM_USAGE" -gt "80" ]; then 
    sketchybar -m --set "$NAME" label.color="$RED"
else 
    sketchybar -m --set "$NAME" label.color="$LABEL_COLOR"
fi
