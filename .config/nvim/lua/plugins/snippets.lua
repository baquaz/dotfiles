return {
  "chrisgrieser/nvim-scissors",

  opts = {
    snippetDir = vim.fn.stdpath("config") .. "/snippets",
  },

  keys = {
    {
      "<leader>sp",
      function()
        require("scissors").addNewSnippet()
      end,
      mode = { "n", "x" },
      desc = "Snippet: Add (sni[P]pet)",
    },
    {
      "<leader>so",
      function()
        require("scissors").editSnippet()
      end,
      mode = "n",
      desc = "Snippet: Edit ([O]verride)",
    },
  },
}
