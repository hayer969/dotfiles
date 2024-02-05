local M = { "ThePrimeagen/harpoon" }

function M.config()
    require("harpoon").setup({
        -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
        ["enter_on_sendcmd"] = true,
    })

    require("telescope").load_extension("harpoon")
end

return M
