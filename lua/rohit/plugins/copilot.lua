-- File: lua/rohit/plugins/copilot.lua
local M = {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		-- Function to toggle only Copilot
		_G.toggle_copilot = function()
			local ok, copilot = pcall(require, "copilot.client")
			if ok then
				if copilot.is_disabled() then
					vim.cmd("Copilot enable")
					print("Copilot Enabled")
				else
					vim.cmd("Copilot disable")
					print("Copilot Disabled")
				end
			else
				print("Copilot not available")
			end
		end

		require("copilot").setup({
			suggestion = {
				enabled = false,
				auto_trigger = false,
				keymap = {
					accept = "<M-l>", -- Alt-l to accept suggestion
					next = "<M-]>", -- Alt-] to get next suggestion
					prev = "<M-[>", -- Alt-[ to get previous suggestion
					dismiss = "<C-]>", -- Ctrl-] to dismiss suggestion
				},
			},
			panel = {
				enabled = false,
				auto_refresh = false,
				keymap = {
					jump_prev = "[[",
					jump_next = "]]",
					accept = "<CR>",
					refresh = "gr",
					open = "<M-CR>", -- Alt-Enter to open panel
				},
			},
		})

		-- Explicitly disable Copilot on startup
		vim.defer_fn(function()
			vim.cmd("Copilot disable")
			print("Copilot is initially disabled")
		end, 100) -- Small delay to ensure Copilot is loaded before disabling
	end,
}

return M
