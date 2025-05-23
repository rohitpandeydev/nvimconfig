return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		-- import mason
		local mason = require("mason")
		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")
		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_lspconfig.setup({
			-- list of servers for mason to install
			opts = {
				auto_install = true,
			},
			ensure_installed = {
				"ts_ls", -- TypeScript
				"html", -- HTML
				"cssls", -- CSS
				"tailwindcss", -- Tailwind CSS (if you use it)
				"lua_ls", -- Lua
				"graphql", -- GraphQL
				"pyright", -- Python
				"gopls", -- Go
				"terraformls", -- Terraform
				"yamlls", -- YAML
				"ansiblels", -- Ansible (if you use it)
				"clangd", -- C++ LSP Server
				"eslint", -- Javascript/Typescript
				"tflint",
				"jdtls",
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"isort", -- python formatter
				"black", -- python formatter
				"pylint", -- python linter
				"delve", -- Go debugger
				"gopls", -- Go LSP server (also a tool)
				"prettier", -- prettier formatter
				"prettierd", -- prettier daemon
				"shellcheck", -- shell linter
				"yamlfix", -- yaml formatter
				"taplo", -- TOML formatter
				"htmlbeautifier", -- HTML formatter
				"goimports", -- Go import management
				"gofumpt", -- Go formatter
				"gomodifytags", -- Go struct tag management
				"impl", -- Go interface implementation
				"clang-format", -- C++ linter
				"htmlhint",
				"stylelint",
				"eslint_d",
				"tflint",
			},
		})
	end,
}
