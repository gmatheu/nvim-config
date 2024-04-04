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
  --
  --
  -- { import = "astrocommunity/file-explorer/oil-nvim" },
  -- Monkey-patching config, since is brokend @ https://github.com/AstroNvim/astrocommunity/commit/c2218d5c9265e4537fab3958611b8ae27b1f1b63
  {
    "stevearc/oil.nvim",
    cmd = "Oil",
    dependencies = {
      {
        "AstroNvim/astrocore",
        opts = {
          mappings = {
            n = {
              ["<Leader>O"] = { function() require("oil").open() end, desc = "Open folder in Oil" },
            },
          },
          autocmds = {
            oil_settings = {
              {
                event = "FileType",
                desc = "Disable view saving for oil buffers",
                pattern = "oil",
                callback = function(args) vim.b[args.buf].view_activated = false end,
              },
              {
                event = "User",
                pattern = "OilActionsPost",
                desc = "Close buffers when files are deleted in Oil",
                callback = function(args)
                  if args.data.err then return end
                  for _, action in ipairs(args.data.actions) do
                    if action.type == "delete" then
                      local _, path = require("oil.util").parse_url(action.url)
                      local bufnr = vim.fn.bufnr(path)
                      if bufnr ~= -1 then require("astrocore.buffer").wipe(bufnr, true) end
                    end
                  end
                end,
              },
            },
          },
        },
      },
    },
    opts = {},
  },
}
