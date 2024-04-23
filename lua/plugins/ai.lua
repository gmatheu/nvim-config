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
    "sourcegraph/sg.nvim",
    enabled = false,
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim", --[[ "nvim-telescope/telescope.nvim ]]
    },
    keys = {
      {
        "<leader>f" .. "s",
        function() require("sg.extensions.telescope").fuzzy_search_results() end,
        desc = "Cody search [sg.nvim]",
      },
    },
    config = function() require("sg").setup {} end,
    build = "nvim -l build/init.lua",
  },
  {
    {
      "codota/tabnine-nvim",
      enabled = false,
      event = "VeryLazy",
      build = "./dl_binaries.sh",
      config = function()
        require("tabnine").setup {
          disable_auto_comment = true,
          accept_keymap = "<Tab>",
          dismiss_keymap = "<C-]>",
          debounce_ms = 800,
          suggestion_color = { gui = "#808080", cterm = 244 },
          exclude_filetypes = { "TelescopePrompt", "NvimTree" },
          log_file_path = nil, -- absolute path to Tabnine log file
        }
      end,
    },
  },

  {
    "jackMort/ChatGPT.nvim",
    enabled = true,
    -- event = "VeryLazy",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
      "ChatGPTCompleteCode",
    },
    config = function() require("chatgpt").setup() end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionInline",
      "CodeCompanionEdit",
      "CodeCompanionAdd",
      "CodeCompanionToggle",
      "CodeCompanionActions",
    },
    config = function()
      require("codecompanion").setup {
        strategies = {
          chat = "anthropic",
          inline = "anthropic",
        },
      }
    end,
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- Optional
      {
        "stevearc/dressing.nvim", -- Optional: Improves the default Neovim UI
        opts = {},
      },
      {
        "folke/edgy.nvim",
        event = "VeryLazy",
        init = function()
          vim.opt.laststatus = 3
          vim.opt.splitkeep = "screen"
        end,
        opts = {
          right = {
            { ft = "codecompanion", title = "Code Companion Chat", size = { width = 0.45 } },
          },
        },
      },
    },
  },
  --
  -- To try
  -- https://github.com/Theo-Steiner/theosteiner.de/issues/2#issuecomment-new
  -- https://github.com/nvim-neotest/neotest
  -- https://github.com/theHamsta/nvim-dap-virtual-text``
  -- https://github.com/mg979/vim-visual-multi
  -- https://github.com/gbprod/yanky.nvim--
  --
  --
  --
  --

  {
    "Exafunction/codeium.vim",
    event = "BufEnter",
    cmd = { "Codeium", "CodeiumEnable", "CodeiumDisable" },
    keys = {
      {
        "<C-g>",
        function() return vim.fn["codeium#Accept"]() end,
        desc = "Accept suggestion [Codeium]",
        mode = "i",
        expr = true,
        silent = true,
      },
      {
        "<C-j>",
        function() return vim.fn["codeium#CycleCompletion"](1) end,
        desc = "Cycle suggestion up [Codeium]",
        mode = "i",
        expr = true,
        silent = true,
      },
      {
        "<C-L>",
        function() return vim.fn["codeium#CycleCompletion"](-1) end,
        desc = "Cycle suggestion down [Codeium]",
        mode = "i",
        expr = true,
        silent = true,
      },
    },
  },
}
