local M = {
	"iamcco/markdown-preview.nvim",
}

function M.config()
	function file_exists(name)
		local f = io.open(name, "r")
		if f ~= nil then
			io.close(f)
			return true
		else
			return false
		end
	end

	if file_exists("/run/.containerenv") then
        vim.g.browser_command = "flatpak-spawn --host firefox --new-window"
    else
        vim.g.browser_command = "firefox --new-window"
    end
    vim.cmd([[
    function OpenMarkdownPreview (url)
        let cmd = g:browser_command . " " . shellescape(a:url) . " &"
        silent call system(cmd)
      endfunction
    ]])
    vim.g.mkdp_browserfunc = "OpenMarkdownPreview"
end

return M
