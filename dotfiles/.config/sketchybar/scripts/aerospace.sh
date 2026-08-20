#!/usr/bin/env bash

# Imports
. "$CONFIG_DIR/config.sh"

# Get style constants give the sid (stored on the first argument that is passed to this script, namely $1) 
aerospace_workspace_config "$1"

focused_workspace=$(aerospace list-workspaces --focused)

# Listen to mouse enter/exit events to change the style of the pill
case "$SENDER" in
  "mouse.entered")
    if [ "$1" != "$focused_workspace" ]; then
      sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$bg_color_bright"
    fi
    exit 0
    ;;
  "mouse.exited")
    if [ "$1" != "$focused_workspace" ]; then
      sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$WORKSPACE_UNFOCUSED_COLOR"
    fi
    exit 0
    ;;
esac

# Show workspace if there are windows on the workspace or if the workspace is focused
if [ "$1" = "$focused_workspace" ] || (( $(aerospace list-windows --workspace "$1" --count) )); then
    sketchybar --set "$NAME" drawing=on --set "spacer.$1" drawing=on
else
    sketchybar --set "$NAME" drawing=off --set "spacer.$1" drawing=off
    exit 0
fi

# Highlight the workspace if it is focused
if [ "$1" = "$focused_workspace" ]; then
    sketchybar --set "$NAME" background.color="$bg_color"
else
    sketchybar --set "$NAME" background.color="$WORKSPACE_UNFOCUSED_COLOR"
fi
