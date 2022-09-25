-- Shorten function name
local keymap = vim.keymap.set
-- Silent keymap option
local opts = { silent = true }

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "

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

-- Open explorer
-- keymap("n", "<Leader>e", "<CMD>Lex 45<CR>", opts)

-- Multiline navigation
keymap("n", "j", "gj", opts)

-- Multiline navigation
keymap("n", "k", "gk", opts)

-- Open buffer in new tab
keymap("n", "<Leader>t", "<CMD>tab split<CR>", opts)

-- Change word and find next match
keymap("n", "<Leader>c", ":let @/=\"<C-r><C-w>\"<CR>gnc", opts)

-- Clear highlights
keymap("n", "<Leader>h", "<CMD>nohlsearch<CR>", opts)

-- Close current buffer and keep windows
keymap("n", "<S-q>", "<CMD>buffer #<CR><CMD>Bdelete! #<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<CMD>bnext<CR>", opts)
keymap("n", "<S-h>", "<CMD>bprevious<CR>", opts)

-- Don't touch unnamed register by X
keymap("n", "x", '"_x', opts)
keymap("n", "X", '"_X', opts)

-- Don't touch unnamed register by C
keymap("n", "c", '"_c', opts)
keymap("n", "C", '"_C', opts)

-- Insert Mode --
-- Remap ESC to ii
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- More convenient move over the parentheses and so on
keymap("i", "<C-l>", "<Right>", opts)

-- Visual Mode --
-- Set cursor to the end of selection after yanking
keymap("v", "y", "ygv<Esc>", opts)

-- Better paste
-- just 'P' also should work
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Put in the search buffer
keymap("v", "<Leader>f", "\"*y:let @/=\"<C-r>*\"<CR>gv<Esc>", opts)
-- Change selection and find next match
keymap("v", "<Leader>c", "\"*y:let @/=\"<C-r>*\"<CR>gvc", opts)

-- Don't touch unnamed register by X
keymap("v", "x", '"_x', opts)
keymap("v", "X", '"_X', opts)

-- Don't touch unnamed register by C
keymap("v", "c", '"_c', opts)
keymap("v", "C", '"_C', opts)

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

vim.cmd([[let @r="mJ$? *# %% *$\<CR>:+1,/ *# %% *$/-1yank +\<CR>:b ipython\<CR>i%paste\<Esc>\<Esc>:sl 200m\<CR>i\<CR>\<Esc>\<Esc>`J"]])
keymap("n", "<Leader>r", "@r", opts)

-- Plugins --

-- NvimTree
keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<CMD>Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", "<CMD>Telescope live_grep<CR>", opts)
keymap("n", "<leader>fh", "<CMD>Telescope command_history<CR>", opts)
-- keymap("n", "<leader>fp", "<CMD>Telescope projects<CR>", opts)
keymap("n", "<leader>fb", "<CMD>Telescope buffers<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<CMD>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
keymap("n", "<leader>/", "<CMD>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle.linewise(vim.fn.visualmode())<CR>', opts)
keymap("x", "<leader><leader>/", '<ESC><CMD>lua require("Comment.api").toggle.blockwise(vim.fn.visualmode())<CR>', opts)

-- DAP
-- keymap("n", "<leader>db", "<CMD>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<CMD>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<CMD>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<CMD>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<CMD>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<CMD>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<CMD>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<CMD>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<CMD>lua require'dap'.terminate()<cr>", opts)
