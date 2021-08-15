if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
	set nocompatible
	filetype plugin on
	set relativenumber

	"Normal mode keybindings
	:nnoremap k gk
	:nnoremap j gj

	"Insert mode keybindings
	:inoremap jk <Esc>
	:inoremap kj <Esc>
endif
