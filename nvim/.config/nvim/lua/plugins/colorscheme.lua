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
	"neanias/everforest-nvim",
	version = false,
	lazy = false,
	priority = 1000, -- make sure to load this before all the other start plugins
	-- Optional; default configuration will be used if setup isn't called.
	config = function()
		local everforest = require("everforest")
		require("everforest").setup({
			-- Your config here
		})
		everforest.load()
		WatchThemeFile()
	end,
}
