local M = {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
}

function M.config()
	local lint = require("lint")
	lint.linters_by_ft = { markdown = { "markdownlint-cli2" } }
    lint.linters["markdownlint-cli2"].args = {
		"--config",
		vim.fn.stdpath("config") .. "/.markdownlint.yaml",
		"--", -- Required
	}

	local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
	vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
		group = lint_augroup,
		callback = function()
			require("lint").try_lint()
		end,
	})
end

return M
