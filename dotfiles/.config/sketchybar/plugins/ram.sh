#!/bin/bash

#!/bin/bash

# Get top CPU-hogging process
TOPPROC=$(ps axo "%cpu,ucomm" | sort -nr | awk 'NR==2 {printf "%.0f%% %s\n", $1, $2}' | sed -e 's/com.apple.//g')

TOPMEM=$(ps axo "rss" | sort -nr | awk 'NR==2 {printf "%.0f MB\n", $1 / 1024}')

# Extract just the memory usage number (in MB)
MEM=$(echo "$TOPMEM" | awk '{print $1}')

sketchybar -m --set "$NAME" label="$TOPMEM"
