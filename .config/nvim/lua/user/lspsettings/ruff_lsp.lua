return {
	filetypes = { "python" },
	init_options = {
		settings = {
			-- Any extra CLI arguments for `ruff` go here.
			args = { "--config=" .. vim.fn.stdpath("config") .. "/ruff.toml" },
		},
	},
}
