#!/bin/bash

set -euo pipefail

# Logs
INFO="\033[1;34m[INFO]\033[0m"
SUCCESS="\033[1;32m[SUCCESS]\033[0m"
ERROR="\033[1;31m[ERROR]\033[0m"

# Make script independent of where it is run
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."  # Go root

# Input validation
if [[ $# -lt 1 ]]; then
  echo -e "$ERROR Missing dotfile directory path"
  echo "Usage: $0 /full/path/to/dotfile-dir"
  exit 1
fi

# Input: full path to dotfiles directory (e.g., /Users/alba/.config/aerospace) ---
DOTFILE_DIR="$1"
if [[ ! -d "$DOTFILE_DIR" ]]; then
  echo -e "$ERROR '$DOTFILE_DIR' is not a directory"
  exit 1
fi

# Compute relative path to home (e.g., .config/aerospace)
relative_path="${DOTFILE_DIR/#$HOME\//}"
parent_path=$(dirname "$relative_path")
dest_path="./dotfiles/$parent_path"
dotfile_name=$(basename "$DOTFILE_DIR")

echo -e "$INFO Preparing to track: $DOTFILE_DIR"
echo -e "$INFO Relative path: $relative_path"
echo -e "$INFO Repo destination: $dest_path"
echo -e "$INFO Dotfile name: $dotfile_name"

# Copy dotfiles into repo
mkdir -p "$dest_path"
cp -r "$DOTFILE_DIR" "$dest_path"

echo -e "$INFO Copied files into repo: $dest_path/$dotfile_name"

# Create symlinks with stow
echo -e "$INFO Creating symlinks using stow..."
stow -d "$dest_path" -t "$DOTFILE_DIR" --adopt "$dotfile_name"

echo -e "$SUCCESS Tracking '$dotfile_name' with symlinks"
echo -e "$INFO Final contents of '$DOTFILE_DIR':"
ls -la "$DOTFILE_DIR"
