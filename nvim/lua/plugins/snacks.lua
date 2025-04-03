return {
  "snacks.nvim",
  opts = {
    indent = { enabled = false },
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
