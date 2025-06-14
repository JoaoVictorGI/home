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
    -- "jnurmine/Zenburn",
    "oonamo/ef-themes.nvim",
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "ef-dream",
    },
  },
}
