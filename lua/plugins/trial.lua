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
    "mg979/vim-visual-multi",
    enabled = false,
    keys = {
      { "<c-n>", "<Plug>(VM-Find-Under)", mode = { "n" }, desc = "VM Find Under [vim-visual-multi]" },
    },
  },
  {
    "jake-stewart/multicursor.nvim",
    keys = {
      {
        "<c-n>",
        function() require("multicursor-nvim").matchAddCursor(1) end,
        mode = { "n" },
        desc = "VM Find Under [multicursor-nvim]",
      },
    },
    config = function()
      local mc = require "multicursor-nvim"

      mc.setup()

      local set = vim.keymap.set
      set({ "n", "v" }, "<up>", function() mc.lineAddCursor(-1) end)
      set({ "n", "v" }, "<down>", function() mc.lineAddCursor(1) end)
      set({ "n", "v" }, "<leader><up>", function() mc.lineSkipCursor(-1) end)
      set({ "n", "v" }, "<leader><down>", function() mc.lineSkipCursor(1) end)

      set({ "n", "v" }, "<c-n>", function() mc.matchAddCursor(1) end)
      set({ "n", "v" }, "<leader>s", function() mc.matchSkipCursor(1) end)
    end,
  },
  -- Alternatives:
  -- https://github.com/brenton-leighton/multiple-cursors.nvim

  {
    "gbprod/yanky.nvim",
    event = "VeryLazy",
    keys = {
      { "<c-p>", "<Plug>(YankyNextEntry)", mode = { "n" }, desc = "Prev yank ring item [yanky]" },
      { "p", "<Plug>(YankyPutAfter)", mode = { "n" }, desc = "Put after [yanky]" },
      { "P", "<Plug>(YankyPutBefore)", mode = { "n" }, desc = "Put before [yanky]" },
      { "gp", "<Plug>(YankyGPutAfter)", mode = { "n" }, desc = "Put after and leaver cursor [yanky]" },
      { "gP", "<Plug>(YankyGPutBefore)", mode = { "n" }, desc = "Put before and leaver cursor [yanky]" },
    },
    config = function()
      require("yanky").setup()
      require("telescope").load_extension "yank_history"
    end,
    opts = {},
  },

  {
    "ecthelionvi/NeoComposer.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = { "kkharji/sqlite.lua" },
    opts = {},
  },

  { "wakatime/vim-wakatime", lazy = false, enabled = not vim.env.ASTRONVIM_SKIP_WAKATIME },

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
    enabled = true,
    event = "VeryLazy",
    config = function() require("keymap-stats").setup { autoinstrument = false } end,
    cmd = { "KeymapStats" },
    priority = 999,
    dev = true,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "gmatheu/keymap-amend.nvim" },
    },
  },

  {
    "kiyoon/jupynium.nvim",
    enabled = false,
    build = "pip3 install --user .",
    -- build = "conda run --no-capture-output -n jupynium pip install .",
    -- enabled = vim.fn.isdirectory(vim.fn.expand "~/miniconda3/envs/jupynium"),
  },

  {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {},
    config = function()
      require("quicker").setup {
        keys = {
          {
            ">",
            function() require("quicker").expand { before = 2, after = 2, add_to_existing = true } end,
            desc = "Expand quickfix context",
          },
          {
            "<",
            function() require("quicker").collapse() end,
            desc = "Collapse quickfix context",
          },
        },
      }
    end,
  },

  {
    "mawkler/demicolon.nvim",
    -- keys = { ';', ',', 't', 'f', 'T', 'F', ']', '[', ']d', '[d' }, -- Uncomment this to lazy load
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    opts = {},
  },

  {
    "cbochs/grapple.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons", lazy = true },
    },
  },
  {
    "cbochs/portal.nvim",
    dependencies = {
      "cbochs/grapple.nvim",
    },
    config = function()
      require("portal").setup {
        labels = { "a", "b", "c", "d", "e", "f", "g" },
      }
    end,
    keys = {
      { "<tab>", "<cmd>Portal jumplist backward<cr>", mode = { "n" }, desc = "Jumplist backward [Portal]" },
      { "<s-tab>", "<cmd>Portal jumplist forward<cr>", mode = { "n" }, desc = "Jumplist forward [Portal]" },
    },
  },

  --
  --
  -- To try
  -- https://github.com/stevearc/stickybuf.nvim
  -- https://github.com/Theo-Steiner/theosteiner.de/issues/2#issuecomment-new
  -- https://github.com/stevearc/quicker.nvim?tab=readme-ov-file#installation
  -- https://github.com/MagicDuck/grug-far.nvim?tab=readme-ov-file
  -- https://github.com/gelguy/wilder.nvim
  -- https://github.com/nvim-neotest/neotest
  -- https://github.com/theHamsta/nvim-dap-virtual-text``
  -- https://github.com/SUSTech-data/wildfire.nvim
}
