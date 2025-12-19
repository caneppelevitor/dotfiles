local wezterm = require("wezterm")
local act = wezterm.action

local config = wezterm.config_builder()

-- General Appearance & Style
config.front_end = "OpenGL"
config.max_fps = 144
config.default_cursor_style = "BlinkingBlock"
-- config.color_scheme = 'Paraiso Dark'
-- 251621
config.colors = {
  foreground = "#f6ede6",
  background = "#261622",
  cursor_bg = "#f6ede6",
  cursor_border = "#f6ede6",
  cursor_fg = "#1a1a1a",
  selection_bg = "#5b5552",
  selection_fg = "#f6ede6",

  ansi = {
    "#5b5552", -- black
    "#667985", -- red
    "#6d8a9c", -- green
    "#e6aa89", -- yellow
    "#eebaa0", -- blue
    "#f1c9a8", -- magenta
    "#f6ede6", -- cyan
    "#ffffff", -- white
  },
  brights = {
    "#5b5552", -- bright black
    "#667985", -- bright red
    "#6d8a9c", -- bright green
    "#e6aa89", -- bright yellow
    "#eebaa0", -- bright blue
    "#f1c9a8", -- bright magenta
    "#f6ede6", -- bright cyan
    "#ffffff", -- bright white
  },
}
config.animation_fps = 1
config.cursor_blink_rate = 500
config.term = "xterm-256color"
config.font = wezterm.font("JetBrains Mono")
config.font_size = 12.0
config.cell_width = 1.0  -- Keep normal width
config.adjust_window_size_when_changing_font_size = false
config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false
config.prefer_egl = true
-- config.window_decorations = "NONE"
config.window_background_opacity = 0.90  -- Matches Ghostty

-- Padding
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- Cursor
config.cursor_thickness = 1

-- Keybindings (Replacing CMD with CTRL for Windows)
config.keys = {
  -- Reload Config
  { key = "r", mods = "CTRL|SHIFT", action = act.ReloadConfiguration },
  -- Close Surface (Tab)
  { key = "x", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },
  -- New Window
  { key = "n", mods = "CTRL|SHIFT", action = act.SpawnWindow },
  -- Tabs
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(1) },
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivateTabRelative(-1) },
  { key = ",", mods = "CTRL|SHIFT", action = act.MoveTabRelative(-1) },
  { key = ".", mods = "CTRL|SHIFT", action = act.MoveTabRelative(1) },
  -- Quick Tab Switch
  { key = "1", mods = "CTRL|SHIFT", action = act.ActivateTab(0) },
  { key = "2", mods = "CTRL|SHIFT", action = act.ActivateTab(1) },
  { key = "3", mods = "CTRL|SHIFT", action = act.ActivateTab(2) },
  { key = "4", mods = "CTRL|SHIFT", action = act.ActivateTab(3) },
  { key = "5", mods = "CTRL|SHIFT", action = act.ActivateTab(4) },
  { key = "6", mods = "CTRL|SHIFT", action = act.ActivateTab(5) },
  { key = "7", mods = "CTRL|SHIFT", action = act.ActivateTab(6) },
  { key = "8", mods = "CTRL|SHIFT", action = act.ActivateTab(7) },
  { key = "9", mods = "CTRL|SHIFT", action = act.ActivateTab(8) },
  -- Splits
  { key = "/", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
  { key = "-", mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
  { key = "j", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Down") },
  { key = "k", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Up") },
  { key = "h", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Left") },
  { key = "l", mods = "CTRL|SHIFT", action = act.ActivatePaneDirection("Right") },
  { key = "z", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },
  { key = "e", mods = "CTRL|SHIFT", action = act.PaneSelect({ mode = "SwapWithActive" }) },
}

-- Copy on Select (WezTerm doesn't support this directly, but you can map a shortcut)
config.mouse_bindings = {
  {
    event = { Up = { streak = 1, button = "Left" } },
    mods = "NONE",
    action = act.CompleteSelection("ClipboardAndPrimarySelection"),
  },
}
config.default_prog = { "wsl.exe", "--distribution", "Ubuntu" }
-- config.default_cwd = "/home/caneppelevitor"

return config