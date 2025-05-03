return {
  {
    --[["miikanissi/modus-themes.nvim",
    priority = 1000,
    config = function()
      require("modus-themes").setup({
        variant = "tinted",
      })
    end,]]
    --"igrmk/kull-vim"
    "jnurmine/Zenburn",
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "zenburn",
    },
  },
}
