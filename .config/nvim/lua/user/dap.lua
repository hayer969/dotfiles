local M = {
	"mfussenegger/nvim-dap",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"mfussenegger/nvim-dap-python",
		"rcarriga/nvim-dap-ui",
	},
}

function M.config()
	local dap = require("dap")
	local dapui = require("dapui")
	local dap_python = require("dap-python")

	local python_executable = ""
	local os_type = vim.loop.os_uname().sysname
	if string.match(os_type, "Windows") then
		python_executable = "/venv/Scripts/python.exe"
	else
		python_executable = "/venv/bin/python"
	end
	dap_python.setup(vim.fn.stdpath("data") .. "/mason/packages/debugpy" .. python_executable)

	table.insert(dap.configurations.python, 1, {
		type = "python",
		request = "launch",
		name = "Launch with Not Just My Code",
		program = "${file}",
		console = "integratedTerminal",
		justMyCode = false,
	})

	dap.adapters.codelldb = {
		type = "server",
		port = "${port}",
		executable = {
			-- CHANGE THIS to your path!
			command = "codelldb",
			args = { "--port", "${port}" },

			-- On windows you may have to uncomment this:
			detached = false,
		},
	}

	dap.configurations.cpp = {
		{
			name = "Launch file",
			type = "codelldb",
			request = "launch",
			program = function()
				return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
			end,
			cwd = "${workspaceFolder}",
			stopOnEntry = false,
		},
	}
	-- If you want to use this debug adapter for other languages, you can re-use the configurations:
	-- dap.configurations.c = dap.configurations.cpp
	-- dap.configurations.rust = dap.configurations.cpp

	require("dap").adapters["pwa-node"] = {
		type = "server",
		host = "localhost",
		port = "${port}",
		executable = {
			command = "node",
			-- 💀 Make sure to update this path to point to your installation
			args = {
				vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
				"${port}",
			},
		},
	}

	for _, language in ipairs({ "typescript", "javascript" }) do
		require("dap").configurations[language] = {
			{
				type = "pwa-node",
				request = "launch",
				name = "Launch file",
				program = "${file}",
				console = "integratedTerminal",
				cwd = "${workspaceFolder}",
			},
			{
				type = "pwa-node",
				request = "attach",
				name = "Attach",
				console = "integratedTerminal",
				processId = require("dap.utils").pick_process,
				cwd = "${workspaceFolder}",
			},
		}
	end

	dapui.setup()

	vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DiagnosticSignError", linehl = "", numhl = "" })

	dap.listeners.after.event_initialized["dapui_config"] = function()
		dapui.open()
	end

	dap.listeners.before.event_terminated["dapui_config"] = function()
		dapui.close()
	end

	dap.listeners.before.event_exited["dapui_config"] = function()
		dapui.close()
	end
end

return M
