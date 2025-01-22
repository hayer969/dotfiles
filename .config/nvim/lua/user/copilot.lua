local M = {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  dependencies = {
    "zbirenbaum/copilot-cmp",
    event = "InsertEnter",
  },
}

function M.config()
  vim.g.copilot_proxy = "http://127.0.0.1:2080"
  require("copilot").setup({
    suggestion = { enabled = false },
    panel = { enabled = false },
    filetypes = {
      yaml = false,
    },
  })

  require("copilot_cmp").setup()
end

return M
