local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap
  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  -- keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  -- keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", opts)
  keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<CR>", opts)
  keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<CR>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<CR>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)

  -- if client.supports_method "textDocument/inlayHint" then
  --     vim.lsp.inlay_hint.enable(bufnr, true)
  -- end
end

function M.common_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  return capabilities
end

function M.config()
  local default_diagnostic_config = {
    signs = {
      text = {
        [ vim.diagnostic.severity.ERROR] = "",
        [ vim.diagnostic.severity.WARN] = "",
        -- [ vim.diagnostic.severity.HINT] = "",
        [ vim.diagnostic.severity.INFO] = "",
      },
      texthl = {
        [vim.diagnostic.severity.ERROR] = "Error",
        [vim.diagnostic.severity.WARN] = "Warn",
        [vim.diagnostic.severity.INFO] = "Info",
        [vim.diagnostic.severity.HINT] = "Hint",
      },
    },
    virtual_text = false,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  local servers = {
    "bashls",
    "cssls",
    "clangd",
    "gopls",
    "html",
    "jsonls",
    "lua_ls",
    "pyright",
    "ruff",
    "powershell_es",
    "ts_ls",
    "yamlls",
  }

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "user.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    vim.lsp.config(server, opts)
    vim.lsp.enable(server)
  end
end

return M
