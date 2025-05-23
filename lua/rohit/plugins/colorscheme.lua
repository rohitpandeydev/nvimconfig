return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup({
				flavour = "mocha", -- keep original color palette
				transparent_background = true,
				term_colors = true,
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = { "italic" },
					functions = { "bold" },
					keywords = { "bold" },
					strings = { "italic" },
					variables = {},
					numbers = { "bold" },
					booleans = { "bold" },
					properties = {},
					types = {},
					operators = { "bold" },
				},
				color_overrides = {
					mocha = {
						base = "#12131c", -- just slightly lighter than pitch black
						mantle = "#181926",
						crust = "#0f1017",
						text = "#D9E0EE", -- light boost from default (#cdd6f4)
						surface0 = "#1E1E2E", -- mild lightening to help contrast
					},
				},
				highlight_overrides = {
					mocha = function(C)
						return {
							Normal = { bg = C.base },
							CursorLine = { bg = "#1a1b2a" },
							Visual = { bg = "#2e3252" },
							LineNr = { fg = "#5c5f78" },
							Comment = { fg = C.overlay1, style = { "italic" } },
							Function = { fg = C.blue, style = { "bold" } },
							Keyword = { fg = C.mauve, style = { "bold" } },
							Statement = { fg = C.mauve },
							Operator = { fg = C.sky, style = { "bold" } },
							Identifier = { fg = C.text },
							Type = { fg = C.yellow },
							Constant = { fg = C.peach },
							String = { fg = C.green, style = { "italic" } },
							Number = { fg = C.flamingo },
							Boolean = { fg = C.red },
						}
					end,
				},
				integrations = {
					cmp = true,
					gitsigns = true,
					telescope = { enabled = true },
					treesitter = true,
					lsp_saga = true,
					which_key = true,
					mason = true,
					illuminate = true,
					native_lsp = {
						enabled = true,
						underlines = {
							errors = { "underline" },
							hints = { "underline" },
							warnings = { "underline" },
							information = { "underline" },
						},
					},
				},
			})

			vim.cmd("colorscheme catppuccin")
		end,
	},
}
