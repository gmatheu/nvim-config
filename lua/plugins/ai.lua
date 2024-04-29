return {
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
    keys = {
      { "<LocalLeader>a", "<cmd>CodeCompanionToggle<CR>", desc = "Toogle chat [CodeCompanion]", mode = "n" },
      { "<LocalLeader>q", "<cmd>CodeCompanionActions<CR>", desc = "Actions [CodeCompanion]", mode = "n" },
      {
        "<LocalLeader>ca",
        "<cmd>CodeCompanionChat anthropic<CR>",
        desc = "Anthropic chat [CodeCompanion]",
        mode = "n",
      },
      { "<LocalLeader>co", "<cmd>CodeCompanionChat openai<CR>", desc = "OpenAI chat [CodeCompanion]", mode = "n" },
    },
    config = function()
      require("codecompanion").setup {
        adapters = {
          anthropic = require("codecompanion.adapters").use("anthropic", {
            schema = {
              model = {
                default = "claude-3-sonnet-20240229",
              },
            },
          }),
          openai = require("codecompanion.adapters").use("openai", {
            schema = {
              model = {
                default = "gpt-4-turbo",
              },
            },
          }),
        },
        strategies = {
          chat = "anthropic",
          inline = "anthropic",
        },
        display = {
          action_palette = {
            width = 95,
            height = 10,
          },
          chat = { -- Options for the chat strategy
            type = "buffer", -- float|buffer
            show_settings = true, -- Show the model settings in the chat buffer?
            show_token_count = true, -- Show the token count for the current chat in the buffer?
            buf_options = { -- Buffer options for the chat buffer
              buflisted = false,
            },
            float_options = { -- Float window options if the type is "float"
              border = "single",
              buflisted = false,
              max_height = 0,
              max_width = 0,
              padding = 1,
            },
            win_options = { -- Window options for the chat buffer
              cursorcolumn = false,
              cursorline = false,
              foldcolumn = "0",
              linebreak = true,
              list = false,
              signcolumn = "no",
              spell = false,
              wrap = true,
            },
          },
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

  {
    "piersolenski/wtf.nvim",
    dependencies = {
      "MunifTanjim/nui.nvim",
    },
    opts = {
      popup_type = "vertical",
      openai_model_id = "gpt-3.5-turbo",
      context = true,
      language = "english",
      -- additional_instructions = "Start the reply with 'OH HAI THERE'",
      search_engine = "phind",
      hooks = {
        request_started = nil,
        request_finished = nil,
      },
    },
    keys = {
      {
        "<LocalLeader>ta",
        mode = { "n", "x" },
        function() require("wtf").ai() end,
        desc = "Debug diagnostic with AI",
      },
      {
        "<LocalLeader>to",
        mode = { "n" },
        function() require("wtf").search() end,
        desc = "Search diagnostic with browser",
      },
    },
  },

  -- For debugging: export DEBUG_CODEIUM=trace
  {
    "Exafunction/codeium.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "hrsh7th/nvim-cmp",
    },
    config = function()
      require("codeium").setup {
        enable_chat = true,
      }
    end,
  },
  {
    "Exafunction/codeium.vim",
    enabled = false,
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
