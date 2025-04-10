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
    dev = true,
    event = "VeryLazy",
    config = function()
      require("keymap-stats").setup {
        autoinstrument = true,
        notify = false or os.getenv("KEYMAP_STATS_NVIM" .. "_NOTIFY"),
        debug = false or os.getenv("KEYMAP_STATS_NVIM" .. "_DEBUG") or os.getenv("ASTRONVIM" .. "_DEBUG"),
        plugins = { which_key = false, hardtime = true, keymap = true },
      }
    end,
    cmd = { "KeymapStats" },
    priority = 990,
    dependencies = {
      { "MunifTanjim/nui.nvim" },
      { "gmatheu/keymap-amend.nvim", dev = true },
      {
        "m4xshen/hardtime.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
        priority = 995,
      },
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

  {
    "philosofonusus/ecolog.nvim",
    dependencies = {
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
    },
    cmd = { "EcologGoto", "EcologPeek", "EcologSelect", "EcologFzf" },
    -- Optional: you can add some keybindings
    -- (I personally use lspsaga so check out lspsaga integration or lsp integration for a smoother experience without separate keybindings)
    -- keys = {
    --   { "<leader>ge", "<cmd>EcologGoto<cr>", desc = "Go to env file" },
    --   { "<leader>ep", "<cmd>EcologPeek<cr>", desc = "Ecolog peek variable" },
    --   { "<leader>es", "<cmd>EcologSelect<cr>", desc = "Switch env file" },
    -- },
    -- Lazy loading is done internally
    -- lazy = false,
    -- opts = {},
    config = function()
      ---@diagnostic disable-next-line: missing-fields
      require("ecolog").setup {
        ---@diagnostic disable-next-line: missing-fields
        integrations = {
          nvim_cmp = true,
          blink_cmp = false,
          fzf = true,
        },
        -- Enables shelter mode for sensitive values
        shelter = {
          configuration = {
            partial_mode = false, -- false by default, disables partial mode, for more control check out shelter partial mode
            mask_char = "*", -- Character used for masking
          },
          modules = {
            cmp = true, -- Mask values in completion
            peek = false, -- Mask values in peek view
            files = false, -- Mask values in files
            telescope = false, -- Mask values in telescope
            fzf = false, -- Mask values in fzf picker
          },
        },
        -- true by default, enables built-in types (database_url, url, etc.)
        types = true,
        path = vim.fn.getcwd(), -- Path to search for .env files
        preferred_environment = "development", -- Optional: prioritize specific env files

        load_shell = {
          enabled = true, -- Enable shell variable loading
          override = false, -- When false, .env files take precedence over shell variables
          -- Optional: filter specific shell variables
          filter = function(key, _value)
            -- Example: only load specific variables
            return key:match "^(PATH|HOME|USER)$" ~= nil
          end,
          -- Optional: transform shell variables before loading
          transform = function(_key, value)
            -- Example: prefix shell variables for clarity
            return "[shell] " .. value
          end,
        },
      }

      require("telescope").load_extension "ecolog"
    end,
  },

  {
    "echasnovski/mini.pick",
    version = "*",
    cmd = { "Pick" },
    config = function() require("mini.pick").setup() end,
  },
  {
    "hiberabyss/readline.nvim",
    event = "CmdlineEnter",
    keys = {
      {
        "<C-a>",
        function() require("readline").beginning_of_line() end,
        desc = "Beginning of line [readline]",
        mode = { "c", "i" },
      },
      {
        "<C-e>",
        function() require("readline").end_of_line() end,
        desc = "End of line [readline]",
        mode = { "c", "i" },
      },
      {
        "<C-u>",
        function() require("readline").backward_kill_line() end,
        desc = "Backgward kill line [readline]",
        mode = "c",
      },
      { "<C-k>", function() require("readline").kill_line() end, desc = "Kill line [readline]", mode = "c" },
      { "<C-d>", function() require("readline").kill_word() end, desc = "Kill word [readlined]", mode = "c" },
      {
        "<A-BS>",
        function() require("readline").backward_kill_word() end,
        desc = "Backward kill word [readline]",
        mode = "c",
      },
      { "<A-b>", function() require("readline").forward_word() end, desc = "Forward word [readline]", mode = "c" },
      { "<A-f>", function() require("readline").backward_word() end, desc = "Backward word [readline]", mode = "c" },
    },
  },
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
