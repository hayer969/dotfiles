local M = {
	"nvimtools/none-ls.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
}

function M.config()
	local null_ls = require("null-ls")

	local formatting = null_ls.builtins.formatting
	local diagnostics = null_ls.builtins.diagnostics

	null_ls.setup({
		debug = false,
		sources = {
			formatting.stylua,
			formatting.shfmt,
			formatting.google_java_format,
			diagnostics.mypy.with({
				extra_args = function()
					local virtual = os.getenv("VIRTUAL_ENV")
					local conda = os.getenv("CONDA_PREFIX")
					local system = "/usr/bin/python3"
					local executable = ""
					local os_type = vim.loop.os_uname().sysname
					if string.match(os_type, "Windows") and virtual then
						executable = virtual .. "/Scripts/python.exe"
					elseif virtual then
						executable = virtual .. "/bin/python3"
					elseif string.match(os_type, "Windows") and conda then
						executable = conda .. "/python.exe"
					else
						executable = system
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
