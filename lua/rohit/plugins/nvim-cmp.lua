-- File: lua/rohit/plugins/nvim-cmp.lua
local M = {
	"hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-nvim-lua",
		"f3fora/cmp-spell",
		"hrsh7th/cmp-cmdline",
	},
}

function M.config()
	local cmp = require("cmp")
	local luasnip = require("luasnip")
	local lspkind = require("lspkind")

	-- Load snippets
	require("luasnip.loaders.from_vscode").lazy_load()

	-- Global variable to track completion state
	vim.g.completion_enabled = true

	-- Function to toggle only nvim-cmp completion
	_G.toggle_completion = function()
		vim.g.completion_enabled = not vim.g.completion_enabled
		if vim.g.completion_enabled then
			cmp.setup({
				enabled = function()
					return true
				end,
			})
			print("Autocomplete Enabled")
		else
			cmp.setup({
				enabled = function()
					return false
				end,
			})
			print("Autocomplete Disabled")
		end
	end

	cmp.setup({
		enabled = function()
			return vim.g.completion_enabled
		end,
		completion = {
			completeopt = "menu,menuone,preview,noselect",
		},
		snippet = {
			expand = function(args)
				luasnip.lsp_expand(args.body)
			end,
		},
		mapping = cmp.mapping.preset.insert({
			["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
			["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
			["<C-b>"] = cmp.mapping.scroll_docs(-4),
			["<C-f>"] = cmp.mapping.scroll_docs(4),
			["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
			["<C-e>"] = cmp.mapping.abort(), -- close completion window
			["<CR>"] = cmp.mapping.confirm({ select = false }),
			["<Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_next_item()
				elseif luasnip.expandable() then
					luasnip.expand()
				elseif luasnip.expand_or_jumpable() then
					luasnip.expand_or_jump()
				else
					fallback()
				end
			end, { "i", "s" }),
			["<S-Tab>"] = cmp.mapping(function(fallback)
				if cmp.visible() then
					cmp.select_prev_item()
				elseif luasnip.jumpable(-1) then
					luasnip.jump(-1)
				else
					fallback()
				end
			end, { "i", "s" }),
		}),
		sources = cmp.config.sources({
			{ name = "nvim_lsp", priority = 1000 },
			{ name = "luasnip", priority = 750 },
			{ name = "buffer", priority = 500 },
			{ name = "path", priority = 250 },
			{ name = "nvim_lua" },
			{ name = "spell" },
		}),
		formatting = {
			format = lspkind.cmp_format({
				mode = "symbol_text",
				maxwidth = 50,
				ellipsis_char = "...",
				before = function(entry, vim_item)
					-- Show source name
					vim_item.menu = ({
						nvim_lsp = "[LSP]",
						luasnip = "[Snippet]",
						buffer = "[Buffer]",
						path = "[Path]",
						nvim_lua = "[Lua]",
						spell = "[Spell]",
					})[entry.source.name]
					return vim_item
				end,
			}),
		},
		window = {
			completion = cmp.config.window.bordered(),
			documentation = cmp.config.window.bordered(),
		},
	})

	vim.keymap.set("n", "<leader>ta", "<cmd>lua _G.toggle_completion()<CR>", { desc = "Toggle autocomplete" })
	-- Set up command line completion
	cmp.setup.cmdline(":", {
		mapping = cmp.mapping.preset.cmdline(),
		sources = cmp.config.sources({
			{ name = "path" },
			{ name = "cmdline" },
		}),
	})
end
return M
