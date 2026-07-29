#!/bin/bash

sketchybar --add item volume right \
           --set volume "${plugin_item[@]}" \
           --set volume \
                icon.padding_right=1 \
                background.color="$RED" \
                script="$SCRIPTS_DIR/volume.sh" \
                click_script="open 'x-apple.systempreferences:com.apple.Sound-Settings.extension'" \
           --subscribe volume volume_change mouse.scrolled mouse.entered mouse.exited

sketchybar --add item spacer.volume right \
           --set spacer.volume "${spacer[@]}"
