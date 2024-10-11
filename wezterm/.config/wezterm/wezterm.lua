local wezterm = require("wezterm")

local helpers = require("lua.helpers")
local style = require("lua.style")
local keymap = require("lua.keymap")
local domains = require("lua.domains")
local config = wezterm.config_builder()

style.apply(config)
keymap.apply(config)
domains.apply(config)

-- No need to check for updates
config.check_for_updates = false

config.front_end = "OpenGL"
config.webgpu_power_preference = "HighPerformance"

config.max_fps = 144
config.animation_fps = 144
config.default_domain = "local"

config.warn_about_missing_glyphs = false

-- Color scheme
config.color_scheme = "kanagawabones"

-- Default shell
config.default_prog = { helpers.default_shell() }

-- IME
config.use_ime = true

-- Appearance
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.initial_cols = 160
config.initial_rows = 42

return config
