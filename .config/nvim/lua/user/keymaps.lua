-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Yank to end of Line
keymap("n", "Y", "y$", opts)

-- Paste from yank register 0
keymap("n", "<Leader>p", '"0p', opts)
keymap("n", "<Leader>P", '"0P', opts)

-- Yank from delete reg to yank reg
keymap("n", "<Leader>y", ':let @0=@"<CR>', opts)

-- Multiline navigation
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Open buffer in new tab
keymap("n", "<Leader>t", "<CMD>tab split<CR>", opts)

-- Change word and find next match
keymap("n", "<Leader>c", ':let @/="<C-r><C-w>"<CR>gnc', opts)

-- Clear highlights
keymap("n", "<Esc>", "<CMD>nohlsearch<CR>", opts)
keymap("n", "<Leader>;", "<CMD>nohlsearch<CR>", opts)

-- Close current buffer and keep windows
keymap("n", "<S-q>", "<CMD>Bdelete!<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<CMD>bnext<CR>", opts)
keymap("n", "<S-h>", "<CMD>bprevious<CR>", opts)

-- Put absolute full path
keymap("n", "<Leader>%", "<CMD>put=expand('%:p')<CR>", opts)

-- Insert Mode --
-- Remap ESC to ii
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- More convenient move over the parentheses and so on
keymap("i", "<C-l>", "<Right>", opts)

-- Visual Mode --
-- Set cursor to the end of selection after yanking
keymap("v", "y", "ygv<Esc>", opts)

-- Paste from yank register 0
keymap("v", "<Leader>p", '"0p', opts)
keymap("v", "<Leader>P", '"0P', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Put in the search buffer
keymap("v", "*", "\"*ygv\"+y:let @/='\\V'.substitute(escape(@*, '/\\'), '\\n', '\\\\n', 'g')<CR>gv<Esc>", opts)

-- Change selection and find next match
keymap("v", "<Leader>c", "\"*ygv\"+y:let @/='\\V'.substitute(escape(@*, '/\\'), '\\n', '\\\\n', 'g')<CR>gvc", opts)

-- Command Mode --
keymap("c", "q1", "q!<CR>", opts)

-- Terminal Mode --
-- To map <Esc> to exit terminal-mode:
keymap("t", "<Esc><Esc>", "<C-\\><C-N>", opts)

-- To use `ALT+{h,j,k,l}` to navigate windows from any mode:
keymap("t", "<A-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<A-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<A-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<A-l>", "<C-\\><C-N><C-w>l", opts)
keymap("i", "<A-h>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<A-j>", "<C-\\><C-N><C-w>j", opts)
keymap("i", "<A-k>", "<C-\\><C-N><C-w>k", opts)
keymap("i", "<A-l>", "<C-\\><C-N><C-w>l", opts)
keymap("n", "<A-h>", "<C-w>h", opts)
keymap("n", "<A-j>", "<C-w>j", opts)
keymap("n", "<A-k>", "<C-w>k", opts)
keymap("n", "<A-l>", "<C-w>l", opts)

-- Make adjusting split sizes a bit more friendly
keymap("n", "<C-Left>", "<CMD>vertical resize -3 <CR>", opts)
keymap("n", "<C-Right>", "<CMD>vertical resize +3 <CR>", opts)
keymap("n", "<C-Up>", "<CMD>resize +3 <CR>", opts)
keymap("n", "<C-Down>", "<CMD>resize -3 <CR>", opts)

-- Run ipython cell like in VSCode
-- Doesn't work but want to use local buffers instead global r
-- function Runcell()
-- "" execute "normal mj$? *# %% *$\<CR>:.+1,/ *# %% *$/-1yank +\<CR>:sl 200m\<CR>"
-- "" execute "normal :b ipython\<CR>i"
-- "" let l:nmbr=bufnr("ipython")
-- "" call chansend(l:nmbr, ["i", ""])
-- "" call chansend(l:nmbr, ["%paste", ""])
-- "" execute "normal \<Esc>\<Esc>:b #\<CR>"
-- "let l:r="mj$? *# %% *$\<CR>:.+1,/ *# %% *$/-1yank +\<CR>:sl 200m\<CR>:b ipython\<CR>i%paste\<CR>\<Esc>\<Esc>:b #\<CR>"
-- "execute "normal ".l:r
-- endfunction
-- nnoremap <Leader>r  :call Runcell()<CR>

vim.cmd(
	[[let @r="mJ$? *# %% *$\<CR>:+1,/ *# %% *$/-1yank +\<CR>:b ipython\<CR>i%paste\<Esc>\<Esc>:sl 200m\<CR>i\<CR>\<Esc>\<Esc>`J"]]
)
keymap("n", "<Leader>r", "@r", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- LSP
keymap("n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", "<CMD>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fT", "<CMD>Telescope builtin<CR>", opts)
keymap("n", "<leader>fs", "<CMD>Telescope grep_string<CR>", opts)
keymap("v", "<leader>fs", "<CMD>Telescope grep_string<CR>", opts)
keymap("n", "<leader>fh", "<CMD>Telescope command_history<CR>", opts)
keymap("n", "<leader>fH", "<CMD>Telescope help_tags<CR>", opts)
keymap("n", "<leader>fp", "<CMD>Telescope projects<CR>", opts)
keymap("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)
keymap("n", "<leader>fr", "<CMD>Telescope oldfiles<CR>", opts)
keymap("n", "<leader>fR", "<CMD>Telescope registers<CR>", opts)
keymap("n", "<leader>fk", "<CMD>Telescope keymaps<CR>", opts)
keymap("n", "<leader>fC", "<CMD>Telescope commands<CR>", opts)
keymap("n", "<leader>fm", "<CMD>Telescope harpoon marks<CR>", opts)
keymap("n", "<leader>f@", "<CMD>Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>fws", "<CMD>Telescope lsp_dynamic_workspace_symbols<CR>", opts)
keymap("n", "<leader>/", "<CMD>Telescope current_buffer_fuzzy_find<CR>", opts)

-- Git
keymap("n", "<leader>gg", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", opts)
keymap("n", "<leader>gj", "<CMD>lua require 'gitsigns'.next_hunk()<CR>", opts)
keymap("n", "<leader>gk", "<CMD>lua require 'gitsigns'.prev_hunk()<CR>", opts)
keymap("n", "<leader>gl", "<CMD>lua require 'gitsigns'.blame_line()<CR>", opts)
keymap("n", "<leader>gp", "<CMD>lua require 'gitsigns'.preview_hunk()<CR>", opts)
keymap("n", "<leader>gr", "<CMD>lua require 'gitsigns'.reset_hunk()<CR>", opts)
keymap("n", "<leader>gR", "<CMD>lua require 'gitsigns'.reset_buffer()<CR>", opts)
keymap("n", "<leader>gs", "<CMD>lua require 'gitsigns'.stage_hunk()<CR>", opts)
keymap("n", "<leader>gu", "<CMD>lua require 'gitsigns'.undo_stage_hunk()<CR>", opts)
keymap("n", "<leader>go", "<CMD>Telescope git_status<CR>", opts)
keymap("n", "<leader>gb", "<CMD>Telescope git_branches<CR>", opts)
keymap("n", "<leader>gc", "<CMD>Telescope git_commits<CR>", opts)
keymap("n", "<leader>gd", "<CMD>Gitsigns diffthis HEAD<CR>", opts)

-- DAP
keymap("n", "<leader>db", "<CMD>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dB", "<CMD>lua require'dap'.set_breakpoint(vim.fn.input(\"Breakpoint condition: \"))<CR>", opts)
keymap("n", "<leader>dH", "<CMD>lua require'dap'.set_breakpoint(nil, vim.fn.input(\"Hit condition: \"))<CR>", opts)
keymap(
	"n",
	"<leader>dL",
	"<CMD>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input(\"Log point message: \"))<CR>",
	opts
)
keymap("n", "<leader>dc", "<CMD>lua require'dap'.continue()<CR>", opts)
keymap("n", "<F5>", "<CMD>lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>di", "<CMD>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<F2>", "<CMD>lua require'dap'.step_into()<CR>", opts)
keymap("n", "<leader>do", "<CMD>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<F3>", "<CMD>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<leader>dO", "<CMD>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<F4>", "<CMD>lua require'dap'.step_out()<CR>", opts)
keymap("n", "<leader>dr", "<CMD>lua require'dap'.repl.toggle()<CR>", opts)
keymap("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<CR>", opts)
keymap("n", "<leader>du", "<CMD>lua require'dapui'.toggle()<CR>", opts)
keymap("n", "<leader>dq", "<CMD>lua require'dap'.terminate()<CR>", opts)
keymap("n", "<leader>ds", "gv<CMD>lua require'dap-python'.debug_selection()<CR>", opts)
keymap("v", "<leader>ds", "<CMD>lua require'dap-python'.debug_selection()<CR>", opts)
keymap("n", "<leader>dtc", "<CMD>lua require'dap-python'.test_class()<CR>", opts)
keymap("n", "<leader>dtm", "<CMD>lua require'dap-python'.test_method()<CR>", opts)

-- Harpoon
keymap("n", "<leader>hm", "<CMD>lua require'harpoon.mark'.add_file()<CR>", opts)
keymap("n", "<leader>hu", "<CMD>lua require'harpoon.ui'.toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>hc", "<CMD>lua require'harpoon.cmd-ui'.toggle_quick_menu()<CR>", opts)
keymap("n", "<leader>hn", "<CMD>lua require'harpoon.ui'.nav_next()<CR>", opts)
keymap("n", "<leader>hp", "<CMD>lua require'harpoon.ui'.nav_prev()<CR>", opts)
keymap("n", "<A-1>", "<CMD>lua require'harpoon.ui'.nav_file(1)<CR>", opts)
keymap("n", "<A-2>", "<CMD>lua require'harpoon.ui'.nav_file(2)<CR>", opts)
keymap("n", "<A-3>", "<CMD>lua require'harpoon.ui'.nav_file(3)<CR>", opts)
keymap("n", "<A-4>", "<CMD>lua require'harpoon.ui'.nav_file(4)<CR>", opts)
keymap("n", "<C-F1>", "<CMD>lua require'harpoon.term'.gotoTerminal(1)<CR>", opts)
keymap("n", "<C-F2>", "<CMD>lua require'harpoon.term'.gotoTerminal(2)<CR>", opts)
keymap("n", "<C-F3>", "<CMD>lua require'harpoon.term'.gotoTerminal(3)<CR>", opts)
keymap("n", "<leader>h1", "<CMD>lua require'harpoon.term'.sendCommand(1, 1)<CR>", opts)
keymap("n", "<leader>h2", "<CMD>lua require'harpoon.term'.sendCommand(1, 2)<CR>", opts)
keymap("n", "<leader>h3", "<CMD>lua require'harpoon.term'.sendCommand(1, 3)<CR>", opts)
keymap("n", "<leader>h4", "<CMD>lua require'harpoon.term'.sendCommand(1, 4)<CR>", opts)

-- Spelling
keymap("n", "<leader>xse", ":setlocal spell spelllang=en<CR>", opts)
keymap("n", "<leader>xsr", ":setlocal spell spelllang=ru<CR>", opts)
keymap("n", "<leader>xsn", ":setlocal spell spelllang=<CR>", opts)

-- Kubernetes
keymap("n", "<leader>kf", ":!d8 k apply -f %<CR>", opts)
keymap("n", "<leader>kk", ":!d8 k apply -k %:p:h<CR>", opts)
keymap("n", "<leader>kdf", ":!d8 k delete -f % --ignore-not-found --wait=false<CR>", opts)
keymap("n", "<leader>kdk", ":!d8 k delete -k %:p:h --ignore-not-found --wait=false<CR>", opts)

--Open with different codes and other staff
-- Open with cp1251
keymap("n", "<leader>xoc", ":e ++enc=cp1251<CR>", opts)
-- Open as binary
keymap("n", "<leader>xob", ":e ++bin<CR>", opts)
-- Open as text (default mode)
keymap("n", "<leader>xot", ":e ++nobin<CR>", opts)

-- Save in utf-8
keymap("n", "<leader>xcu", ":set fenc=utf-8<CR>", opts)
-- Set line endings to unix style
keymap("n", "<leader>xeu", ":set ff=unix<CR>", opts)
-- Set line endings to dos style
keymap("n", "<leader>xed", ":set ff=dos<CR>", opts)
-- Display as HEX
keymap("n", "<leader>xhh", ":%!xxd<CR>", opts)
-- Convert from HEX
keymap("n", "<leader>xhr", ":%!xxd -r<CR>", opts)
-- Write with sudo, don't know how to input password
--[[ keymap("n", "<leader>xws", ":w !sudo -S tee % > /dev/null<CR>", opts) ]]
