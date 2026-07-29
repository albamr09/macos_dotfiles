#!/bin/bash

# Stats grid

sketchybar --add item disk_label right \
           --set disk_label label=SSD \
                        "${stats_label_item[@]}" \
                        label.padding_left=6 label.padding_right=12

sketchybar --add item disk_percentage right \
           --set disk_percentage "${stats_value_item[@]}" \
                                 label.padding_left=6 label.padding_right=12 \
                                 script="$SCRIPTS_DIR/disk.sh"

sketchybar --add item ram_label right \
           --set ram_label label=RAM \
                        "${stats_label_item[@]}" \
                        label.padding_left=6 label.padding_right=6

sketchybar --add item ram_percentage right \
           --set ram_percentage "${stats_value_item[@]}" \
                                label.padding_left=6 label.padding_right=6 \
                                script="$SCRIPTS_DIR/ram.sh"

sketchybar --add item cpu_label right \
           --set cpu_label label=CPU \
                        "${stats_label_item[@]}" \
                        label.padding_left=6 label.padding_right=6

sketchybar --add item cpu_percent right \
           --set cpu_percent "${stats_value_item[@]}" \
                        label.padding_left=6 label.padding_right=6 \
                        script="$SCRIPTS_DIR/cpu.sh"

sketchybar --add item network_up right \
           --set network_up icon= \
                        "${stats_label_item[@]}" \
                        update_freq=1 \
                        icon.padding_left=0 icon.padding_right=2 label.padding_right=6 \
                        script="$SCRIPTS_DIR/network.sh"

sketchybar --add item network_down right \
           --set network_down icon= \
                        "${stats_value_item[@]}" \
                        update_freq=1 \
                        icon.padding_left=0 icon.padding_right=2 label.padding_right=6

sketchybar --add item stats_logo right \
           --set stats_logo icon= \
                        "${stats_item[@]}" \
                        icon.padding_left=12 \
                        icon.padding_right=6 

sketchybar --add bracket stats \
        stats_logo network_up network_down \
        cpu_label cpu_percent \
        ram_label ram_percentage \
        disk_label disk_percentage

sketchybar --set stats "${plugin_item[@]}" \
                background.color="$YELLOW"

sketchybar --add item spacer.stats right \
           --set spacer.stats "${spacer[@]}"
