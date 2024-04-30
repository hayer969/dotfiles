require("user.launch")
require("user.options")
require("user.keymaps")
require("user.autocommands")
spec("user.colorscheme")
spec("user.bbye")
spec("user.treesitter")
spec("user.lspconfig")
spec("user.mason")
spec("user.cmp")
spec("user.telescope")
-- spec ("user.autopairs")
spec("user.comment")
spec("user.gitsigns")
spec("user.bufferline")
spec("user.none-ls")
spec("user.nvim-tree")
spec("user.lualine")
spec("user.toggleterm")
spec("user.project")
spec("user.indentline")
spec("user.alpha")
spec("user.dap")
spec("user.markdown")
spec("user.whichkey")
spec("user.illuminate")
spec("user.harpoon")
require("user.lazy")

-- My functions:
-- Delete string duplicates by pattern, can keep first, last or none of duplicates, none by default
-- Usage:
-- lua huniq(pattern)
-- lua huniq(pattern, "first")
function huniq(pattern, keep)
	keep = keep or "none"
	keep = string.lower(keep)
	local out = vim.api.nvim_exec2("%s/" .. pattern .. "//ne", { output = true }).output
	local answer = string.sub(out, 1, 2)
	if answer ~= "1 " then
		local save_cursor = vim.fn.getcurpos()
		if keep == "none" then
			vim.cmd("g/" .. pattern .. "/d")
		elseif keep == "first" then
			vim.fn.setcursorcharpos(1, 1)
			local line = vim.fn.search(pattern, "nc")
			vim.cmd(line + 1 .. ",$g/" .. pattern .. "/d")
		elseif keep == "last" then
			vim.cmd("normal G$")
			local line = vim.fn.search(pattern, "nbc")
			vim.cmd("1," .. line - 1 .. "g/" .. pattern .. "/d")
		end
		vim.fn.setpos(".", save_cursor)
	end
end

-- Useful macros:
-- Macro for checking duplicates in all file line by line
-- Don't forget in the pattern use double backslash for begin and end of the pattern: \\zs \\ze
-- let @f=":s/{pattern}/\\=setreg('u', submatch(0))/ne\<Enter>:lua huniq('\<C-r>u', 'First')\<Enter>j"
-- Usage, set to first line and do something like: 111@f
--
-- Macro for increment lists or steps in file.
-- let @i="/{pattern}\<Enter>wciw\<C-r>c\<Esc>\<C-a>\"cyiw$"
-- For example we have lines:
-- # STEP 1
-- # STEP 2
-- and so on, set cursor before first STEP and do:
-- let @c="0"
-- let @i="/STEP \<Enter>wciw\<C-r>c\<Esc>\<C-a>\"cyiw$"
-- set nowrapscan
-- 111@i
