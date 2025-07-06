return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				svelte = { "prettier" },
				css = { "prettier" },
				html = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				-- markdown = { "prettier" },
				graphql = { "prettier" },
				liquid = { "prettier" },
				lua = { "stylua" },
				python = { "isort", "black" },
			},

			format_on_save = function(bufnr)
				-- disable format-on-save if buffer variable is set
				if vim.b[bufnr].disable_autoformat then
					return false
				end

				-- else format on save with these settings:
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })

		vim.api.nvim_create_user_command("ToggleAutoformat", function()
			local bufnr = vim.api.nvim_get_current_buf()
			vim.b[bufnr].disable_autoformat = not vim.b[bufnr].disable_autoformat
			print(
				"Autoformat is now "
					.. (vim.b[bufnr].disable_autoformat and "disabled" or "enabled")
					.. " for this buffer"
			)
		end, {})
	end,
}
