local autocmd = vim.api.nvim_create_autocmd

-- Mode based Cursorline
autocmd("InsertEnter", {
	pattern = "*",
	callback = function()
		vim.o.cursorline = false
	end,
})

autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		vim.o.cursorline = true
	end,
})

-- Restore cursor position
autocmd("BufReadPost", {
	pattern = "*",
	callback = function()
		local line = vim.fn.line([['"]])
		if line > 1 and line <= vim.fn.line("$") and vim.bo.filetype ~= "commit" then
			vim.cmd([[normal! g`"]])
		end
	end,
})

-- Highlight on yank
autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank({ timeout = 200 })
	end,
})

-- Auto create dir when saving a file
autocmd("BufWritePre", {
	callback = function(event)
		if event.match:match("^%w%w+:[\\/][\\/]") then
			return
		end
		local file = vim.uv.fs_realpath(event.match) or event.match
		vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
	end,
})
