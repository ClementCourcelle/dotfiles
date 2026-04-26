return {
	"jay-babu/mason-null-ls.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"nvimtools/none-ls.nvim",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local null_ls = require("null-ls")

		local format_group = vim.api.nvim_create_augroup("Format", { clear = true })

		local clang = null_ls.builtins.formatting.clang_format.with({
			extra_args = { "--style=file:" .. vim.fn.expand("~/.config/clang-format/.clang-format") },
		})
		local black = null_ls.builtins.formatting.black.with({
			extra_args = { "--line-length", "100", "--skip-string-normalization" },
		})
		local stylua = null_ls.builtins.formatting.stylua

		null_ls.setup({
			sources = {
				clang,
				black,
				stylua,
			},

			require("mason-null-ls").setup({
				ensure_installed = {
					"clang-format",
					"black",
					"stylua",
				},
				automatic_installation = true,
			}),

			on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = format_group, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = format_group,
						buffer = bufnr,
						callback = function()
							vim.lsp.buf.format({
								bufnr = bufnr,
								async = false,
								filter = function(client)
									return client.name == "null-ls"
								end,
							})
						end,
					})
				end
			end,
		})
	end,
}
