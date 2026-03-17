return {
  { import = "astrocommunity.recipes.ai" },
  {
    "Saghen/blink.cmp",
    optional = true,
    dependencies = {
      "Saghen/blink.compat",
    },
    opts = function(_, opts)
      if not opts.keymap then opts.keymap = {} end
      opts.keymap["<Tab>"] = {
        "snippet_forward",
        function()
          if vim.g.ai_accept then return vim.g.ai_accept() end
        end,
        function() -- sidekick next edit suggestion
          return require("sidekick").nes_jump_or_apply()
        end,
        -- function() -- if you are using Neovim's native inline completions
        --   return vim.lsp.inline_completion.get()
        -- end,
        "fallback",
      }
      opts.keymap["<S-Tab>"] = { "snippet_backward", "fallback" }
      -- opts.keymap["<A-y>"] = {
      --   function(cmp) cmp.show { providers = { "minuet" } } end,
      -- }
      --
      -- opts.sources = {
      --   -- if you want to use auto-complete
      --   default = { "minuet" },
      --   providers = {
      --     minuet = {
      --       name = "minuet",
      --       module = "minuet.blink",
      --       score_offset = 100,
      --     },
      --   },
      -- }

      opts.sources = vim.tbl_deep_extend("force", opts.sources or {}, {
        default = { "snippets", "ecolog", "buffer", "lsp", "path" },
        providers = {
          snippets = {
            score_offset = 800,
          },
          ecolog = {
            name = "ecolog",
            module = "blink.compat.source",
            score_offset = 600,
          },
          buffer = {
            score_offset = 500,
          },
          lsp = {
            score_offset = 400,
          },
          path = {
            score_offset = 250,
          },
        },
      })

      opts.cmdline = vim.tbl_deep_extend("force", opts.cmdline or {}, {
        enabled = true,
        sources = function()
          local cmd_type = vim.fn.getcmdtype()
          if cmd_type == "/" or cmd_type == "?" then return { "buffer" } end
          if cmd_type == ":" then return { "path", "cmdline", "buffer" } end
          return {}
        end,
      })
    end,
  },
}
