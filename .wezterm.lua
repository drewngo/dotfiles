local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Dark Pastel'
config.window_background_opacity = 0.65
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 14.0

--config.window_decorations = "NONE"
config.enable_tab_bar = false

config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

return config
