local function on_attach_km(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.del("n", "<CR>", { buffer = bufnr })

	vim.keymap.set("n", "<CR>", function()
		local node = api.tree.get_node_under_cursor()
		api.node.open.edit()
		if node.type == "file" then
			api.tree.close()
		end
	end, opts("Open file and close tree"))

	vim.keymap.set("n", "O", function()
		local node = api.tree.get_node_under_cursor()
		api.node.open.horizontal_no_picker()
		if node.type == "file" then
			api.tree.close()
		end
	end, opts("Open file in horizontal split"))

	vim.keymap.set("n", "E", function()
		local node = api.tree.get_node_under_cursor()
		api.node.open.vertical_no_picker()
		if node.type == "file" then
			api.tree.close()
		end
	end, opts("Open file in vertical split"))
end

return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({
			update_focused_file = {
				enable = true,
				update_root = {
					enable = false,
					ignore_list = {},
				},
				exclude = false,
			},
			view = {
				adaptive_size = true,
			},
			on_attach = on_attach_km,
		})
	end,
}
