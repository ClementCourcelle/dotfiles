local function WatchThemeFile()
	local uv = vim.uv
	local theme_file = os.getenv("HOME") .. "/.cache/theme"

	local function apply_theme(err, filename, events)
		if err then
			vim.schedule(function()
				vim.api.nvim_echo({ { "Theme-loader: Error watching file: " .. err, "ErrorMsg" } }, false, {})
			end)
			return
		end

		vim.schedule(function()
			local f = io.open(theme_file, "r")
			if not f then
				return
			end
			local theme = f:read("*l")
			f:close()

			if theme == "light" then
				vim.cmd("set background=light")
			else
				vim.cmd("set background=dark")
			end
		end)
	end

	local handle = uv.new_fs_event()
	uv.fs_event_start(handle, theme_file, {}, apply_theme)
end

return {
	{
		"sainnhe/everforest",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("everforest")
			WatchThemeFile()
		end,
	},
}
