local M = {
    "folke/which-key.nvim",
}

function M.config()
    local which_key = require("which-key")

    local setup = {
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
                operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
                motions = true, -- adds help for motions
                text_objects = true, -- help for text objects triggered after entering an operator
                windows = true, -- default bindings on <c-w>
                nav = true, -- misc bindings to work with windows
                z = true, -- bindings for folds, spelling and others prefixed with z
                g = true, -- bindings for prefixed with g
            },
        },
        -- add operators that will trigger motion and text object completion
        -- to enable all native operators, set the preset / operators plugin above
        -- operators = { gc = "Comments" },
        key_labels = {
            -- override the label used to display some keys. It doesn't effect WK in any other way.
            -- For example:
            -- ["<space>"] = "SPC",
            -- ["<cr>"] = "RET",
            -- ["<tab>"] = "TAB",
        },
        icons = {
            breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
            separator = "➜", -- symbol used between a key and it's label
            group = "+", -- symbol prepended to a group
        },
        popup_mappings = {
            scroll_down = "<c-d>", -- binding to scroll down inside the popup
            scroll_up = "<c-u>", -- binding to scroll up inside the popup
        },
        window = {
            border = "rounded", -- none, single, double, shadow
            position = "bottom", -- bottom, top
            margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
            padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
            winblend = 0,
        },
        layout = {
            height = { min = 4, max = 25 },                                     -- min and max height of the columns
            width = { min = 20, max = 50 },                                     -- min and max width of the columns
            spacing = 3,                                                        -- spacing between columns
            align = "left",                                                     -- align columns left, center or right
        },
        ignore_missing = true,                                                  -- enable this to hide mappings for which you didn't specify a label
        hidden = { "<silent>", "<CMD>", "<CMD>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
        show_help = true,                                                       -- show help message on the command line when the popup is visible
        triggers = "auto",                                                      -- automatically setup triggers
        -- triggers = {"<leader>"} -- or specify a list manually
        triggers_blacklist = {
            -- list of mode / prefixes that should never be hooked by WhichKey
            -- this is mostly relevant for key maps that start with a native binding
            -- most people should not need to change this
            i = { "j", "k" },
            v = { "j", "k" },
        },
    }

    local opts = {
        mode = "n", -- NORMAL mode
        prefix = "<leader>",
        buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
        silent = true, -- use `silent` when creating keymaps
        noremap = true, -- use `noremap` when creating keymaps
        nowait = true, -- use `nowait` when creating keymaps
    }

    local mappings = {
        ["t"] = { "Open buffer in new tab" },
        ["c"] = { "Change word and find next match" },
        [";"] = { "Clear highlights" },
        ["r"] = { "Run ipython cell like in VSCode" },
        ["%"] = { "Put absolute full path" },

        f = {
            name = "Find",
            t = { "Find text in files" },
            s = { "Find string in files" },
            b = { "Find files in buffers" },
            f = { "Find files" },
            r = { "Open Recent File" },
            p = { "Find projects" },
            R = { "Registers" },
            h = { "Find in command history" },
            k = { "Keymaps" },
            C = { "Commands" },
            m = { "Harpoon marks" },
            ["@"] = { "Find lsp document symbols" },
        },

        h = {
            name = "Harpoon",
            m = { "Set marks" },
            u = { "Open files quick menu" },
            c = { "Open term commands quick menu" },
            n = { "Go to the next mark" },
            p = { "Go to the previous mark" },
        },

        l = {
            name = "LSP",
            f = { "<CMD>lua vim.lsp.buf.format({async=true})<CR>", "Formatting code" },
            r = { "<CMD>lua vim.lsp.buf.rename()<CR>", "Rename" },
            a = { "<CMD>lua vim.lsp.buf.code_action()<CR>", "Code action" },
            j = { "<CMD>lua vim.diagnostic.goto_next({buffer=0})<CR>", "Go to next diagnostic" },
            k = { "<CMD>lua vim.diagnostic.goto_prev({buffer=0})<CR>", "Go to prev diagnostic" },
            q = { "<CMD>lua vim.diagnostic.setloclist()<CR>", "Diagnostic list" },
            s = { "<CMD>lua vim.lsp.buf.signature_help()<CR>", "Signature help" },
            i = { "<CMD>LspInfo<CR>", "Lsp Info" },
        },

        g = {
            name = "Git",
            g = { "Lazygit" },
            j = { "Next Hunk" },
            k = { "Prev Hunk" },
            l = { "Blame" },
            p = { "Preview Hunk" },
            r = { "Reset Hunk" },
            R = { "Reset Buffer" },
            s = { "Stage Hunk" },
            u = { "Undo Stage Hunk" },
            o = { "Open changed file" },
            b = { "Checkout branch" },
            c = { "Checkout commit" },
            d = { "Diff" },
        },

        d = {
            name = "DAP",
            b = { "Toggle breakpoint" },
            B = { "Conditional breakpoint" },
            H = { "Hit condition breakpoint" },
            L = { "Log point" },
            c = { "Continue <F5>" },
            i = { "Step into <F2>" },
            o = { "Step over <F3>" },
            O = { "Step out <F4>" },
            r = { "Toggle repl" },
            l = { "Run last" },
            u = { "Toggle UI" },
            q = { "Quit (terminate) session" },
            s = { "Debug selected" },
            t = {
                name = "Debug tests",
                c = { "Class under cursor" },
                m = { "Method under cursor" },
            },
        },

        x = {
            name = "Encodings, endings and so on",
            o = {
                name = "Reopen with encodings",
                c = { "cp1251" },
            },
            c = {
                name = "Set file encoding",
                u = { "utf-8" },
            },
            s = {
                name = "Spelling",
                e = { "en" },
                r = { "ru" },
                n = { "off" },
            },
            e = {
                name = "Set line endings",
                u = { "Unix style" },
                d = { "Dos style" },
            },
            h = {
                name = "HEX editing",
                h = { "Display as HEX" },
                r = { "Convert from HEX" },
            },
        },

        --[[ t = { ]]
        --[[   name = "Terminal", ]]
        --[[   n = { "<CMD>lua _NODE_TOGGLE()<CR>", "Node" }, ]]
        --[[   u = { "<CMD>lua _NCDU_TOGGLE()<CR>", "NCDU" }, ]]
        --[[   t = { "<CMD>lua _HTOP_TOGGLE()<CR>", "Htop" }, ]]
        --[[   p = { "<CMD>lua _PYTHON_TOGGLE()<CR>", "Python" }, ]]
        --[[   f = { "<CMD>ToggleTerm direction=float<CR>", "Float" }, ]]
        --[[   h = { "<CMD>ToggleTerm size=10 direction=horizontal<CR>", "Horizontal" }, ]]
        --[[   v = { "<CMD>ToggleTerm size=80 direction=vertical<CR>", "Vertical" }, ]]
        --[[ }, ]]
    }

    which_key.setup(setup)
    which_key.register(mappings, opts)
end

return M
