local M = {}
local function get_os()
	-- ask LuaJIT first
	if jit then
		return jit.os
	end

	local os_name = "Windows"
	-- Unix, Linux variants
	local fh, err = assert(io.popen("uname -s 2>/dev/null", "r"))
	if fh then
		os_name = fh:read()
	end

	if os_name == "Darwin" then
		return "OSX"
	else
		return os_name
	end
end

M.os_name = get_os()

M.major_mod = function()
	if M.os_name == "OSX" then
		return "CMD"
	else
		return "CTRL"
	end
end

M.default_shell = function()
	if M.os_name == "Windows" then
		return "pwsh"
	elseif M.os_name == "OSX" then
		return "/bin/zsh"
	else
		return "/usr/bin/fish"
	end
end

return M
