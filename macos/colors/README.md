# Theme System

Switch color palettes across ghostty and tmux with one command.

## Usage

```bash
theme              # list available palettes
theme warm-plum    # apply a palette
theme --current    # show active palette
```

## Create a new palette

```bash
cp colors/palette.example.toml colors/my-theme.toml
```

Edit the hex values, then apply:

```bash
theme my-theme
```

## Palette format

```toml
name = "My Theme"

[base]
background = "#000000"
foreground = "#ffffff"

[cursor]
color = "#ffffff"
text = "#000000"

[selection]
background = "#ffffff"
foreground = "#000000"

[palette]
black   = "#000000"
red     = "#ff0000"
green   = "#00ff00"
yellow  = "#ffff00"
blue    = "#0000ff"
magenta = "#ff00ff"
cyan    = "#00ffff"

[tmux]
status_bg = "#333333"
status_fg = "#ffffff"
```

The `[palette]` section sets ANSI colors 0-6 in ghostty. Neomutt and fastfetch use ANSI color names, so they inherit the palette automatically.
