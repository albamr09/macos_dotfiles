#!/usr/bin/env bash

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.border_width=2 label.drawing=on
else
    sketchybar --set $NAME background.border_width=1 label.drawing=off
fi
