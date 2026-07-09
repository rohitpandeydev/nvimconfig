return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
        styles = {
          comments = { "italic" },
          keywords = { "bold" },
          functions = { "bold" },
        },
        color_overrides = {
          mocha = {
            base = "#11111b",
            mantle = "#181825",
            crust = "#101018",
          },
        },
        integrations = {
          cmp = true,
          gitsigns = true,
          telescope = { enabled = true },
          treesitter = true,
          which_key = true,
          mason = true,
          noice = true,
          notify = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { "underline" },
              hints = { "underline" },
              warnings = { "underline" },
              information = { "underline" },
            },
          },
        },
      })

      vim.cmd("colorscheme catppuccin")
    end,
  },
}
