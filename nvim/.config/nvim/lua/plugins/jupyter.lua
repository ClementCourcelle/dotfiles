return {
	{
		"kiyoon/jupynium.nvim",
		-- build = "pip3 install --user .",
		build = "python3 -m pip install .",
		-- build = "uv pip install . --python=$HOME/.virtualenvs/jupynium/bin/python",
		-- build = "conda run --no-capture-output -n jupynium pip install .",
	},
	"rcarriga/nvim-notify", -- optional
	"stevearc/dressing.nvim", -- optional, UI for :JupyniumKernelSelect
	config = function()
		require("jupynium").setup({
			-- default_notebook_URL = "localhost:8888/nbclassic",
			jupyter_command = { "BROWSER=firefox jupyter" },
		})
	end,
}
