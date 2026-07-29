#!/usr/bin/env bash

# Imports
. "$CONFIG_DIR/config.sh"

# Get style constants give the sid (stored on the first argument that is passed to this script, namely $1) 
aerospace_workspace_config "$1"

# Listen to mouse enter/exit events to change the style of the pill
case "$SENDER" in
  "mouse.entered")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$bg_color_bright"
    exit 0
    ;;
  "mouse.exited")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$bg_color"
    exit 0
    ;;
esac


# Plugin
if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME label.drawing=on
else
    sketchybar --set $NAME label.drawing=off
fi
