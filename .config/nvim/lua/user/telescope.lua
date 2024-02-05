local M = {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true },
        'nvim-lua/plenary.nvim',
    },
}

function M.config()
    local actions = require "telescope.actions"

    require("telescope").setup {
        defaults = {

            layout_strategy = 'vertical',
            layout_config = {
                width = 0.85,
                height = 0.95,
                preview_height = 0.62,
            },

            prompt_prefix = " ",
            selection_caret = " ",
            path_display = { "smart" },
            file_ignore_patterns = { ".git/", "node_modules" },

            mappings = {
                i = {
                    ["<Down>"] = actions.cycle_history_next,
                    ["<Up>"] = actions.cycle_history_prev,
                    ["<C-j>"] = actions.move_selection_next,
                    ["<C-k>"] = actions.move_selection_previous,
                },
            },
        },
    }
end

return M
