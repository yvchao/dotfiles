local wezterm = require("wezterm")
local os = require("os")
local act = wezterm.action

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- No need to check for updates
config.check_for_updates = false

config.front_end = "WebGpu"

-- Font setup
config.font = wezterm.font_with_fallback({
	-- { family = "Maple Mono NF", harfbuzz_features = { "cv01=1", "cv04=1", "ss01=0", "ss04=0" } },
	{ family = "Iosevka Term SS14", harfbuzz_features = { "calt=0" } },
	{ family = "Hack Nerd Font Mono" },
	{ family = "Symbols Nerd Font Mono" },
	{ family = "Twemoji" },
})
-- config.harfbuzz_features = { "calt=1", "clig=0", "liga=0" }
config.font_size = 12
config.warn_about_missing_glyphs = false

-- Color scheme
config.color_scheme = "kanagawabones"

-- Default shell
config.default_prog = { "/usr/bin/fish", "-l" }

config.launch_menu = {
	{
		label = "Htop",
		args = { "htop" },
	},
	{
		label = "Bottom",
		args = { "btm" },
	},
	{
		label = "Bash",
		args = { "bash", "-l" },
	},
}

-- IME
config.use_ime = true

config.enable_wayland = true

-- Appearance
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.initial_cols = 120
config.initial_rows = 30

config.window_padding = {
	left = 2,
	right = 2,
	top = 0,
	bottom = 0,
}

-- Key binding
config.disable_default_key_bindings = true

wezterm.on("switch_ime", function(window, pane)
	os.execute("fcitx5-remote -t")
end)

config.leader = { key = "a", mods = "ALT", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "l", mods = "LEADER", action = wezterm.action.ShowLauncher },
	{ key = "p", mods = "CTRL|SHIFT", action = act.ActivateCommandPalette },
	{ key = "x", mods = "CTRL|SHIFT", action = act.ActivateCopyMode },
	{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },
	{ key = "t", mods = "CTRL|SHIFT", action = act.SpawnTab("DefaultDomain") },
	{ key = "v", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },
	{ key = "c", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
	{ key = " ", mods = "WIN", action = act.EmitEvent("switch_ime") },
}

for i = 1, 8 do
	-- CTRL + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "ALT",
		action = act.ActivateTab(i - 1),
	})
end

-- local xcursor_size = nil
-- local xcursor_theme = nil
--
-- local success, stdout, stderr =
-- 	wezterm.run_child_process({ "gsettings", "get", "org.gnome.desktop.interface", "cursor-theme" })
-- if success then
-- 	xcursor_theme = stdout:gsub("'(.+)'\n", "%1")
-- end
--
-- local success, stdout, stderr =
-- 	wezterm.run_child_process({ "gsettings", "get", "org.gnome.desktop.interface", "cursor-size" })
-- if success then
-- 	xcursor_size = tonumber(stdout)
-- end
--
-- config.xcursor_theme = xcursor_theme
-- config.xcursor_size = xcursor_size

return config
