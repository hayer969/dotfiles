local M = {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
        "williamboman/mason.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
}


function M.config()
    local servers = {
        "bashls",
        "cssls",
        "clangd",
        "html",
        "jsonls",
        "lua_ls",
        "pyright",
        "powershell_es",
        "tsserver",
        "yamlls",
    }
    local tools = {
        "black",
        "codelldb",
        "debugpy",
        "flake8",
        "js-debug-adapter",
        "mypy",
        "prettier",
        "stylua",
        "shfmt",
    }

    require("mason").setup {
        ui = {
            border = "rounded",
        },
    }

    require("mason-lspconfig").setup {
        ensure_installed = servers,
    }

    require('mason-tool-installer').setup {
        ensure_installed = tools,
    }
end

return M
