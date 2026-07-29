#!/bin/sh

# Imports
. "$CONFIG_DIR/config.sh"

# Plugin
# The $NAME variable is passed from sketchybar and holds the name of
# the item invoking this script:
# https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set "$NAME" label="$(date '+%d/%m %H:%M')"

# Listen to mouse enter/exit events to change the style of the pill
case "$SENDER" in
  "mouse.entered")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$BLUE_BRIGHT"
    exit 0
    ;;
  "mouse.exited")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$BLUE"
    exit 0
    ;;
esac

