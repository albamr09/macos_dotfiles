#!/bin/bash

##### Aerospace workspaces #####

sketchybar --add event aerospace_workspace_change

# Define your desired workspace order
ordered_workspaces=(C T W G M B P)

for sid in "${ordered_workspaces[@]}"; do
  aerospace_workspace_config "$sid"

  sketchybar --add item space.$sid left \
      --subscribe space.$sid aerospace_workspace_change mouse.entered mouse.exited \
      --set space.$sid \
        icon="$icon" \
        icon.color="$LABEL_COLOR" \
        icon.font="$FONT_FACE:Medium:$ICON_FONT_SIZE" \
        icon.padding_right="$INNER_PADDING" \
        icon.padding_left="$OUTER_PADDING" \
        background.color="$WORKSPACE_UNFOCUSED_COLOR" \
        background.border_width="$BORDER_WIDTH" \
        background.border_color="$BORDER_COLOR" \
        background.corner_radius="$BORDER_RADIUS" \
        background.height="$ITEM_HEIGHT" \
        background.drawing=on \
        label="${label}" \
        label.color="$LABEL_COLOR" \
        label.padding_right="$OUTER_PADDING" \
        click_script="aerospace workspace $sid" \
        script="$SCRIPTS_DIR/aerospace.sh $sid"

  sketchybar --add item spacer.$sid left \
      --set spacer.$sid width=10 drawing=on label.drawing=off background.drawing=off
done

##### Show selected application

sketchybar --add item chevron left \
           --set chevron icon= label.drawing=off icon.padding_left=0 \
           --add item front_app left \
           --set front_app "${plugin_item[@]}" \
           --set front_app icon.drawing=off \
                background.color="$LAVENDER" \
                label.padding_left="$OUTER_PADDING" \
                script="$SCRIPTS_DIR/front_app.sh" \
           --subscribe front_app front_app_switched
