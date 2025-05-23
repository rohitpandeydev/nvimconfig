require("rohit.core.options")
require("rohit.core.keymaps")
vim.diagnostic.config({
	virtual_text = false, -- Disable inline error messages
	float = {
		source = "always", -- Show the error source
		border = "rounded", -- Add rounded borders to the floating window
	},
})

vim.api.nvim_create_autocmd("CursorHold", {
	pattern = "*",
	callback = function()
		vim.diagnostic.open_float(nil, { focusable = false })
	end,
})

vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error message" })

-- File: lua/rohit/core/init.lua
-- Add these lines at the end of your existing init.lua file

-- Set completion options
vim.opt.completeopt = "menu,menuone,noselect"
vim.opt.updatetime = 300
