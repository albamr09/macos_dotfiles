#!/bin/sh

# Imports
. "$CONFIG_DIR/config.sh"

# Listen to mouse enter/exit events to change the style of the pill
case "$SENDER" in
  "mouse.entered")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$GREEN_BRIGHT"
    exit 0
    ;;
  "mouse.exited")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$GREEN"
    exit 0
    ;;
esac

# Plugin
PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case "${PERCENTAGE}" in
  9[0-9]|100) ICON=""
  ;;
  [6-8][0-9]) ICON=""
  ;;
  [3-5][0-9]) ICON=""
  ;;
  [1-2][0-9]) ICON=""
  ;;
  *) ICON=""
esac

if [[ "$CHARGING" != "" ]]; then
  ICON=""
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%"
