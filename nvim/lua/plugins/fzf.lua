return {
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
			{ "junegunn/fzf", build = "./install --bin" },
		},
		config = function()
			require("fzf-lua").setup({
				winopts = {
					width = 0.95,
					height = 0.9,
					preview = {
						horizontal = "right:40%",
					},
				},
			})
		end,
		cmd = "FzfLua",
	},
}
