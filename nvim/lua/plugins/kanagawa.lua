return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      theme = "wave",
      background = {
        dark = "wave",
        light = "lotus",
      },
      overrides = function()
        return {
          StatusLine = { link = "lualine_c_normal" },
        }
      end,
      colors = {
        theme = {
          all = {
            ui = {
              bg_gutter = "none",
            },
          },
        },
      },
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa-wave",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    options = {
      theme = "kanagawa-wave",
    },
  },
}
