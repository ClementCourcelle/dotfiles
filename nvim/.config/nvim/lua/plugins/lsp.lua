return {
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			local servers = {
				"clangd",
				"lua_ls",
				"pyrefly",
				"rust_analyzer",
			}

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
					},
				},
			})
			vim.diagnostic.config({ virtual_text = true, severity_sort = true })
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = servers,
			})
		end,
	},
}
