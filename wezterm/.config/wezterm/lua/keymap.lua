---@diagnostic disable: unused-local, redefined-local, undefined-field
local wezterm = require("wezterm")
local helpers = require("lua.helpers")

local major_mod = helpers.major_mod()

local module = {}
function module.apply(config)
	-- key config
	config.leader = { key = "#", mods = "ALT|SHIFT", timeout_milliseconds = 5000 }
	config.keys = {
		{
			key = "c",
			mods = major_mod,
			action = wezterm.action_callback(function(window, pane)
				local sel = window:get_selection_text_for_pane(pane)
				if pane:is_alt_screen_active() or (not sel or sel == "") then
					window:perform_action(wezterm.action.SendKey({ key = "c", mods = "CTRL" }), pane)
				else
					window:perform_action(wezterm.action({ CopyTo = "ClipboardAndPrimarySelection" }), pane)
				end
			end),
		},
		{ key = "v", mods = major_mod, action = wezterm.action.PasteFrom("Clipboard") },
		-- set launch_menu
		{
			key = "Space",
			mods = "LEADER",
			action = wezterm.action.ShowLauncherArgs({ flags = "LAUNCH_MENU_ITEMS" }),
		},
		{
			key = ":",
			mods = major_mod .. "|SHIFT",
			action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
		},
		{
			key = '"',
			mods = major_mod .. "|SHIFT",
			action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
		},
		{
			key = "d",
			mods = "LEADER",
			action = wezterm.action.SwitchToWorkspace({
				name = "default",
			}),
		},
		{
			key = "m",
			mods = "LEADER",
			action = wezterm.action.SwitchToWorkspace({
				name = "monitor",
				spawn = {
					args = { "/usr/bin/env", "btm" },
				},
			}),
		},
		{
			key = "w",
			mods = "LEADER",
			action = wezterm.action.PromptInputLine({
				description = wezterm.format({
					{ Attribute = { Intensity = "Bold" } },
					{ Foreground = { AnsiColor = "Fuchsia" } },
					{ Text = "Enter name of workspace" },
				}),
				action = wezterm.action_callback(function(window, pane, line)
					-- line will be `nil` if they hit escape without entering anything
					-- An empty string if they just hit enter
					-- Or the actual line of text they wrote
					if line then
						window:perform_action(
							wezterm.action.SwitchToWorkspace({
								name = line,
							}),
							pane
						)
					end
				end),
			}),
		},
		{
			key = "d",
			mods = major_mod .. "|SHIFT",
			action = wezterm.action.DetachDomain("CurrentPaneDomain"),
		},
		-- INFO: Send <C-Enter> to the terminal
		-- {
		-- 	key = "Enter",
		-- 	mods = "CTRL",
		-- 	action = wezterm.action.SendKey({ key = "Enter", mods = "CTRL" }),
		-- },
		-- Change Active Pane
		{ key = "h", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Left") },
		{ key = "l", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Right") },
		{ key = "k", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Up") },
		{ key = "j", mods = "LEADER", action = wezterm.action.ActivatePaneDirection("Down") },
	}
	for i = 1, 8 do
		-- CTRL+ALT + number to activate that tab
		table.insert(config.keys, {
			key = tostring(i),
			mods = major_mod,
			action = wezterm.action.ActivateTab(i - 1),
		})
	end
end

return module
