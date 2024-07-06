local M = {
    "numToStr/Comment.nvim",
    lazy = false,
    dependencies = {
        {
            "JoosepAlviste/nvim-ts-context-commentstring",
            event = "VeryLazy",
        },
    },
}

function M.config()
    vim.g.skip_ts_context_commentstring_module = true
    -- @diagnostic disable: missing-fields
    require("ts_context_commentstring").setup {
        enable_autocmd = false,
    }

    require("Comment").setup {
        pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
        mappings = {
            -- Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
            basic = true,
            -- Extra mapping; `gco`, `gcO`, `gcA`
            extra = true,
        }
    }
end

return M
