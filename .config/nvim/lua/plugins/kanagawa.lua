return {
  "rebelot/kanagawa.nvim",
  enabled = false,
  config = function()
    require("kanagawa").setup({
      compile = true,
    })
    vim.cmd("colorscheme kanagawa")
    vim.api.nvim_set_hl(0, "ObsidianTodo", { fg = "#FFA500", bold = true })
    vim.api.nvim_set_hl(0, "ObsidianDone", { fg = "#7ee787", bold = true })
    vim.api.nvim_set_hl(0, "ObsidianImportant", { fg = "#f47067", bold = true })
    vim.api.nvim_set_hl(0, "ObsidianBullet", { fg = "#7aa2f7" }) -- or whatever fits your style
  end,
  build = function()
    vim.cmd("KanagawaCompile")
  end,
}
