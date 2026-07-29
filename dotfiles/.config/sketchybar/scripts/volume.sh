#!/bin/sh

# Imports
. "$CONFIG_DIR/config.sh"

# Listen to volume changes
# The volume_change event supplies a $INFO variable in which the current volume
# percentage is passed to the script.

if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"

  case "$VOLUME" in
    [6-9][0-9]|100) ICON="󰕾"
    ;;
    [3-5][0-9]) ICON="󰖀"
    ;;
    [1-9]|[1-2][0-9]) ICON="󰕿"
    ;;
    *) ICON="󰖁"
  esac

  sketchybar --set "$NAME" icon="$ICON" label="$VOLUME%"
fi

# Listen to mouse scroll
if [ "$SENDER" = "mouse.scrolled" ]; then
  # SCROLL_DELTA is positive or negative depending on direction
  CURRENT=$(osascript -e 'output volume of (get volume settings)')
  DELTA=$(( SCROLL_DELTA > 0 ? 5 : -5 ))
  NEW=$(( CURRENT + DELTA ))
  [ "$NEW" -gt 100 ] && NEW=100
  [ "$NEW" -lt 0 ] && NEW=0
  osascript -e "set volume output volume $NEW"
  exit 0
fi

# Listen to mouse enter/exit events to change the style of the pill
case "$SENDER" in
  "mouse.entered")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$RED_BRIGHT"
    ;;
  "mouse.exited")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$RED"
    ;;
esac

