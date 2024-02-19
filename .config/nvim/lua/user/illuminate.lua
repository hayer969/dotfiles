local M = { "RRethy/vim-illuminate" }

function M.config()
  require("illuminate").configure({ large_file_cutoff = 30000 })
end

return M
