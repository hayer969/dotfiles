local M = {
	"nvim-treesitter/nvim-treesitter",
	event = { "BufReadPost", "BufNewFile" },
	build = ":TSUpdate",
}

function M.config()
	require("nvim-treesitter.configs").setup({
		ensure_installed = {
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
		},
		auto_install = true,
		highlight = {
			enable = true,
			disable = function(lang, bufnr) -- Disable in large buffers
				return vim.api.nvim_buf_line_count(bufnr) > 50000
			end,
		},
		indent = {
			enable = true,
			disable = function(lang, bufnr) -- Disable in large buffers
				return vim.api.nvim_buf_line_count(bufnr) > 50000
			end,
		},
	})
end

return M
