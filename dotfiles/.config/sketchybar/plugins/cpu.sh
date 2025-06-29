#!/bin/bash

cpu=$(ps -A -o %cpu | awk '{s+=$1} END {printf "%.0f%%\n", s}')

sketchybar --set cpu label="$cpu"
