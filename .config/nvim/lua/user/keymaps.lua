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
-- Multiline navigation
keymap("n", "j", "gj", opts)
-- Multiline navigation
keymap("n", "k", "gk", opts)
-- Open new tab
keymap("n", "<Leader>t", "<cmd>tabnew<CR>", opts)
-- Yank to the OS buffer
keymap("n", "<Leader>y", '"+y', opts)
-- Paste from the OS buffer
keymap("n", "<Leader>p", '"+p', opts)
keymap("n", "<Leader>P", '"+P', opts)
-- Delete to the OS buffer
keymap("n", "<Leader>d", '"+d', opts)
keymap("n", "<Leader>D", '"+D', opts)
-- Change word and find next match
keymap("n", "<Leader>c", "*``gnc", opts)
-- Clear highlights
keymap("n", "<Leader>h", "<cmd>nohlsearch<CR>", opts)
-- Close buffers
keymap("n", "<S-q>", "<cmd>Bdelete!<CR>", opts)
-- Navigate buffers
keymap("n", "<S-l>", "<cmd>bnext<CR>", opts)
keymap("n", "<S-h>", "<cmd>bprevious<CR>", opts)

-- Insert Mode --
-- Remap ESC to ii
keymap("i", "jk", "<Esc>", opts)
keymap("i", "kj", "<Esc>", opts)
-- Move right
-- keymap("i", "<C-l>", "<Right>", opts)
-- Move left
-- keymap("i", "<C-h>", "<Left>", opts)

-- Visual Mode --
-- Set cursor to the end of selection after yanking
keymap("v", "y", "ygv<Esc>", opts)
-- Yank to the OS buffer and set cursor to the end of selection
keymap("v", "<Leader>y", '"+ygv<Esc>', opts)
-- Paste from the OS buffer
keymap("", "<Leader>p", '"+p', opts)
-- Delete to the OS buffer
keymap("", "<Leader>d", '"+d', opts)
-- Put in the search buffer
keymap("", "<Leader>f", "y/<C-r>0<CR>", opts)
-- Change selection and find next match
keymap("", "<Leader>c", "y/<C-r>0<CR>gvc", opts)

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
keymap("n", "<Leader>r", " @r", opts)
