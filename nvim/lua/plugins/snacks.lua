return {
  "snacks.nvim",
  opts = {
    indent = { enabled = false },
  },
  keys = {
    { "<leader><space>", LazyVim.pick("smart"), desc = "Find Files (Smart)" },
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
