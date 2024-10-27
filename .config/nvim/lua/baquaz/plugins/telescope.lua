return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- improve sorting performance of telescope
    "nvim-tree/nvim-web-devicons", -- show file icons
    "folke/todo-comments.nvim",
    "jonarrien/telescope-cmdline.nvim",
  },

  keys = {
    { ':', '<cmd>Telescope cmdline<cr>', desc = 'Cmdline' }
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        path_display = { "smart" }, -- smart displaying smart path when its prelong 
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous, -- move to prev result
            ["<C-j>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },

      extensions = {
        cmdline = {
          -- ... cmdline plugin settings ...
          picker = {
            layout_config = {
              width  = 120,
              height = 25,
            }
          },
          mappings = {
            complete      = '<Tab>',
            run_selection = '<C-CR>',
            run_input     = '<CR>',
          },
        },
      },
    })

    telescope.load_extension("fzf") -- load sorting performance
    telescope.load_extension("cmdline")

    -- set keymaps
    local keymap = vim.keymap -- for conciseness

    keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
    keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
    keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
    keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
    keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", { desc = "Find todos" })
    keymap.set("n", "<leader>f]", "<cmd>bn<CR>", { desc = "go to next file" }) -- go to next file
    keymap.set("n", "<leader>f[", "<cmd>bp<CR>", { desc = "go to previous file" }) -- go to previous file    

    -- How to use:

    -- press "ff" (Find Files)

    --
    -- navigate "ctrl + j,k" to jump to top/bottom
    --
    -- filter list typing any search keyword
    --
    -- press "fs" (File Search - grep) to search keyword in all files in entire project
    --
    -- press "fr" (Files Recent) to see recent opened files
  end,
}
