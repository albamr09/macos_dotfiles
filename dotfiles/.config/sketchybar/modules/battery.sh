#!/bin/bash

sketchybar --add item battery right \
           --set battery "${plugin_item[@]}" \
           --set battery update_freq=120 \
                icon.padding_right=1 \
                background.color="$GREEN" \
                script="$SCRIPTS_DIR/battery.sh" \
                click_script="open 'x-apple.systempreferences:com.apple.Battery-Settings.extension'" \
           --subscribe battery system_woke power_source_change mouse.entered mouse.exited

sketchybar --add item spacer.battery right \
           --set spacer.battery "${spacer[@]}"
