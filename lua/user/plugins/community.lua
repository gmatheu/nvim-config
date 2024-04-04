return {
  -- Add the community repository of plugin specifications
  "AstroNvim/astrocommunity",
  { import = "astrocommunity.editing-support/rainbow-delimiters-nvim" },
  -- example of imporing a plugin, comment out to use it or add your own
  -- available plugins can be found at https://github.com/AstroNvim/astrocommunity

  -- { import = "astrocommunity.colorscheme.catppuccin" }

  { import = "astrocommunity.debugging.nvim-bqf" },
  { "junegunn/fzf", event = "VeryLazy" },
  { "junegunn/fzf.vim", event = "VeryLazy" },

  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim"},
  { import = "astrocommunity.git.git-blame-nvim" },

  { import = "astrocommunity.workflow.hardtime-nvim" },
  { import = "astrocommunity.workflow.bad-practices-nvim" },

  { import = "astrocommunity.project.project-nvim" },
  -- { import = "astrocommunity.pack.python" },

  -- { import = "astrocommunity.pack.java" },

  { import = "astrocommunity.editing-support.refactoring-nvim" },
  { import = "astrocommunity/file-explorer/oil-nvim" },
}
