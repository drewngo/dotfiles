local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.color_scheme = 'Eva (base16)'
-- config.window_background_opacity = 0.65
config.font = wezterm.font 'JetBrainsMono Nerd Font'
config.font_size = 18.0

--config.window_decorations = "NONE"
config.enable_tab_bar = true

config.window_padding = {
    left = 20,
    right = 20,
    top = 20,
    bottom = 20,
}

config.native_macos_fullscreen_mode = false

config.keys = {
    {
        key = 'n',
        mods = 'SHIFT|CTRL',
        action = wezterm.action.ToggleFullScreen,
    },
}

return config
