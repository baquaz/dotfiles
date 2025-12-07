local function url_encode(str)
  if not str then
    return ""
  end
  str = str:gsub("\n", "")
  str = str:gsub("([^%w%-_%.~])", function(c)
    return string.format("%%%02X", string.byte(c))
  end)
  return str
end

local function get_relative_path(filepath, vault_path)
  local full_vault = vim.fn.expand(vault_path)
  local full_file = vim.fn.expand(filepath)
  full_vault = full_vault:gsub("/$", "")
  if full_file:sub(1, #full_vault) == full_vault then
    return full_file:sub(#full_vault + 2)
  end
  return vim.fn.fnamemodify(full_file, ":t")
end

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*", -- recommended, use latest release instead of latest commit
  -- lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  dependencies = {
    -- Required.
    "nvim-lua/plenary.nvim",
    "saghen/blink.cmp",
    -- see above for full list of optional dependencies ☝️
  },

  keys = {

    { "<leader>on", "<cmd>Obsidian new<cr>", desc = "New Obsidian note", mode = "n" },
    --    { "<leader>op", "<cmd>'Obsidian open<cr>", desc = "Open note in Obsidian app", mode = "n" },

    {
      "<leader>op",
      function()
        local vault_root = "~/notes" -- adjust this if your vault root differs
        local vault_name = "notes" -- vault name as in Obsidian app

        local filepath = vim.fn.expand("%:p") -- full absolute path of current buffer
        local relative_path = get_relative_path(filepath, vault_root)
        local encoded_path = url_encode(relative_path)

        local url = "obsidian://open?vault=" .. vault_name .. "&file=" .. encoded_path
        print("Opening URL: " .. url)
        os.execute("open '" .. url .. "'")
      end,
      desc = "Open current note in Obsidian app",
      mode = "n",
    },

    { "<leader>oo", "<cmd>Obsidian quick_switch<cr>", desc = "Quick Switch", mode = "n" },
    { "<leader>os", "<cmd>Obsidian search<cr>", desc = "Search Obsidian notes", mode = "n" },
    { "<leader>oi", "<cmd>Obsidian template<cr>", desc = "Insert template from a list", mode = "n" },
    { "<leader>od", "<cmd>Obsidian today<cr>", desc = "Quick Switch", mode = "n" },
    { "<leader>ot", "<cmd>Obsidian tags<cr>", desc = "Open Tags list", mode = "n" },
    { "<leader>ob", "<cmd>Obsidian backlinks<cr>", desc = "Show location list of backlinks", mode = "n" },

    {
      "<S-Tab>",
      function()
        local util = require("obsidian.util")
        local ok, open = pcall(util.cursor_on_markdown_link)
        if ok and open then
          vim.cmd("Obsidian follow_link")
        else
          vim.cmd("Obsidian toggle_checkbox")
        end
      end,
      desc = "Follow Obsidian link or toggle checkbox",
      mode = "n",
    },
    {
      "<S-Tab>",
      ":Obsidian toggle_checkbox<CR>",
      mode = "v",
      desc = "Toggle checkbox (visual mode)",
    },
  },

  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    log_level = vim.log.levels.INFO,
    legacy_commands = false,
    workspaces = {
      {
        name = "notes",
        -- path = vim.fn.expand("~/notes"),
        -- path = "~/notes",
        path = vim.fn.resolve(vim.fn.expand("~/notes")),
      },
      {
        name = "obsidian-lifeos-demo",
        path = vim.fn.resolve(vim.fn.expand("~/obsidian-lifeos-demo")),
      },
    },

    templates = {
      folder = "templates",
      -- Frontmatter settings for new notes
      created = { { date } },
      updated = { { date } },
      date_format = "%Y-%m-%d %A",
      tags = "", -- default empty; can override per template
    },

    note_id_func = function(title)
      local suffix = ""
      if title and title ~= "" then
        -- Sanitize title for filename
        suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
      else
        -- Generate 4 random uppercase letters if no title is given
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      -- Use timestamp + suffix as ID
      return tostring(os.time()) .. "-" .. suffix
    end,

    -- Frontmatter logic

    note_frontmatter_func = function(note)
      -- Start from the actual metadata read from the file
      local out = vim.deepcopy(note.metadata or {})

      -- Ensure ID
      out.id = note.id

      -- Ensure created timestamp exists
      if not out.created then
        out.created = os.date("%Y-%m-%d %H:%M:%S")
      end

      -- Always update updated timestamp
      out.updated = os.date("%Y-%m-%d %H:%M:%S")

      -- Ensure aliases and tags exist, but preserve any existing ones
      out.aliases = out.aliases or note.aliases or {}
      out.tags = out.tags or note.tags or {}

      return out
    end,

    daily_notes = {
      folder = "Review/Daily",
      date_format = "%Y-%m-%d",
      template = "1721579455-lifeos-daily.md",
      -- default_tags = { "daily-notes" },
    },

    completion = {
      blink = true,
      nvim_cmp = false,
      min_chars = 2,
      create_new = true,
    },

    -- Either 'wiki' or 'markdown'.
    preferred_link_style = "markdown",

    -- Optional, boolean or a function that takes a filename and returns a boolean.
    -- `true` indicates that you don't want obsidian.nvim to manage frontmatter.
    disable_frontmatter = false,

    new_notes_location = "notes_subdir",

    -- -- Optional, customize how note IDs are generated given an optional title.
    -- ---@param title string|?
    -- ---@return string
    -- note_id_func = function(title)
    --   -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
    --   -- In this case a note with the title 'My new note' will be given an ID that looks
    --   -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'.
    --   -- You may have as many periods in the note ID as you'd like—the ".md" will be added automatically
    --   local suffix = ""
    --   if title ~= nil then
    --     -- If title is given, transform it into valid file name.
    --     suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
    --     -- else
    --     --   -- If title is nil, just add 4 random uppercase letters to the suffix.
    --     --   for _ = 1, 4 do
    --     --     suffix = suffix .. string.char(math.random(65, 90))
    --     --   end
    --   end
    --   return tostring(os.time()) .. "-" .. suffix
    -- end,
    --
    -- -- Optional, customize how note file names are generated given the ID, target directory, and title.
    -- ---@param spec { id: string, dir: obsidian.Path, title: string|? }
    -- ---@return string|obsidian.Path The full path to the new note.
    -- note_path_func = function(spec)
    --   -- This is equivalent to the default behavior.
    --   local path = spec.dir / tostring(spec.id)
    --   return path:with_suffix(".md")
    -- end,
    --
    -- -- Optional, alternatively you can customize the frontmatter data.
    -- ---@return table
    -- note_frontmatter_func = function(note)
    --   -- Add the title of the note as an alias.
    --   -- if note.title then
    --   --   note:add_alias(note.title)
    --   -- end
    --
    --   local out = { id = note.id, aliases = note.aliases, tags = note.tags }
    --
    --   -- `note.metadata` contains any manually added fields in the frontmatter.
    --   -- So here we just make sure those fields are kept in the frontmatter.
    --   if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    --     for k, v in pairs(note.metadata) do
    --       out[k] = v
    --     end
    --   end
    --
    --   return out
    -- end,

    -- Sets how you follow URLs
    ---@param url string
    follow_url_func = function(url)
      vim.ui.open(url)
      -- vim.ui.open(url, { cmd = { "firefox" } })
    end,

    -- Sets how you follow images
    ---@param img string
    follow_img_func = function(img)
      vim.ui.open(img)
      -- vim.ui.open(img, { cmd = { "loupe" } })
    end,

    ---@class obsidian.config.OpenOpts
    ---
    ---Opens the file with current line number
    ---@field use_advanced_uri? boolean
    ---
    ---Function to do the opening, default to vim.ui.open
    ---@field func? fun(uri: string)
    open = {
      use_advanced_uri = false,
      --       func = function(url)
      --         vim.fn.jobstart({ "open", url }, { detach = true })
      --       end,

      -- func = vim.ui.open,

      func = function(url)
        print("Opening URL: " .. url) -- Add this for debug
        vim.fn.jobstart({ "open", url }, { detach = true })
      end,
    },

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', 'mini.pick' or 'snacks.pick'.
      name = "snacks.pick",
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = "<C-x>",
        -- Insert a link to the selected note.
        insert_link = "<C-l>",
      },
      tag_mappings = {
        -- Add tag(s) to current note.
        tag_note = "<C-x>",
        -- Insert a tag at the current location.
        insert_tag = "<C-l>",
      },
    },

    -- Optional, define your own callbacks to further customize behavior.
    callbacks = {
      -- Runs at the end of `require("obsidian").setup()`.
      ---@param client obsidian.Client
      post_setup = function(client) end,

      -- Runs anytime you enter the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      enter_note = function(client, note) end,

      -- Runs anytime you leave the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      leave_note = function(client, note) end,

      -- Runs right before writing the buffer for a note.
      ---@param client obsidian.Client
      ---@param note obsidian.Note
      pre_write_note = function(client, note) end,

      -- Runs anytime the workspace is set/changed.
      ---@param client obsidian.Client
      ---@param workspace obsidian.Workspace
      post_set_workspace = function(client, workspace) end,
    },

    checkboxes = {
      -- order controls cycling sequence when toggling checkboxes
      order = { " ", "x", "/", "?", ">", "~", "!" },
      -- symbols define how each checkbox looks
      symbols = {
        [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
        ["x"] = { char = "", hl_group = "ObsidianDone" },
        ["/"] = { char = "◧", hl_group = "ObsidianDone" },
        ["?"] = { char = "", hl_group = "ObsidianTodo" },
        [">"] = { char = "", hl_group = "ObsidianRightArrow" },
        ["~"] = { char = "󰜺", hl_group = "ObsidianTilde" },
        ["!"] = { char = "", hl_group = "ObsidianImportant" },
      },
    },
    ui = {
      enable = false,

      -- checkboxes = {
      --   [" "] = { char = "󰄱", hl_group = "ObsidianTodo" },
      --   ["x"] = { char = "", hl_group = "ObsidianDone" },
      --   ["/"] = { char = "◧", hl_group = "ObsidianDone" },
      --   ["?"] = { char = "", hl_group = "ObsidianTodo" },
      --   [">"] = { char = "", hl_group = "ObsidianRightArrow" },
      --   ["~"] = { char = "󰜺", hl_group = "ObsidianTilde" },
      --   ["!"] = { char = "", hl_group = "ObsidianImportant" },
      -- },

      bullets = { char = "", hl_group = "ObsidianBullet" },
      external_link_icon = { char = "", hl_group = "ObsidianExtLinkIcon" },

      block_ids = { hl_group = "ObsidianBlockID" },
      hl_groups = {
        ObsidianDone = { bold = true, fg = "#7ee787" },
        ObsidianImportant = { bold = true, fg = "#f47067" },
      },
    },

    ---@class obsidian.config.AttachmentsOpts
    ---
    ---Default folder to save images to, relative to the vault root.
    ---@field img_folder? string
    ---
    ---Default name for pasted images
    ---@field img_name_func? fun(): string
    ---
    ---Default text to insert for pasted images, for customizing, see: https://github.com/obsidian-nvim/obsidian.nvim/wiki/Images
    ---@field img_text_func? fun(path: obsidian.Path): string
    ---
    ---Whether to confirm the paste or not. Defaults to true.
    ---@field confirm_img_paste? boolean
    attachments = {
      img_folder = "attachments",
      img_name_func = function()
        return string.format("Pasted image %s", os.date("%Y%m%d%H%M%S"))
      end,
      confirm_img_paste = true,
    },
  },
}
