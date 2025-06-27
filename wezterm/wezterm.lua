local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Font Settings

config.font = wezterm.font("DankMono Nerd Font")
config.font_size = 18.0

-- Color Scheme

config.color_scheme = "Kanagawa (Gogh)"

-- Window Stuff

config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}
config.initial_cols = 240
config.initial_rows = 72

-- Misc

config.prefer_egl = true

return config
