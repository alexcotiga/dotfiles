local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- Gruber Darker is a dark-only theme, so no light/dark auto-switch.
-- WezTerm ships this palette as the built-in "Gruber (base16)" scheme.
config.color_scheme = "Gruber (base16)"
config.font = wezterm.font("Hack Nerd Font")
config.font_size = 15.0
config.window_background_opacity = 0.8
config.macos_window_background_blur = 50
config.hide_tab_bar_if_only_one_tab = true
config.window_decorations = "RESIZE"
config.use_fancy_tab_bar = true

return config
