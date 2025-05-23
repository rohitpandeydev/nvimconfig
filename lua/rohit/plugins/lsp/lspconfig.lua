return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "folke/neodev.nvim", opts = {} },
		{ "williamboman/mason.nvim", opts = { ui = { border = "rounded" } } }, -- Added mason.nvim
		{ "williamboman/mason-lspconfig.nvim" }, -- Added mason-lspconfig
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")
		local cmp_nvim_lsp = require("cmp_nvim_lsp")
		local keymap = vim.keymap

		-- Enable autocompletion
		local capabilities = cmp_nvim_lsp.default_capabilities()

		-- Initialize mason
		require("mason").setup()

		-- Configure mason-lspconfig
		mason_lspconfig.setup({
			ensure_installed = {
				"gopls",
				"html",
				"cssls",
				"ts_ls",
				"clangd",
				"terraformls",
				"ansiblels",
			},
			handlers = { -- Replaced setup_handlers
				-- Default handler
				function(server_name)
					lspconfig[server_name].setup({
						capabilities = capabilities,
					})
				end,
				["gopls"] = function()
					lspconfig.gopls.setup({
						capabilities = capabilities,
						settings = {
							gopls = {
								analyses = { unusedparams = true },
								staticcheck = true,
								gofumpt = true,
								usePlaceholders = true,
								completeUnimported = true,
							},
						},
					})
				end,
				["html"] = function()
					lspconfig.html.setup({
						capabilities = capabilities,
						filetypes = { "html", "gohtml" }, -- Support Hugo templates
					})
				end,
				["cssls"] = function()
					lspconfig.cssls.setup({ capabilities = capabilities })
				end,
				["ts_ls"] = function()
					lspconfig.ts_ls.setup({ capabilities = capabilities })
				end,
				["clangd"] = function()
					lspconfig.clangd.setup({ capabilities = capabilities })
				end,
				["terraformls"] = function()
					lspconfig.terraformls.setup({ capabilities = capabilities })
				end,
				["ansiblels"] = function()
					lspconfig.ansiblels.setup({ capabilities = capabilities })
				end,
			},
		})

		-- Your existing keymaps (unchanged, add more as needed)
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { desc = "Go to definition" })
		keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Find references" })
		keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })
		keymap.set("n", "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document symbols" })
		keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace symbols" })
		keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostics" })
		keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
		keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
	end,
}
