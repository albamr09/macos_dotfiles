#!/bin/bash

sketchybar --add item clock right \
           --set clock "${plugin_item[@]}" \
           --set clock update_freq=10 \
                icon=  \
                icon.padding_right=1 \
                background.color="$BLUE" \
                click_script="open -a Calendar" \
                script="$SCRIPTS_DIR/clock.sh"
sketchybar --subscribe clock mouse.entered mouse.exited

sketchybar --add item spacer.clock right \
           --set spacer.clock "${spacer[@]}"
