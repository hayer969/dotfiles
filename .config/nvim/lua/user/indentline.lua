local M = {
	"lukas-reineke/indent-blankline.nvim",
	main = "ibl",
	opts = {},
	event = "VeryLazy",
}

function M.config()
	require("ibl").setup({

		indent = {
			char = "▏",
		},
		scope = { show_start = false, show_end = false },
		whitespace = {
			remove_blankline_trail = false,
		},
		exclude = {
			buftypes = { "terminal", "nofile" },
			filetypes = { "help", "packer", "NvimTree" },
		},
	})
end

return M
