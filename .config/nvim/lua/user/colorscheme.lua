-- local monokai = require('monokai')
-- local palette = monokai.classic
-- monokai.setup {
--     palette = {
--         base4 = '#838383',
--     },
-- }
-- 
-- local colorscheme = "monokai"

-- vim.o.background = 'light'
-- require("vscode").change_style("light")
local colorscheme = "vscode"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
