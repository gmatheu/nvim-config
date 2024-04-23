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
