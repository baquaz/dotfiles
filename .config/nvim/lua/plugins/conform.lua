return {
  "stevearc/conform.nvim",

  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform will run multiple formatters sequentially
      python = { "isort", "black" },
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = { "rustfmt" },
      -- Conform will run the first available formatter
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
    },

    format_on_save = function(bufnr)
      -- These options will be passed to conform.format()
      -- disable format-on-save if buffer variable is set
      if vim.b[bufnr].disable_autoformat then
        return false
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
  },
}
