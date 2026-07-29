#!/bin/bash

# Style constants
FONT_SIZE=12.0
ICON_FONT_SIZE=13.0
ITEM_HEIGHT=27
ITEM_PADDING=8
BORDER_RADIUS=8
BORDER_WIDTH=1
ANIMATION_DURATION=8

# Module style constants
plugin_item=(
  background.border_width="$BORDER_WIDTH"
  background.border_color="$BORDER_COLOR"
  background.corner_radius="$BORDER_RADIUS"
  background.height="$ITEM_HEIGHT"
  background.drawing=on
  label.color="$LABEL_COLOR"
  label.padding_left="$ITEM_PADDING"
  label.padding_right="$ITEM_PADDING"
  icon.padding_left="$ITEM_PADDING"
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


# Workspace table: sets icon, font_size, bg_color, bg_color_bright, label
# for a given workspace id
aerospace_workspace_config() {
  case "$1" in
    C) icon="" ;   bg_color="$GREEN"   ; bg_color_bright="$GREEN_BRIGHT"   ; label="Comms" ;;
    T) icon="" ;   bg_color="$BLUE"    ; bg_color_bright="$BLUE_BRIGHT"    ; label="Terminal" ;;
    W) icon="" ;   bg_color="$CYAN"    ; bg_color_bright="$CYAN_BRIGHT"    ; label="Web" ;;
    G) icon="" ;   bg_color="$TEAL"    ; bg_color_bright="$TEAL_BRIGHT"    ; label="GUI" ;;
    M) icon="" ;   bg_color="$MAGENTA" ; bg_color_bright="$MAGENTA_BRIGHT" ; label="Mobile" ;;
    B) icon="" ;   bg_color="$YELLOW"  ; bg_color_bright="$YELLOW_BRIGHT"  ; label="Back" ;;
    P) icon="" ;   bg_color="$RED"     ; bg_color_bright="$RED_BRIGHT"     ; label="Home" ;;
    *) icon="$1" ;  bg_color="$GRAY"    ; bg_color_bright="$GRAY_BRIGHT"    ; label="Other" ;;
  esac
}
