# Mac Dotfiles

Dotfiles for my Mac

## Current setup

- [Aerospace](https://github.com/nikitabobko/AeroSpace)
- [Sketchybar](https://github.com/FelixKratz/SketchyBar)
- [Karabiner](https://karabiner-elements.pqrs.org/)
- [Alacritty](https://github.com/alacritty/alacritty)
- [Tmux](https://github.com/tmux/tmux)
- [Neovim](https://github.com/neovim/neovim)

## Track dotfiles

Execute the following script to start traking new dotfiles:

```bash
./scripts/stow.sh $ABSOLUTE_PATH_TO_DOTFILES
```

This will track the contents inside a folder, for example to track the contents inside `$HOME/.config/aerospace` you would execute:

```bash
./scripts/stow.sh ~/.config/aerospace
```
