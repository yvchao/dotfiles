---@diagnostic disable: unused-local, redefined-local, undefined-field
local wezterm = require("wezterm")
local module = {}
function module.apply(config)
	-- set domains
	config.ssh_domains = {
		-- {
		-- 	name = "MyServer",
		-- 	remote_address = "192.131.142.134:11451",
		-- 	username = "parsifa1",
		-- 	default_prog = { "fish" },
		-- 	assume_shell = "Posix",
		-- 	local_echo_threshold_ms = 500,
		-- },
		-- {
		-- 	name = "Nix",
		-- 	remote_address = "127.0.0.1:14514",
		-- 	username = "parsifa1",
		-- 	multiplexing = "None",
		-- 	default_prog = { "fish" },
		-- 	assume_shell = "Posix",
		-- 	no_agent_auth = true,
		-- },
	}
	-- config.wsl_domains = {
	-- {
	-- 	name = "WSL:NixOS",
	-- 	distribution = "NixOS",
	-- },
	-- }
	config.unix_domains = {}

	-- launch_menu
	local launch_menu = {
		{
			label = "Bottom",
			args = { "/usr/local/bin/btm" },
		},
		{
			label = "Z Shell",
			args = { "/bin/zsh", "-l" },
		},
		{
			label = "Fish Shell",
			args = { "/usr/bin/fish", "-l" },
		},
		{
			label = "Bash",
			args = { "/bin/bash", "-l" },
		},
	}
	-- local launch_menu = {
	-- { label = "❄️ Nix", domain = { DomainName = "Nix" } },
	-- { label = "🍥 MyServer", domain = { DomainName = "MyServer" } },
	-- { label = "WSL:Nixos", domain = { DomainName = "WSL:NixOS" } },
	-- }
	-- if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	-- 	table.insert(launch_menu, 2, {
	-- 		label = "🦚 Local",
	-- 		domain = { DomainName = "local" },
	-- 		args = { "pwsh", "-NoLogo" },
	-- 	})
	-- end
	config.launch_menu = launch_menu
end

return module
