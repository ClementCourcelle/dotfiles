return {
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").setup({
				-- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
				install_dir = vim.fn.stdpath("data") .. "/site",
			})
			require("nvim-treesitter").install({
				-- A list of parser names, or "all" (the listed parsers MUST always be installed)
				"c",
				"cpp",
				"css",
				"html",
				"python",
				"rust",
				"lua",
				"vim",
				"vimdoc",
				"diff",
				"git_config",
				"git_rebase",
				"gitcommit",
				"gitignore",
				"query",
				"markdown",
				"markdown_inline",
				"yaml",
				"json",
				"bash",
				"glsl",
				"make",
				"cmake",
				"xml",
				"dockerfile",
			})

			vim.filetype.add({
				extension = {
					traj = "json",
					launch = "xml",
				},
			})
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		opts = {
			enable = true,
			line_numbers = true,
			mode = "cursor",
			max_lines = 4,
		},
		event = "VeryLazy",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
