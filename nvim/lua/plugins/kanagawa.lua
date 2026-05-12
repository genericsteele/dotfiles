return {
  {
    "rebelot/kanagawa.nvim",
    opts = {
      theme = "dragon",
      background = {
        dark = "dragon",
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
      colorscheme = "kanagawa-dragon",
    },
  },
}
