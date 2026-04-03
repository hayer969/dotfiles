local M = {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
    branch = "main",
}

function M.config()
	require("nvim-treesitter").install({
			"lua",
			"markdown",
			"markdown_inline",
			"bash",
			"python",
			"css",
			"c",
			"cpp",
			"cmake",
			"diff",
			"dockerfile",
			"fish",
			"html",
			"json",
			"json5",
			"java",
			"javascript",
			"latex",
			"rust",
			"sql",
			"regex",
			"toml",
			"yaml",
			"vim",
			"vimdoc",
			"query",
			"typescript",
			"xml",
		})
end

return M
