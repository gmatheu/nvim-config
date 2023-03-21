return {
  { "mbbill/undotree", cmd = { "UndotreeToggle" } },
  {
    "kylechui/nvim-surround",
    lazy = false,
    config = function() require("nvim-surround").setup {} end,
  },
  { "tpope/vim-fugitive", cmd = { "Git" } },
}
