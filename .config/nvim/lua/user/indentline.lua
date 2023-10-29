local status_ok, indent_blankline = pcall(require, "ibl")
if not status_ok then
	return
end

local config = {
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
}

indent_blankline.setup(config)
