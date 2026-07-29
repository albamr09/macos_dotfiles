#!/bin/bash

sketchybar -m --add item vpn right \
              --set vpn "${plugin_item[@]}" \
                        background.color="$TEAL" \
                        icon= \
                        drawing=off \
                        update_freq=5 \
                        script="$SCRIPTS_DIR/vpn.sh" \
              --subscribe vpn mouse.clicked mouse.entered mouse.exited
