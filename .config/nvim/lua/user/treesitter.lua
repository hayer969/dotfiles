local M = {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    build = ":TSUpdate",
}

function M.config()
    require("nvim-treesitter.configs").setup {
        ensure_installed = {
            "lua",
            "markdown",
            "markdown_inline",
            "bash",
            "python",
            "css",
            "c",
            "cpp",
            "cmake",
            "diff",
            "dockerfile",
            "fish",
            "html",
            "json",
            "json5",
            "java",
            "javascript",
            "latex",
            "rust",
            "sql",
            "regex",
            "toml",
            "yaml",
            "vim",
            "vimdoc",
            "query",
            "typescript",
            "xml"
        },
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
    }
end

return M

--	ignore_install = { "" }, -- List of parsers to ignore installing
--	highlight = {
--		enable = true, -- false will disable the whole extension
--		disable = { "css" }, -- list of language that will be disabled
--	},
--	autopairs = {
--		enable = true,
--	}, -- autopairs plugin to create pairs for parenthesises
--	indent = { enable = true, disable = { "python", "css" } },
