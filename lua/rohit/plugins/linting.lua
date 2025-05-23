return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		-- Get the full path to golangci-lint
		local function get_golangci_lint_cmd()
			local homebrew_cmd = "/opt/homebrew/bin/golangci-lint"
			if vim.fn.filereadable(homebrew_cmd) == 1 then
				return homebrew_cmd
			end
			return "golangci-lint"
		end

		-- Define the golangci-lint linter properly
		lint.linters.golangci_lint = {
			name = "golangci-lint",
			cmd = get_golangci_lint_cmd(),
			stdin = false,
			append_fname = true,
			args = {
				"run",
				"--out-format=json",
				"--allow-parallel-runners",
			},
			ignore_exitcode = true,
			parser = function(output, bufnr)
				if output == "" then
					return {}
				end

				local decoded = vim.json.decode(output)
				if not decoded or not decoded.Issues then
					return {}
				end

				local diagnostics = {}
				for _, issue in ipairs(decoded.Issues) do
					table.insert(diagnostics, {
						lnum = issue.Pos.Line - 1,
						col = issue.Pos.Column - 1,
						message = issue.Text,
						source = issue.FromLinter,
						severity = vim.diagnostic.severity.WARN,
					})
				end
				return diagnostics
			end,
		}

		-- Set up linters by filetype
		lint.linters_by_ft = {
			go = { "golangci_lint" },
			javascript = { "eslint_d" },
			typescript = { "eslint_d" },
			javascriptreact = { "eslint_d" },
			typescriptreact = { "eslint_d" },
			svelte = { "eslint_d" },
			python = { "pylint" },
		}

		-- Create lint autogroup
		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

		-- Set up autocommands for linting
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			group = lint_augroup,
			callback = function()
				local buf = vim.api.nvim_get_current_buf()
				local ft = vim.bo[buf].filetype
				if ft == "go" then
					lint.try_lint()
				end
			end,
		})

		-- Debug keymap
		vim.keymap.set("n", "<leader>l", function()
			local buf = vim.api.nvim_get_current_buf()
			local ft = vim.bo[buf].filetype

			if ft == "go" then
				-- Debug information
				print("Linting Go file...")
				print("Using golangci-lint at: " .. get_golangci_lint_cmd())
				lint.try_lint()
			end
		end, { desc = "Trigger linting for current file" })
	end,
}
