---@diagnostic disable: unused-local, redefined-local, undefined-field
local wezterm = require("wezterm")
local helpers = require("lua.helpers")
local font_size = helpers.os_name == "Linux" and 10 or 13.5

local function get_font_fallback()
	if helpers.os_name == "Linux" then
		return {
			-- { family = "Maple Mono NF", harfbuzz_features = { "cv01=1", "cv04=1", "ss01=0", "ss04=0" } },
			{ family = "Iosevka Term SS14", harfbuzz_features = { "calt=1" } },
			{ family = "Hack Nerd Font Mono" },
			{ family = "Symbols Nerd Font Mono" },
			{ family = "Twemoji", assume_emoji_presentation = true },
		}
	else
		return {}
	end
end

local module = {}
function module.apply(config)
	-- fonts
	config.font_size = font_size
	config.line_height = 1.0
	config.cell_width = 1.0
	config.unicode_version = 14
	config.font = wezterm.font_with_fallback(get_font_fallback())
	config.warn_about_missing_glyphs = false
	-- config.harfbuzz_features = { "calt=1", "clig=0", "liga=0" }

	-- padding
	config.window_padding = {
		left = "0cell",
		right = "0cell",
		top = "0.15cell",
		bottom = "0cell",
	}

	-- colors
	config.window_frame = {
		font = wezterm.font("Roboto"),
		font_size = 0.8 * font_size,
		active_titlebar_bg = "#282828",
		inactive_titlebar_bg = "#282828",
		-- "#31313f",
	}

	config.colors = { tab_bar = { inactive_tab_edge = "#282828" } }
	-- "#31313f"

	-- custom title name
	wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
		return " ᕕ( ᐛ )ᕗ "
	end)

	-- set startup window position
	wezterm.on("gui-attached", function(domain)
		local workspace = wezterm.mux.get_active_workspace()
		for _, window in ipairs(wezterm.mux.all_windows()) do
			window:gui_window():set_position(185, 45)
		end
	end)

	-- set tab title
	wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
		local icon = {
			Nix = wezterm.nerdfonts.linux_nixos .. " Nix",
			MyServer = wezterm.nerdfonts.dev_msql_server .. " Server",
			["local"] = wezterm.nerdfonts.linux_nixos .. " Local",
		}
		local title = icon[tab.active_pane.domain_name] or tab.active_pane.title

		local foreground = "#666666"
		if tab.is_active then
			foreground = "white"
		end
		return {
			-- "#31313f",
			{ Background = { Color = "#282828" } },
			{ Foreground = { Color = foreground } },
			{ Text = " " .. title .. " [" .. tab.tab_index + 1 .. "]" .. " " },
		}
	end)

	-- status
	wezterm.on("update-status", function(window)
		local color_scheme = window:effective_config().resolved_palette
		local bg = color_scheme.background
		local fg = color_scheme.foreground

		window:set_right_status(wezterm.format({
			{ Background = { Color = "none" } },
			{ Foreground = { Color = fg } },
			{ Text = window:active_workspace() },
			{ Background = { Color = "none" } },
			{ Foreground = { Color = fg } },
			{ Text = " | " .. wezterm.hostname() .. " " },
		}))
	end)
end

return module
