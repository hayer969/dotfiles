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
keymap("n", "<Leader>e", "<cmd>Lex 45<CR>", opts)

-- Multiline navigation
keymap("n", "j", "gj", opts)

-- Multiline navigation
keymap("n", "k", "gk", opts)

-- Open buffer in new tab
keymap("n", "<Leader>t", "<cmd>tab split<CR>", opts)

-- Change word and find next match
keymap("n", "<Leader>c", ":let @/=\"<C-r><C-w>\"<CR>gnc", opts)

-- Clear highlights
keymap("n", "<Leader>h", "<cmd>nohlsearch<CR>", opts)

-- Close buffers
keymap("n", "<S-q>", "<cmd>bdelet!<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Insert Mode --
-- Remap ESC to ii
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)

-- Visual Mode --
-- Set cursor to the end of selection after yanking
keymap("v", "y", "ygv<Esc>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Put in the search buffer
keymap("v", "<Leader>f", "\"*y:let @/=\"<C-r>*\"<CR>gv<Esc>", opts)
-- Change selection and find next match
keymap("v", "<Leader>c", "\"*y:let @/=\"<C-r>*\"<CR>gvc", opts)

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
keymap("n", "<C-Left>", "<cmd>vertical resize -3 <CR>", opts)
keymap("n", "<C-Right>", "<cmd>vertical resize +3 <CR>", opts)
keymap("n", "<C-Up>", "<cmd>resize +3 <CR>", opts)
keymap("n", "<C-Down>", "<cmd>resize -3 <CR>", opts)

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

vim.cmd([[let @r="mj$? *# %% *$\<CR>:.+1,/ *# %% *$/-1yank +\<CR>:b ipython\<CR>i%paste\<Esc>\<Esc>:sl 200m\<CR>i\<CR>\<Esc>\<Esc>:b #\<CR>'j"]])
keymap("n", "<Leader>r", "@r", opts)


-- Plugins --

-- NvimTree
-- keymap("n", "<leader>e", ":NvimTreeToggle<CR>", opts)

-- Telescope
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>ft", "<cmd>Telescope live_grep<CR>", opts)
-- keymap("n", "<leader>fp", "<cmd>Telescope projects<CR>", opts)
keymap("n", "<leader>fb", "<cmd>Telescope buffers<CR>", opts)

-- Git
-- keymap("n", "<leader>gg", "<cmd>lua _LAZYGIT_TOGGLE()<CR>", opts)

-- Comment
-- keymap("n", "<leader>/", "<cmd>lua require('Comment.api').toggle_current_linewise()<CR>", opts)
-- keymap("x", "<leader>/", '<ESC><CMD>lua require("Comment.api").toggle_linewise_op(vim.fn.visualmode())<CR>')

-- DAP
-- keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", opts)
-- keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", opts)
-- keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>", opts)
-- keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>", opts)
-- keymap("n", "<leader>dO", "<cmd>lua require'dap'.step_out()<cr>", opts)
-- keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", opts)
-- keymap("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", opts)
-- keymap("n", "<leader>du", "<cmd>lua require'dapui'.toggle()<cr>", opts)
-- keymap("n", "<leader>dt", "<cmd>lua require'dap'.terminate()<cr>", opts)
