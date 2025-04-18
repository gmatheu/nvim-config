return {
  { import = "astrocommunity.recipes.ai" },
  {
    "Saghen/blink.cmp",
    optional = true,
    opts = function(_, opts)
      if not opts.keymap then opts.keymap = {} end
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function()
          if vim.g.ai_accept then return vim.g.ai_accept() end
        end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
    end,
  },

  -- TODO: To be removed after v5 migration
  { -- override nvim-cmp plugin
    "hrsh7th/nvim-cmp",
    enabled = false,
    keys = { ":", "/", "?" }, -- lazy load cmp on more keys along with insert mode
    dependencies = {
      --"hrsh7th/cmp-cmdline", -- add cmp-cmdline as dependency of cmp
    },
    -- override the options table that is used in the `require("cmp").setup()` call
    opts = function(_, opts)
      -- opts parameter is the default options table
      -- the function is lazy loaded so cmp is able to be required
      local cmp = require "cmp"
      -- modify the sources part of the options table
      opts.sources = cmp.config.sources {
        { name = "path", priority = 250 },
        { name = "nvim_lsp", priority = 400 },
        { name = "buffer", priority = 500 },
        { name = "ecolog", priority = 600 },
        { name = "codeium", priority = 600 },
        { name = "supermaven", priority = 610 },
        { name = "luasnip", priority = 800 },
      }
    end,
    config = function(_, opts)
      local cmp = require "cmp"
      -- run cmp setup
      cmp.setup(opts)

      -- configure `cmp-cmdline` as described in their repo: https://github.com/hrsh7th/cmp-cmdline#setup
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
