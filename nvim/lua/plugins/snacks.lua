return {
  "snacks.nvim",
  opts = {
    indent = { enabled = false },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('smart')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "i", desc = "Git Changes", action = ":lua Snacks.dashboard.pick('git_status')" },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      sections = {
        { section = "header" },
        { section = "keys", padding = 1 },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 2, padding = 1 },
        {
          section = "terminal",
          icon = " ",
          title = "Git Status",
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = "git status --short --branch --renames",
          height = 5,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = "startup" },
      },
    },
  },
  keys = {
    { "<leader><space>", LazyVim.pick("smart"), desc = "Find Files (Smart)" },
    {
      "<leader>fd",
      function()
        Snacks.picker.files({
          cwd = vim.fn.expand("$HOME/code/dotfiles"),
          follow = true,
        })
      end,
      desc = "Find dotfiles",
    },
    {
      "<leader>fc",
      function()
        Snacks.picker.files({
          cwd = vim.fn.stdpath("config"),
          follow = true,
        })
      end,
      desc = "Find Config Files",
    },
  },
}
