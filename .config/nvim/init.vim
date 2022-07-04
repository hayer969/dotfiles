if exists('g:vscode')
    " VSCode extension
else
    " ordinary neovim
    set nocompatible
    filetype plugin on
    set number relativenumber
    set ignorecase
    set smartcase
    
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
    
    "Terminal Mode
    "
    ""To map <Esc> to exit terminal-mode:
    tnoremap <Esc><Esc> <C-\><C-n>
    
    "To use `ALT+{h,j,k,l}` to navigate windows from any mode:
    tnoremap <A-h> <C-\><C-N><C-w>h
    tnoremap <A-j> <C-\><C-N><C-w>j
    tnoremap <A-k> <C-\><C-N><C-w>k
    tnoremap <A-l> <C-\><C-N><C-w>l
    inoremap <A-h> <C-\><C-N><C-w>h
    inoremap <A-j> <C-\><C-N><C-w>j
    inoremap <A-k> <C-\><C-N><C-w>k
    inoremap <A-l> <C-\><C-N><C-w>l
    nnoremap <A-h> <C-w>h
    nnoremap <A-j> <C-w>j
    nnoremap <A-k> <C-w>k
    nnoremap <A-l> <C-w>l
    
    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Text, tab and indent related
    " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " Use spaces instead of tabs
    set expandtab
    
    " Be smart when using tabs ;)
    set smarttab
    
    " 1 tab == 4 spaces
    set shiftwidth=4
    set tabstop=4

    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    " => Splits and Tabbed Files
    " """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    set splitbelow splitright
    
    " Make adjusting split sizes a bit more friendly
    noremap <silent> <C-Left> :vertical resize -3 <CR>
    noremap <silent> <C-Right> :vertical resize +3 <CR>
    noremap <silent> <C-Up> :resize +3 <CR>
    noremap <silent> <C-Down> :resize -3 <CR>
    
    set path+=**                  " Searches current directory recursively.
endif
