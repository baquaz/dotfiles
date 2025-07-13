return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  -- dependencies = { "echasnovski/mini.icons" },
  opts = {},

  keys = {
    --  {
    --    "<leader>ff",
    --    function()
    --      require("fzf-lua").files()
    --    end,
    --    desc = "[F]ind [F]iles in Current Working Directory",
    --  },

    --  {
    --    "<leader>fc",
    --    function()
    --      require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
    --    end,
    --    desc = "[F]ind in [C]onfiguration files",
    --  },

    --  {
    --    "<leader>fs",
    --    function()
    --      require("fzf-lua").live_grep()
    --    end,
    --    desc = "[F]ind by [S]earching keyword",
    --  },

    --  {
    --    "<leader>fh",
    --    function()
    --      require("fzf-lua").helptags()
    --    end,
    --    desc = "[F]ind [H]elp",
    --  },

    --  {
    --    "<leader>fk",
    --    function()
    --      require("fzf-lua").keymaps()
    --    end,
    --    desc = "[F]ind [K]eymaps",
    --  },

    --  {
    --    "<leader>fr",
    --    function()
    --      require("fzf-lua").resume()
    --    end,
    --    desc = "[F]ind [R]esume",
    --  },

    --  {
    --    "<leader>fl",
    --    function()
    --      require("fzf-lua").oldfiles()
    --    end,
    --    desc = "[F]ind [L]atest",
    --  },

    {
      --"<leader><leader>",
      "<leader>.",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "[,] Find existing buffers",
    },

    --  {
    --    "<leader>/",
    --    function()
    --      require("fzf-lua").lgrep_curbuf()
    --    end,
    --    desc = "[/] Live grep current buffer",
    --  },
  },
}
