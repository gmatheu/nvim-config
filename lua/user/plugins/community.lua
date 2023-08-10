return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.editing-support/rainbow-delimiters-nvim" },
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

 -- { import = "astrocommunity.colorscheme.catppuccin" }
 { import = "astrocommunity.debugging.nvim-bqf" },
 -- { import = "astrocommunity.diagnostics.lsp_lines-nvim"},
 { import = "astrocommunity.git.git-blame-nvim" },

 { import = "astrocommunity.workflow.hardtime-nvim" },
 { import = "astrocommunity.workflow.bad-practices-nvim" },

 -- { import = "astrocommunity.pack.python" },
}
