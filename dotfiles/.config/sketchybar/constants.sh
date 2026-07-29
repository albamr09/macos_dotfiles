#!/bin/bash

# Module style constants
plugin_item=(
  background.border_width=1
  background.border_color="$BORDER_COLOR"
  background.corner_radius=8
  background.height=29
  background.drawing=on
  label.color="$LABEL_COLOR"
  label.padding_left=10
  label.padding_right=10
  icon.padding_left=10
  icon.padding_right=1
)

stats_item=(
  label.font="$FONT_FACE:Medium:10.0"
  label.padding_left=0
  label.padding_right=0
  icon.padding_left=0
  icon.padding_right=0
  click_script="open -a 'Activity Monitor'"
)

stats_label_item=(
    y_offset=5
    width=0
    "${stats_item[@]}"
)

stats_value_item=(
    y_offset=-5
    update_freq=10
    "${stats_item[@]}"
)

spacer=(
  width=10 
  drawing=on 
  label.drawing=off 
  background.drawing=off
)

# Style constants
ANIMATION_DURATION=8

# Workspace table: sets icon, font_size, bg_color, bg_color_bright, label
# for a given workspace id
aerospace_workspace_config() {
  case "$1" in
    C) icon="" ; font_size="15.0" ; bg_color="$GREEN"   ; bg_color_bright="$GREEN_BRIGHT"   ; label="Comms" ;;
    T) icon="" ; font_size="17.0" ; bg_color="$BLUE"    ; bg_color_bright="$BLUE_BRIGHT"    ; label="Terminal" ;;
    W) icon="" ; font_size="16.0" ; bg_color="$CYAN"    ; bg_color_bright="$CYAN_BRIGHT"    ; label="Web" ;;
    G) icon="" ; font_size="16.0" ; bg_color="$TEAL"    ; bg_color_bright="$TEAL_BRIGHT"    ; label="GUI" ;;
    M) icon="" ; font_size="16.0" ; bg_color="$MAGENTA" ; bg_color_bright="$MAGENTA_BRIGHT" ; label="Mobile" ;;
    B) icon="" ; font_size="17.0" ; bg_color="$YELLOW"  ; bg_color_bright="$YELLOW_BRIGHT"  ; label="Back" ;;
    P) icon="" ; font_size="17.0" ; bg_color="$RED"     ; bg_color_bright="$RED_BRIGHT"     ; label="Home" ;;
    *) icon="$1" ; font_size="13.0" ; bg_color="$GRAY"  ; bg_color_bright="$GRAY_BRIGHT"    ; label="Other" ;;
  esac
}
