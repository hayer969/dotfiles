-- if exists('g:vscode') then
    -- VSCode extension
-- else
    -- ordinary neovim
    require "user.options"
    require "user.keymaps"
    require "user.plugins"
    require "user.colorscheme"
    -- require "user.cmp"
    -- require "user.lsp"
    -- require "user.telescope"
    -- require "user.treesitter"
    -- require "user.autopairs"
    -- require "user.comment"
    -- require "user.gitsigns"
    -- require "user.nvim-tree"
    -- require "user.bufferline"
    -- require "user.lualine"
    -- require "user.toggleterm"
    -- require "user.project"
    -- require "user.impatient"
    -- require "user.indentline"
    -- require "user.alpha"
    -- require "user.whichkey"
    require "user.autocommands"

    -- local A = vim.api
    -- A.nvim_command('filetype plugin on')

    -- set path+=**                  -- Searches current directory recursively.
-- end
