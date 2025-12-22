local ns = { noremap = true, silent = true }

-- Better(?) escape
vim.keymap.set({ "i", "v" }, "<C-l>", "<C-[>", ns)

-- Move down
vim.keymap.set({ "n", "v" }, "<C-e>", "<C-d>", ns)

-- files - FZF
vim.keymap.set("n", "<leader>ff", ":FzfLua files cwd=$SESS_ROOT <CR>", ns)
vim.keymap.set("n", "<leader>FF", ":FzfLua files <CR>", ns)
vim.keymap.set("n", "<leader>fg", ":FzfLua grep cwd=$SESS_ROOT <CR>", ns)
vim.keymap.set("n", "<leader>fw", ":FzfLua grep_cword cwd=$SESS_ROOT <CR>", ns)
vim.keymap.set("n", "<leader>fW", ":FzfLua grep_cWORD cwd=$SESS_ROOT <CR>", ns)
vim.keymap.set("n", "<leader>fb", ":FzfLua buffers <CR>", ns)
vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles <CR>", ns)
vim.keymap.set("n", "<leader>fl", function()
	local recent_file = vim.v.oldfiles[1]
	vim.cmd("edit " .. vim.fn.fnameescape(recent_file))
end, ns)

-- Buffers
vim.keymap.set("n", "<leader><Tab>", ":b# <CR>", ns)
vim.keymap.set("n", "<leader>p", ":bp <CR>", ns)
vim.keymap.set("n", "<leader>n", ":bn <CR>", ns)
vim.keymap.set("n", "<leader>d", ":bn<bar>bd#<CR>", ns)

-- NvimTree
vim.keymap.set("n", "<C-b>", ":NvimTreeToggle <CR>", ns)

-- Format
vim.keymap.set("n", "<leader>q", function()
	vim.lsp.buf.format({
		async = true,
		filter = function(client)
			return client.name == "null-ls"
		end,
	})
end, { desc = "Format buffer" }, ns)

-- Splits
vim.keymap.set("n", "<leader>e", ":vsplit <CR>", ns)
vim.keymap.set("n", "<leader>o", ":split <CR>", ns)
-- vim.keymap.set("n", "<C-h>", "<C-w>h", ns)
-- vim.keymap.set("n", "<C-j>", "<C-w>j", ns)
-- vim.keymap.set("n", "<C-k>", "<C-w>k", ns)
-- vim.keymap.set("n", "<C-l>", "<C-w>l", ns)

-- lsp, linters
-- vim.keymap.set("n", "<leader>gd", ":lua vim.lsp.buf.definition() <CR>", ns)
-- vim.keymap.set("n", "<leader>sd", ":lua vim.diagnostic.open_float() <CR>", ns)

-- Misc
vim.keymap.set("v", "<", "<gv", ns)
vim.keymap.set("v", ">", ">gv", ns)
