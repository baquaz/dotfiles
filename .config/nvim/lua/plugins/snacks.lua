local cwd = require("utils.cwd").smart

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,

  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
  end,

  keys = {
    -- Explorer
    {
      "<leader>e",
      function()
        Snacks.picker.explorer()
      end,
      desc = "Files [E]xplorer",
    },

    -- File picker

    -- Snacks file picker for original directory Neovim was launched from
    {
      "<leader>fs",
      function()
        Snacks.picker.files({
          cwd = vim.fn.getcwd(),
          finder = "files",
          format = "file",
          show_empty = true,
          supports_live = true,
          -- In case you want to override the layout for this keymap
          -- layout = "vscode",
        })
      end,
      desc = "find nvim [S]tarted directory files",
    },

    {
      "<leader>fc",
      function()
        Snacks.picker.files({
          cwd = vim.fn.stdpath("config"),
          finder = "files",
          format = "file",
          show_empty = true,
          supports_live = true,
          -- In case you want to override the layout for this keymap
          -- layout = "vscode",
        })
      end,
      desc = "[F]ind in [C]onfiguration files",
    },

    -- Snacks file picker for current working directory (can change with :cd)
    {
      "<leader>ff",
      function()
        require("snacks").picker.files({ cwd = cwd() })
      end,
      desc = "Find Files",
    },

    -- Snacks file picker for original directory Neovim was launched from
    {
      "<leader>fo",
      function()
        require("snacks").picker.files({ cwd = vim.fn.getcwd(-1, -1) })
      end,
      desc = "Find Files (Original dir)",
    },

    {
      "<leader><space>",
      function()
        Snacks.picker.smart()
      end,
      desc = "Smart Find Files",
    },

    -- Grep Search
    {
      "<leader>ss",
      function()
        Snacks.picker.lines()
      end,
      desc = "fuzzy search inside the current file",
    },
    {
      "<leader>sg",
      function()
        Snacks.picker.grep()
      end,
      desc = "live grep full-project search",
    },
    {
      "<leader>s,",
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = "search across all open buffers",
    },
    {
      "<leader>sw",
      function()
        Snacks.picker.grep_word()
      end,
      desc = "Visual selection or word",
      mode = { "n", "x" },
    },
    {
      "<leader>sr",
      function()
        Snacks.picker.registers()
      end,
      desc = 'view and insert content from your registers (", "0, "1, etc.)',
    },

    -- Search Extra
    {
      "<leader>sh",
      function()
        Snacks.picker.help({
          layout = "vertical",
        })
      end,
      desc = "search [H]elp Pages",
    },
    {
      "<leader>sk",
      function()
        Snacks.picker.keymaps({
          layout = "vertical",
        })
      end,
      desc = "search [K]eymaps",
    },
    {
      "<leader>sd",
      function()
        Snacks.picker.diagnostics()
      end,
      desc = "Diagnostics",
    },

    {
      "<leader>sn",
      function()
        require("snacks.picker").notifications()
      end,
      desc = "Snacks: Notification History",
    },

    -- Navigate my buffers
    {
      "<leader>,",
      function()
        Snacks.picker.buffers()
      end,
      desc = "[P]Snacks picker buffers",
    },

    {
      "<leader>,d",
      function()
        Snacks.bufdelete()
      end,
      desc = "Buffer delete",
      mode = "n",
    },
    {
      "<leader>,a",
      function()
        Snacks.bufdelete.all()
      end,
      desc = "Buffer delete all",
      mode = "n",
    },
    {
      "<leader>,o",
      function()
        Snacks.bufdelete.other()
      end,
      desc = "Buffer delete other",
      mode = "n",
    },

    -- LSP
    {
      "gd",
      function()
        Snacks.picker.lsp_definitions()
      end,
      desc = "Goto Definition",
    },
    {
      "gD",
      function()
        Snacks.picker.lsp_declarations()
      end,
      desc = "Goto Declaration",
    },
    {
      "gr",
      function()
        Snacks.picker.lsp_references()
      end,
      nowait = true,
      desc = "References",
    },
    {
      "gI",
      function()
        Snacks.picker.lsp_implementations()
      end,
      desc = "Goto Implementation",
    },
    {
      "gy",
      function()
        Snacks.picker.lsp_type_definitions()
      end,
      desc = "Goto T[y]pe Definition",
    },
    {
      "<leader>sy",
      function()
        Snacks.picker.lsp_symbols()
      end,
      desc = "LSP Symbols",
    },
    {
      "<leader>sY",
      function()
        Snacks.picker.lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },

    {
      "<leader>z",
      function()
        Snacks.zen()
      end,
      desc = "Toggle Zen Mode",
      mode = "n",
    },
  },

  opts = {
    bigfile = { enabled = true },

    dashboard = {
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[
                                                                             
               ████ ██████           █████      ██                     
              ███████████             █████                             
              █████████ ███████████████████ ███   ███████████   
             █████████  ███    █████████████ █████ ██████████████   
            █████████ ██████████ █████████ █████ █████ ████ █████   
          ███████████ ███    ███ █████████ █████ █████ ████ █████  
         ██████  █████████████████████ ████ █████ █████ ████ ██████ 
      ]],
      },
      sections = {
        { section = "header" },
        {
          section = "keys",
          indent = 1,
          padding = 1,
        },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 2 },
        { section = "startup" },
      },
    },

    explorer = { enabled = true },

    indent = { enabled = true },

    picker = {
      enabled = true,

      debug = {
        scores = false,
      },
      layout = {
        preset = "ivy",
        cycle = false,
      },

      layouts = {
        -- I wanted to modify the ivy layout height and preview pane width,
        -- this is the only way I was able to do it
        -- NOTE: I don't think this is the right way as I'm declaring all the
        -- other values below, if you know a better way, let me know
        --
        -- Then call this layout in the keymaps above
        -- got example from here
        -- https://github.com/folke/snacks.nvim/discussions/468
        ivy = {
          layout = {
            box = "vertical",
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.5,
            border = "top",
            title = " {title} {live} {flags}",
            title_pos = "left",
            { win = "input", height = 1, border = "bottom" },
            {
              box = "horizontal",
              { win = "list", border = "none" },
              { win = "preview", title = "{preview}", width = 0.5, border = "left" },
            },
          },
        },
        -- I wanted to modify the layout width
        --
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = "vertical",
            border = "rounded",
            title = "{title} {live} {flags}",
            title_pos = "center",
            { win = "input", height = 1, border = "bottom" },
            { win = "list", border = "none" },
            { win = "preview", title = "{preview}", height = 0.4, border = "top" },
          },
        },
      },

      matcher = {
        frecency = true,
      },

      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            ["<Esc>"] = { "close", mode = { "n", "i" } },
            -- I'm used to scrolling like this in LazyGit
            ["J"] = { "preview_scroll_down", mode = { "i", "n" } },
            ["K"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["H"] = { "preview_scroll_left", mode = { "i", "n" } },
            ["L"] = { "preview_scroll_right", mode = { "i", "n" } },
          },
        },
      },
      formatters = {
        file = {
          filename_first = true, -- display filename before the file path
          truncate = 80,
        },
      },
    },

    notifier = {
      enabled = true,
      top_down = false, -- place notifications from top to bottom
    },

    -- This keeps the image on the top right corner, basically leaving your
    -- text area free, suggestion found in reddit by user `Redox_ahmii`
    -- https://www.reddit.com/r/neovim/comments/1irk9mg/comment/mdfvk8b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    styles = {
      snacks_image = {
        relative = "editor",
        col = -1,
      },
    },

    image = {
      enabled = true,
      doc = {
        -- Personally I set this to false, I don't want to render all the
        -- images in the file, only when I hover over them
        -- render the image inline in the buffer
        -- if your env doesn't support unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = vim.g.neovim_mode == "skitty" and true or false,
        -- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        -- Sets the size of the image
        -- max_width = 60,
        -- max_width = vim.g.neovim_mode == "skitty" and 20 or 60,
        -- max_height = vim.g.neovim_mode == "skitty" and 10 or 30,
        max_width = vim.g.neovim_mode == "skitty" and 5 or 60,
        max_height = vim.g.neovim_mode == "skitty" and 2.5 or 30,
        -- max_height = 30,
        -- Apparently, all the images that you preview in neovim are converted
        -- to .png and they're cached, original image remains the same, but
        -- the preview you see is a png converted version of that image
        --
        -- Where are the cached images stored?
        -- This path is found in the docs
        -- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
        -- For me returns `~/.cache/neobean/snacks/image`
        -- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
      },
    },

    quickfile = { enable = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },

    zen = {
      enabled = true,
      toggles = {
        dim = true, -- enable dimming for out-of-scope lines
        git_signs = false,
        diagnostics = false,
        line_number = false,
        relative_number = false,
        signcolumn = "no",
      },
      show = {
        statusline = false,
        tabline = false,
      },
      win = {
        style = "zen", -- use the built-in zen style with backdrop dimming
        backdrop = {
          transparent = true,
          blend = 10, -- stronger blend for clearer dimming effect
        },
      },
    },
  },

  -- For now - no need ufo (folded/unfolded)

  config = function(_, opts)
    require("snacks").setup(opts)

    Snacks.toggle.new({
      id = "ufo",
      name = "Enable/Disable ufo",
      get = function()
        return require("ufo").inspect()
      end,
      set = function(state)
        if state == nil then
          require("noice").enable()
          require("ufo").enable()
          vim.o.foldenable = true
          vim.o.foldcolumn = "1"
        else
          require("noice").disable()
          require("ufo").disable()
          vim.o.foldenable = false
          vim.o.foldcolumn = "0"
        end
      end,
    })
  end,
}
