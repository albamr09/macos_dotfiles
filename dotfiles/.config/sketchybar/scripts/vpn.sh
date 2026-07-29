#!/bin/sh

# Imports
. "$CONFIG_DIR/config.sh"

# Detect connected VPNs
NATIVE=$(scutil --nc list | grep Connected | sed -E 's/.*"(.*)".*/\1/')
TB=""
if pgrep -xq Tunnelblick; then
  TB=$(osascript -e 'tell application "Tunnelblick" to get name of configurations whose state is "CONNECTED"' 2>/dev/null)
fi

# Listen to mouse events to change the style of the pill or perform an action
case "$SENDER" in
  "mouse.entered")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$TEAL_BRIGHT"
    exit 0
    ;;
  "mouse.exited")
    sketchybar --animate tanh "$ANIMATION_DURATION" --set "$NAME" background.color="$TEAL"
    exit 0
    ;;
   # Click: open the provider app for the active connection
  "mouse.clicked")
    if [ -n "$TB" ]; then
      open -a "Tunnelblick"
    elif [ -n "$NATIVE" ]; then
      open -a "Twingate"
    fi
    exit 0
    ;;
esac

# Build the label
VPNS=""
[ -n "$NATIVE" ] && VPNS="$NATIVE"
if [ -n "$TB" ]; then
  if [ -n "$VPNS" ]; then
    VPNS="$VPNS
$TB"
  else
    VPNS="$TB"
  fi
fi

VPNS=$(echo "$VPNS" | tr ',' '\n' | sed 's/^ *//;s/ *$//' | grep -v '^$')
COUNT=$(echo "$VPNS" | grep -c .)

if [ "$COUNT" -eq 0 ]; then
  sketchybar --set "$NAME" drawing=off
elif [ "$COUNT" -eq 1 ]; then
  sketchybar --set "$NAME" label="$VPNS" drawing=on
else
  FIRST=$(echo "$VPNS" | head -n1)
  sketchybar --set "$NAME" label="$FIRST +$((COUNT - 1))" drawing=on
fi
