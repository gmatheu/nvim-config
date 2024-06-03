return {
  {
    "rasulomaroff/reactive.nvim",
    event = "VeryLazy",
    config = function()
      require("reactive").setup {
        builtin = {
          cursorline = true,
          cursor = true,
          modemsg = false,
        },
      }
    end,
  },

  {
    "folke/noice.nvim",
    event = "VeryLazy",
    config = function()
      require("noice").setup {
        cmdline = {
          view = "cmdline", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        },
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        -- you can enable a preset for easier configuration
        presets = {
          bottom_search = true, -- use a classic bottom cmdline for search
          command_palette = false, -- position the cmdline and popupmenu together
          long_message_to_split = true, -- long messages will be sent to a split
          inc_rename = false, -- enables an input dialog for inc-rename.nvim
          lsp_doc_border = false, -- add a border to hover docs and signature help
        },
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = ":", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = {}, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      }
      require("telescope").load_extension "noice"
    end,
    opts = {},
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needtrueed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },

  {
    "jinh0/eyeliner.nvim",
    event = "VeryLazy",
    config = function()
      require("eyeliner").setup {
        highlight_on_key = false, -- show highlights only after keypress
        dim = false, -- dim all other characters if set to true (recommended!)
      }
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
  },

  {
    "ecthelionvi/NeoComposer.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "kkharji/sqlite.lua" },
    opts = {},
  },

  { "wakatime/vim-wakatime", lazy = false },

  {
    "danymat/neogen",
    enabled = false,
    cmd = { "Neogen" },
    config = true,
    -- Uncomment next line if you want to follow only stable versions
    -- version = "*"
  },

  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",
      "mfussenegger/nvim-dap",
      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
  },

  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      require("textcase").setup {}
      require("telescope").load_extension "textcase"
    end,
    keys = {
      "ga", -- Default invocation prefix
      { "ga.", "<cmd>TextCaseOpenTelescope<CR>", mode = { "n", "x" }, desc = "Telescope" },
    },
    cmd = {
      -- NOTE: The Subs command name can be customized via the option "substitude_command_name"
      "Subs",
      "TextCaseOpenTelescope",
      "TextCaseOpenTelescopeQuickChange",
      "TextCaseOpenTelescopeLSPChange",
      "TextCaseStartReplacingCommand",
    },
    -- If you want to use the interactive feature of the `Subs` command right away, text-case.nvim
    -- has to be loaded on startup. Otherwise, the interactive feature of the `Subs` will only be
    -- available after the first executing of it or after a keymap of text-case.nvim has been used.
    lazy = false,
  },
  {
    "Makaze/watch.nvim",
    cmd = { "WatchStart", "WatchStop", "WatchFile" },
  },

  {
    "tris203/precognition.nvim",
    keys = {
      { "<LocalLeader>Xp", mode = { "n" }, desc = "Precognition" },
      {
        "<LocalLeader>Xpp",
        function() require("precognition").peek() end,
        mode = { "n" },
        desc = "Peek [Precognition]",
      },
      {
        "<LocalLeader>pt",
        function() require("precognition").toggle() end,
        mode = { "n" },
        desc = "Toggle [Precognition]",
      },
    },
    config = {
      startVisible = false,
      -- hints = {
      --     ["^"] = { text = "^", prio = 1 },
      --     ["$"] = { text = "$", prio = 1 },
      --     ["w"] = { text = "w", prio = 10 },
      --     ["b"] = { text = "b", prio = 10 },
      --     ["e"] = { text = "e", prio = 10 },
      -- },
      -- gutterHints = {
      --     --prio is not currentlt used for gutter hints
      --     ["G"] = { text = "G", prio = 1 },
      --     ["gg"] = { text = "gg", prio = 1 },
      --     ["{"] = { text = "{", prio = 1 },
      --     ["}"] = { text = "}", prio = 1 },
      -- },
    },
  },

  { "ii14/neorepl.nvim", enabled = false, cmd = { "Repl" } },

  {
    "gmatheu/keymap-stats.nvim",
    event = "VeryLazy",
    config = function() require("keymap-stats").setup() end,
    cmd = { "KeymapStats" },
    enabled = true,
    priority = 0,
    dev = false,
  },

  {
    "kiyoon/jupynium.nvim",
    enabled = false,
    build = "pip3 install --user .",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  },
  --
  --
  -- To try
  -- https://github.com/Theo-Steiner/theosteiner.de/issues/2#issuecomment-new
  -- https://github.com/nvim-neotest/neotest
  -- https://github.com/theHamsta/nvim-dap-virtual-text``
  -- https://github.com/mg979/vim-visual-multi
  -- https://github.com/gbprod/yanky.nvim--
  -- https://github.com/SUSTech-data/wildfire.nvim
}
