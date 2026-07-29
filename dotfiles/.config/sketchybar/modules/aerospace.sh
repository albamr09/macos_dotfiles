#!/bin/bash

##### Aerospace workspaces #####

sketchybar --add event aerospace_workspace_change

# Define your desired workspace order
ordered_workspaces=(C T W G M B P)

# Get current workspace list dynamically
active_workspaces=($(aerospace list-workspaces --all))

for sid in "${ordered_workspaces[@]}"; do
  # Only process it if it's currently active
  if [[ " ${active_workspaces[*]} " =~ " $sid " ]]; then
    aerospace_workspace_config "$sid"

    sketchybar --add item space.$sid left \
      --subscribe space.$sid aerospace_workspace_change mouse.entered mouse.exited \
      --set space.$sid \
        icon="$icon" \
        icon.font="$FONT_FACE:Bold:${font_size}" \
        background.color=$bg_color \
        background.border_width=1 \
        background.border_color="$BORDER_COLOR" \
        background.corner_radius=8 \
        background.height=27 \
        background.drawing=on \
        label="${label}" \
        label.padding_right=10 \
        label.drawing=off \
        click_script="aerospace workspace $sid" \
        script="$SCRIPTS_DIR/aerospace.sh $sid"

    sketchybar --add item spacer.$sid left \
        --set spacer.$sid width=10 drawing=on label.drawing=off background.drawing=off
  fi
done

##### Show selected application

sketchybar --add item chevron left \
           --set chevron icon= label.drawing=off \
           --add item front_app left \
           --set front_app "${plugin_item[@]}" \
           --set front_app icon.drawing=off \
                background.color="$LAVENDER" \
                script="$SCRIPTS_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
