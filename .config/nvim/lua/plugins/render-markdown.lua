return {
  "MeanderingProgrammer/render-markdown.nvim",
  -- dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
  -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  --  event = "BufReadPre *.md", -- ensure it loads *after* markdown files
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    enabled = true,
    completions = { blink = { enabled = true } },
    render_modes = { "n" },
    heading = {
      -- Useful context to have when evaluating values.
      -- | level    | the number of '#' in the heading marker         |
      -- | sections | for each level how deeply nested the heading is |

      -- Turn on / off heading icon & background rendering.
      enabled = true,
      -- Additional modes to render headings.
      render_modes = false,
      -- Turn on / off atx heading rendering.
      atx = true,
      -- Turn on / off setext heading rendering.
      setext = true,
      -- Turn on / off any sign column related rendering.
      sign = true,
      -- Replaces '#+' of 'atx_h._marker'.
      -- Output is evaluated depending on the type.
      -- | function | `value(context)`              |
      -- | string[] | `cycle(value, context.level)` |
      --      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      icons = { "", "  ◉ ", "   ○ ", "    ▪ ", "     ▫ ", "     · " },
      -- Determines how icons fill the available space.
      -- | right   | '#'s are concealed and icon is appended to right side                          |
      -- | inline  | '#'s are concealed and icon is inlined on left side                            |
      -- | overlay | icon is left padded with spaces and inserted on left hiding any additional '#' |
      position = "overlay",
      -- Added to the sign column if enabled.
      -- Output is evaluated by `cycle(value, context.level)`.
      signs = { "󰫎 " },
      -- Width of the heading background.
      -- | block | width of the heading text |
      -- | full  | full width of the window  |
      -- Can also be a list of the above values evaluated by `clamp(value, context.level)`.
      width = "block",
      -- Amount of margin to add to the left of headings.
      -- Margin available space is computed after accounting for padding.
      -- If a float < 1 is provided it is treated as a percentage of available window space.
      -- Can also be a list of numbers evaluated by `clamp(value, context.level)`.
      left_margin = 0,
      -- Amount of padding to add to the left of headings.
      -- Output is evaluated using the same logic as 'left_margin'.
      left_pad = 0,
      -- Amount of padding to add to the right of headings when width is 'block'.
      -- Output is evaluated using the same logic as 'left_margin'.
      right_pad = 2,
      -- Minimum width to use for headings when width is 'block'.
      -- Can also be a list of integers evaluated by `clamp(value, context.level)`.
      min_width = 0,
      -- Determines if a border is added above and below headings.
      -- Can also be a list of booleans evaluated by `clamp(value, context.level)`.
      border = true,
      -- Always use virtual lines for heading borders instead of attempting to use empty lines.
      border_virtual = true,
      -- Highlight the start of the border using the foreground highlight.
      border_prefix = false,
      -- Used above heading for border.
      above = "▄",
      -- Used below heading for border.
      below = "▀",
      -- Highlight for the heading icon and extends through the entire line.
      -- Output is evaluated by `clamp(value, context.level)`.
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      -- Highlight for the heading and sign icons.
      -- Output is evaluated using the same logic as 'backgrounds'.
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
      -- Define custom heading patterns which allow you to override various properties based on
      -- the contents of a heading.
      -- The key is for healthcheck and to allow users to change its values, value type below.
      -- | pattern    | matched against the heading text @see :h lua-patterns |
      -- | icon       | optional override for the icon                        |
      -- | background | optional override for the background                  |
      -- | foreground | optional override for the foreground                  |
      custom = {},
    },

    checkbox = {
      -- Enable or disable checkbox rendering
      enabled = true,
      -- Disable additional render modes for checkboxes
      render_modes = false,
      -- Don't render bullet point before checkbox
      bullet = false,
      -- Padding right of checkbox icon
      right_pad = 0,

      unchecked = {
        -- Icon replacing '[ ]' for unchecked task
        icon = "☐ ",
        -- Highlight group for unchecked icon
        highlight = "RenderMarkdownUnchecked",
        -- Highlight group for the item text (optional)
        scope_highlight = nil,
      },

      checked = {
        -- Icon replacing '[x]' for checked task
        icon = "✔︎ ",
        -- Highlight group for checked icon
        highlight = "RenderMarkdownChecked",
        -- Highlight group for the item text (optional)
        scope_highlight = "RenderMarkdownChecked", -- nil,
      },

      -- Custom checkbox states for extended syntax (requires Neovim >= 0.10)
      custom = {
        todo = {
          raw = "[-]", -- Raw markdown text matched
          rendered = "➜ ", -- Rendered icon
          highlight = "RenderMarkdownTodo",
          scope_highlight = nil,
        },
        alert = {
          raw = "[!]", -- matches your markdown [!]
          rendered = " ", -- icon to replace [!]
          highlight = "RenderMarkdownFire", -- highlight group (choose your favorite)
          scope_highlight = "RenderMarkdownFire", -- nil,
        },
      },
    },
  },

  -- This configuration ensures that render-markdown.nvim only renders markdown decorations
  -- when in normal mode (`n`) and disables them in all other modes (insert, visual, etc.).
  -- It applies only to markdown buffers to avoid affecting other filetypes.
  --config = function(_, opts)
  --  local render_markdown = require("render-markdown")
  --  render_markdown.setup(opts) -- Setup plugin with user-defined options

  --  -- Dynamically enable/disable rendering based on mode
  --  vim.api.nvim_create_autocmd("ModeChanged", {
  --    pattern = "*",
  --    callback = function(args)
  --      local buf = vim.api.nvim_get_current_buf()

  --      -- Only apply to markdown files
  --      local ft = vim.bo[buf].filetype
  --      if ft ~= "markdown" then
  --        return
  --      end

  --      -- Extract the mode we're entering (e.g. "n" from "i:n", "v:n", etc.)
  --      local mode = args.match:sub(-1)

  --      -- Enable rendering only in normal mode
  --      if mode == "n" then
  --        render_markdown.toggle(buf, true)
  --      else
  --        render_markdown.toggle(buf, false)
  --      end
  --    end,
  --  })
  --end,
}
