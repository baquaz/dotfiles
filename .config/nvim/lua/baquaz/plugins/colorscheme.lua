return {
  "catppuccin/nvim",
  priority = 1000, 
  name = "catppuccin",

  config = function()
    require("catppuccin").setup({
      transparent_background = true,
    })
    -- themes:
    -- catppuccin
    -- catppuccin-latte
    -- catppuccin-frappe
    -- catppuccin-macchiato
    -- catppuccin-mocha
    --
    -- setup must be called before loading
    vim.cmd.colorscheme "catppuccin-frappe"
  end,
}
