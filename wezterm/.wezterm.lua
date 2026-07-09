local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.default_prog = { "C:\\Users\\B1024310\\AppData\\Local\\Programs\\Git\\bin\\bash.exe", "--login", "-i" }


config.color_scheme = 'Dark Pastel'
config.window_background_opacity = 0.65
config.font_size = 12.0
config.initial_cols = 84
config.initial_rows = 40

config.window_decorations = "NONE"
config.enable_tab_bar = false

config.window_padding = {
  left = 20,
  right = 20,
  top = 20,
  bottom = 20,
}

return config
