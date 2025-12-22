return {
	"alexghergh/nvim-tmux-navigation",
	config = function()
		require("nvim-tmux-navigation").setup({
			disable_when_zoomed = true, -- defaults to false
			keybindings = {
				left = "^[h",
				down = "^[j",
				up = "^[k",
				right = "^[l",
				-- last_active = "<C-\\>",
				-- next = "<C-Space>",
			},
		})
	end,
}
