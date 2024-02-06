local M = {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim"
  }
}

function M.config()
    local null_ls =require "null-ls"

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics

    null_ls.setup({
        debug = false,
        sources = {
            -- formatting.prettier.with({
            --     extra_filetypes = { "toml" },
            --     extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" },
            -- }),
            formatting.black.with({ extra_args = { "--fast" } }),
            formatting.stylua,
            formatting.beautysh,
            formatting.google_java_format,
            diagnostics.flake8.with({ extra_args = { "--max-line-length=100" } }),
            diagnostics.mypy.with({
                extra_args = function()
                    local virtual = os.getenv("VIRTUAL_ENV") or os.getenv("CONDA_DEFAULT_ENV") or "/usr"
                    local executable = ""
                    local os_type = vim.loop.os_uname().sysname
                    if string.match(os_type, "Windows") and os.getenv("CONDA_DEFAULT_ENV") then
                        executable = "C:/Users/user/miniconda3/envs/" .. virtual .. "/python.exe"
                    elseif string.match(os_type, "Windows") then
                        executable = virtual .. "/Scripts/python.exe"
                    else
                        executable = virtual .. "/bin/python3"
                    end
                    return {
                        "--disallow-untyped-defs",
                        "--python-executable",
                        executable,
                    }
                end,
            }),
        },
    })
end

return M