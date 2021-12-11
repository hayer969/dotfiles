if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
	set nocompatible
	filetype plugin on
	set number relativenumber

	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	" => Remap Keys
	"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
	"Change the leader key from "\" to " "
	let mapleader="\<Space>"

	"Insert Mode

	"Remap ESC to ii
	:inoremap jk <Esc>
	:inoremap kj <Esc>
	"Move right
	":imap <C-l> <Right>
	"Move left
	":imap <C-h> <Left>

	"Normal Mode

	"Yank to end of Line
	:nnoremap Y y$
	"Multiline navigation
	:nnoremap j gj
	"Multiline navigation
	:nnoremap k gk
	"Open new tab
	:nnoremap <Leader>t :tabnew<CR>
	"Yank to the OS buffer
	:nnoremap <Leader>y "+y
	"Paste from the OS buffer
	:nnoremap <Leader>p "+p
	:nnoremap <Leader>P "+P
	"Delete to the OS buffer
	:nnoremap <Leader>d "+d
	:nnoremap <Leader>D "+D
	"Change word and find next match
	:nnoremap <Leader>c *``gnc

	"Visual Mode

	"Set cursor to the end of selection after yanking
	:vnoremap y ygv<Esc>
	"Yank to the OS buffer and set cursor to the end of selection
	:vnoremap <Leader>y "+ygv<Esc>
	"Paste from the OS buffer
	:vnoremap <Leader>p "+p
	"Delete to the OS buffer
	:vnoremap <Leader>d "+d
	"Put in the search buffer
	:vnoremap <Leader>f y/<C-r>0<CR>
	"Change selection and find next match
	:vnoremap <Leader>c y/<C-r>0<CR>gvc

	"Command Mode

	cnoremap q1 q!<CR>
endif
