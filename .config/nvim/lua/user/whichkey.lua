local M = {
    "folke/which-key.nvim",
}

function M.config()
    local which_key = require("which-key")

    local setup = {
        preset = "modern",
        delay = function(ctx)
            return ctx.plugin and 0 or 400
        end,
        --- You can add any mappings here, or use `req
        plugins = {
            marks = true, -- shows a list of your marks on ' and `
            registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
            spelling = {
                enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
                suggestions = 20, -- how many suggestions should be shown in the list?
            },
            -- the presets plugin, adds help for a bunch of default keybindings in Neovim
            -- No actual key bindings are created
            presets = {
                operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        layout = {
            height = { min = 4, max = 25 }, -- min and max height of the columns
            width = { min = 20, max = 50 }, -- min and max width of the columns
            spacing = 3,           -- spacing between columns
            align = "left",        -- align columns left, center or right
        },
        show_help = true,          -- show help message on the command line when the popup is visible
        disable = { bt = { "terminal" } },
    }

    which_key.add({
        {
            mode = { "n" },
            { "<leader><leader>",   desc = "Open current buffer in right window",           nowait = true, remap = false },
            { "<leader>%",   desc = "Put absolute full path",           nowait = true, remap = false },
            { "<leader>/",   desc = "Fuzzily search in current buffer", nowait = true, remap = false },
            { "<leader>;",   desc = "Clear highlights",                 nowait = true, remap = false },
            { "<leader>c",   desc = "Change word and find next match",  nowait = true, remap = false },
            { "<leader>d",   group = "DAP",                             nowait = true, remap = false },
            { "<leader>dB",  desc = "Conditional breakpoint",           nowait = true, remap = false },
            { "<leader>dH",  desc = "Hit condition breakpoint",         nowait = true, remap = false },
            { "<leader>dL",  desc = "Log point",                        nowait = true, remap = false },
            { "<leader>dO",  desc = "Step out <F4>",                    nowait = true, remap = false },
            { "<leader>db",  desc = "Toggle breakpoint",                nowait = true, remap = false },
            { "<leader>dc",  desc = "Continue <F5>",                    nowait = true, remap = false },
            { "<leader>di",  desc = "Step into <F2>",                   nowait = true, remap = false },
            { "<leader>dl",  desc = "Run last",                         nowait = true, remap = false },
            { "<leader>do",  desc = "Step over <F3>",                   nowait = true, remap = false },
            { "<leader>dq",  desc = "Quit (terminate) session",         nowait = true, remap = false },
            { "<leader>dr",  desc = "Toggle repl",                      nowait = true, remap = false },
            { "<leader>ds",  desc = "Debug selected",                   nowait = true, remap = false },
            { "<leader>dt",  group = "Debug tests",                     nowait = true, remap = false },
            { "<leader>dtc", desc = "Class under cursor",               nowait = true, remap = false },
            { "<leader>dtm", desc = "Method under cursor",              nowait = true, remap = false },
            { "<leader>du",  desc = "Toggle UI",                        nowait = true, remap = false },
            { "<leader>f",   group = "Find",                            nowait = true, remap = false },
            { "<leader>f@",  desc = "Find lsp document symbols",        nowait = true, remap = false },
            { "<leader>fC",  desc = "Commands",                         nowait = true, remap = false },
            { "<leader>fH",  desc = "Find in HELP",                     nowait = true, remap = false },
            { "<leader>fR",  desc = "Registers",                        nowait = true, remap = false },
            { "<leader>fT",  desc = "Find Telescope builtins",          nowait = true, remap = false },
            { "<leader>fb",  desc = "Find files in buffers",            nowait = true, remap = false },
            { "<leader>ff",  desc = "Find files",                       nowait = true, remap = false },
            { "<leader>fh",  desc = "Find in command history",          nowait = true, remap = false },
            { "<leader>fk",  desc = "Keymaps",                          nowait = true, remap = false },
            { "<leader>fm",  desc = "Harpoon marks",                    nowait = true, remap = false },
            { "<leader>fp",  desc = "Find projects",                    nowait = true, remap = false },
            { "<leader>fr",  desc = "Open Recent File",                 nowait = true, remap = false },
            { "<leader>fs",  desc = "Find string in files",             nowait = true, remap = false },
            { "<leader>ft",  desc = "Find text in files",               nowait = true, remap = false },
            { "<leader>fw",  group = "Workspace features",              nowait = true, remap = false },
            { "<leader>fws", desc = "Find lsp Workspace symbols",       nowait = true, remap = false },
            { "<leader>g",   group = "Git",                             nowait = true, remap = false },
            { "<leader>gR",  desc = "Reset Buffer",                     nowait = true, remap = false },
            { "<leader>gb",  desc = "Checkout branch",                  nowait = true, remap = false },
            { "<leader>gc",  desc = "Checkout commit",                  nowait = true, remap = false },
            { "<leader>gd",  desc = "Diff",                             nowait = true, remap = false },
            { "<leader>gg",  desc = "Lazygit",                          nowait = true, remap = false },
            { "<leader>gj",  desc = "Next Hunk",                        nowait = true, remap = false },
            { "<leader>gk",  desc = "Prev Hunk",                        nowait = true, remap = false },
            { "<leader>gl",  desc = "Blame",                            nowait = true, remap = false },
            { "<leader>go",  desc = "Open changed file",                nowait = true, remap = false },
            { "<leader>gp",  desc = "Preview Hunk",                     nowait = true, remap = false },
            { "<leader>gr",  desc = "Reset Hunk",                       nowait = true, remap = false },
            { "<leader>gs",  desc = "Stage Hunk",                       nowait = true, remap = false },
            { "<leader>gu",  desc = "Undo Stage Hunk",                  nowait = true, remap = false },
            { "<leader>h",   group = "Harpoon",                         nowait = true, remap = false },
            { "<leader>hc",  desc = "Open term commands quick menu",    nowait = true, remap = false },
            { "<leader>hm",  desc = "Set marks",                        nowait = true, remap = false },
            { "<leader>hn",  desc = "Go to the next mark",              nowait = true, remap = false },
            { "<leader>hp",  desc = "Go to the previous mark",          nowait = true, remap = false },
            { "<leader>hu",  desc = "Open files quick menu",            nowait = true, remap = false },
            { "<leader>l",   group = "LSP",                             nowait = true, remap = false },
            {
                "<leader>la",
                "<CMD>lua vim.lsp.buf.code_action()<CR>",
                desc = "Code action",
                nowait = true,
                remap = false,
            },
            { "<leader>lc",   group = "Copilot",                        nowait = true, remap = false },
            {
                "<leader>lcd",
                "<CMD>Copilot disable<CR>",
                desc = "Copilot disable",
                nowait = true,
                remap = false,
            },
            {
                "<leader>lce",
                "<CMD>Copilot enable<CR>",
                desc = "Copilot enable",
                nowait = true,
                remap = false,
            },
            {
                "<leader>lcs",
                "<CMD>Copilot status<CR>",
                desc = "Copilot status",
                nowait = true,
                remap = false,
            },
            {
                "<leader>lf",
                "<CMD>lua vim.lsp.buf.format({async=true})<CR>",
                desc = "Formatting code",
                nowait = true,
                remap = false,
            },
            { "<leader>li", "<CMD>LspInfo<CR>",                  desc = "Lsp Info", nowait = true, remap = false },
            {
                "<leader>lj",
                "<CMD>lua vim.diagnostic.goto_next({buffer=0})<CR>",
                desc = "Go to next diagnostic",
                nowait = true,
                remap = false,
            },
            {
                "<leader>lk",
                "<CMD>lua vim.diagnostic.goto_prev({buffer=0})<CR>",
                desc = "Go to prev diagnostic",
                nowait = true,
                remap = false,
            },
            {
                "<leader>lq",
                "<CMD>lua vim.diagnostic.setloclist()<CR>",
                desc = "Diagnostic list",
                nowait = true,
                remap = false,
            },
            { "<leader>lr", "<CMD>lua vim.lsp.buf.rename()<CR>", desc = "Rename",   nowait = true, remap = false },
            {
                "<leader>ls",
                "<CMD>lua vim.lsp.buf.signature_help()<CR>",
                desc = "Signature help",
                nowait = true,
                remap = false,
            },
            { "<leader>r",   desc = "Run ipython cell like in VSCode",          nowait = true, remap = false },
            { "<leader>t",   desc = "Open buffer in new tab",                   nowait = true, remap = false },
            { "<leader>x",   group = "Encodings, endings and so on",            nowait = true, remap = false },
            { "<leader>xc",  group = "Set file encoding",                       nowait = true, remap = false },
            { "<leader>xcu", desc = "utf-8",                                    nowait = true, remap = false },
            { "<leader>xe",  group = "Set line endings",                        nowait = true, remap = false },
            { "<leader>xed", desc = "Dos style",                                nowait = true, remap = false },
            { "<leader>xeu", desc = "Unix style",                               nowait = true, remap = false },
            { "<leader>xh",  group = "HEX editing",                             nowait = true, remap = false },
            { "<leader>xhh", desc = "Display as HEX",                           nowait = true, remap = false },
            { "<leader>xhr", desc = "Convert from HEX",                         nowait = true, remap = false },
            { "<leader>xo",  group = "Reopen with encodings or in binary mode", nowait = true, remap = false },
            { "<leader>xob", desc = "binary",                                   nowait = true, remap = false },
            { "<leader>xoc", desc = "cp1251",                                   nowait = true, remap = false },
            { "<leader>xot", desc = "text (default mode)",                      nowait = true, remap = false },
            { "<leader>xs",  group = "Spelling",                                nowait = true, remap = false },
            { "<leader>xse", desc = "en",                                       nowait = true, remap = false },
            { "<leader>xsn", desc = "off",                                      nowait = true, remap = false },
            { "<leader>xsr", desc = "ru",                                       nowait = true, remap = false },
            { "<leader>k",  group = "Kubernetes",                               nowait = true, remap = false },
            { "<leader>kf", desc = "Apply current file",                        nowait = true, remap = false },
            { "<leader>kk", desc = "Apply kustomization",                       nowait = true, remap = false },
            { "<leader>kd",  group = "Kubernetes delete",                       nowait = true, remap = false },
            { "<leader>kdf", desc = "Delete current file",                      nowait = true, remap = false },
            { "<leader>kdk", desc = "Delete kustomization",                     nowait = true, remap = false },
        },
    })

    which_key.setup(setup)
end

return M
