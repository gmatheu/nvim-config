return {
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
    "gmatheu/ChatGPT.nvim",
    dev = true,
    enabled = true,
    -- event = "VeryLazy",
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
      "ChatGPTCompleteCode",
    },
    keys = {
      {
        "<LocalLeader>cc",
        "<cmd>ChatGPT<CR>",
        desc = "Open Chat [ChatGPT]",
        mode = "n",
      },
      {
        "<LocalLeader>ce",
        "<cmd>ChatGPTEditWithInstruction<CR>",
        desc = "Edit with instruction [ChatGPT]",
        mode = "n",
      },
    },
    config = function()
      require("chatgpt").setup {
        api_key_cmd = "pass show intive/openai/gm-org/api-key",
        openai_params = {
          model = "gpt-4o",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens = 300,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        openai_edit_params = {
          model = "gpt-4o",
          frequency_penalty = 0,
          presence_penalty = 0,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
        popup_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " ChatGPT ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "1",
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            relativenumber = true,
          },
          buf_options = {
            filetype = "markdown",
          },
        },
        system_window = {
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top = " SYSTEM ",
            },
          },
          win_options = {
            wrap = true,
            linebreak = true,
            foldcolumn = "2",
            relativenumber = true,
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
          },
        },
        popup_input = {
          prompt = "  ",
          border = {
            highlight = "FloatBorder",
            style = "rounded",
            text = {
              top_align = "center",
              top = " Prompt ",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:FloatBorder",
            relativenumber = true,
          },
          submit = "<C-Enter>",
          submit_n = "<Enter>",
          max_visible_lines = 20,
        },
      }
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "folke/trouble.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "olimorris/codecompanion.nvim",
    -- dev = true,
    enabled = true,
    cmd = {
      "CodeCompanion",
      "CodeCompanionChat",
      "CodeCompanionInline",
      "CodeCompanionEdit",
      "CodeCompanionAdd",
      "CodeCompanionToggle",
      "CodeCompanionActions",
    },
    lazy = true,
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
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:pass show intive/anthropic/gm-org/api-key",
              },
              schema = {
                model = {
                  default = "claude-3-5-sonnet-20240620",
                },
              },
            })
          end,
          openai = function()
            return require("codecompanion.adapters").extend("openai", {
              env = {
                api_key = "cmd:pass show intive/openai/gm-org/api-key",
              },
              schema = {
                model = {
                  default = "gpt-4o",
                },
              },
            })
          end,
          llama3 = function()
            return require("codecompanion.adapters").extend("ollama", {
              name = "llama3.2:1b", -- Give this adapter a different name to differentiate it from the default ollama adapter
              schema = {
                model = {
                  default = "llama3.2:1b",
                },
                num_ctx = {
                  default = 16384,
                },
                num_predict = {
                  default = -1,
                },
              },
            })
          end,
        },
        strategies = {
          chat = { adapter = "anthropic" },
          inline = { adapter = "anthropic" },
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
    "huynle/ogpt.nvim",
    enabled = false,
    event = "VeryLazy",
    opts = {
      default_provider = "anthropic",
      edgy = true, -- enable this!
      single_window = true, -- set this to true if you want only one OGPT window to appear at a time
    },
    cmd = {
      "ChatGPT",
      "ChatGPTActAs",
      "ChatGPTEditWithInstructions",
      "ChatGPTRun",
      "ChatGPTCompleteCode",
    },
    keys = {
      {
        "<LocalLeader>cc",
        "<cmd>ChatGPT<CR>",
        desc = "Open Chat [ChatGPT]",
        mode = "n",
      },
    },
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    init = function()
      vim.opt.laststatus = 3
      vim.opt.splitkeep = "screen" -- or "topline" or "screen"
    end,
    opts = {
      exit_when_last = false,
      animate = {
        enabled = false,
      },
      wo = {
        winbar = true,
        winfixwidth = true,
        winfixheight = false,
        winhighlight = "WinBar:EdgyWinBar,Normal:EdgyNormal",
        spell = false,
        signcolumn = "no",
      },
      keys = {
        -- -- close window
        ["q"] = function(win) win:close() end,
        -- close sidebar
        ["Q"] = function(win) win.view.edgebar:close() end,
        -- increase width
        ["<S-Right>"] = function(win) win:resize("width", 3) end,
        -- decrease width
        ["<S-Left>"] = function(win) win:resize("width", -3) end,
        -- increase height
        ["<S-Up>"] = function(win) win:resize("height", 3) end,
        -- decrease height
        ["<S-Down>"] = function(win) win:resize("height", -3) end,
      },
      right = {
        {
          title = "OGPT Popup",
          ft = "ogpt-popup",
          size = { width = 0.2 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT Parameters",
          ft = "ogpt-parameters-window",
          size = { height = 6 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT Template",
          ft = "ogpt-template",
          size = { height = 6 },
        },
        {
          title = "OGPT Sessions",
          ft = "ogpt-sessions",
          size = { height = 6 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT System Input",
          ft = "ogpt-system-window",
          size = { height = 6 },
        },
        {
          title = "OGPT",
          ft = "ogpt-window",
          size = { height = 0.5 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT {{{selection}}}",
          ft = "ogpt-selection",
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPt {{{instruction}}}",
          ft = "ogpt-instruction",
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
          },
        },
        {
          title = "OGPT Chat",
          ft = "ogpt-input",
          size = { width = 80, height = 4 },
          wo = {
            wrap = true,
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
        "<LocalLeader>t",
        mode = { "n", "x" },
        desc = "wtf",
      },
      {
        "<LocalLeader>ta",
        mode = { "n", "x" },
        function() require("wtf").ai() end,
        desc = "Debug diagnostic with AI [wtf]",
      },
      {
        "<LocalLeader>to",
        mode = { "n" },
        function() require("wtf").search() end,
        desc = "Search diagnostic with browser [wtf]",
      },
    },
  },

  -- For debugging: export DEBUG_CODEIUM=trace
  {
    "gmatheu/codeium.nvim",
    dev = false,
    enabled = false,
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
  {
    "monkoose/neocodeium",
    cmd = { "NeoCodeium" },
    enabled = not vim.env.ASTRONVIM_SKIP_NEOCODEIUM,
    config = function()
      local neocodeium = require "neocodeium"
      neocodeium.setup()
      vim.keymap.set("i", "<A-f>", function() neocodeium.accept() end)
      vim.keymap.set("i", "<A-w>", function() neocodeium.accept_word() end)
      vim.keymap.set("i", "<A-a>", function() neocodeium.accept_line() end)
      vim.keymap.set("i", "<A-r>", function() neocodeium.cycle_or_complete() end)
      -- vim.keymap.set("i", "<A-r>", function() neocodeium.cycle_or_complete(-1) end)
      vim.keymap.set("i", "<A-c>", function() neocodeium.clear() end)
    end,
  },

  {
    "supermaven-inc/supermaven-nvim",
    cmd = { "SupermavenStatus", "SupermavenToggle", "SupermavenStart" },
    config = function()
      require("supermaven-nvim").setup {
        disable_keymaps = true,
        -- keymaps = {
        --   accept_suggestion = "<A-f>",
        --   clear_suggestion = "<A-c>",
        --   accept_word = "<A-w>",
        -- },
        ignore_filetypes = { cpp = true },
        color = {
          suggestion_color = "#2222ff",
          cterm = 244,
        },
        log_level = "info", -- set to "off" to disable logging completely
        disable_inline_completion = false,
      }
      local keymap = vim.keymap
      keymap.amend = require "keymap-amend"
      local completion_preview = require "supermaven-nvim.completion_preview"
      local supermaven = require "supermaven-nvim.api"
      local amend_if_running = function(lhs, callback)
        keymap.amend("i", lhs, function(original)
          if supermaven.is_running() then
            callback()
          else
            original()
          end
        end)
      end
      amend_if_running("<A-f>", completion_preview.on_accept_suggestion)
      amend_if_running("<A-w>", completion_preview.on_accept_suggestion_word)
      amend_if_running("<A-c>", completion_preview.on_dispose_inlay)
    end,
    dependencies = {
      { "anuvyklack/keymap-amend.nvim" },
    },
  },

  {
    enabled = false,
    "github/copilot.vim",
    cmd = "Copilot",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.g.copilot_assume_mapped = true
    end,
  },
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    config = function()
      require("copilot").setup {
        panel = {
          enabled = true,
          auto_refresh = false,
          keymap = {
            jump_prev = "[[",
            jump_next = "]]",
            accept = "<CR>",
            refresh = "gr",
            open = "<M-CR>",
          },
          layout = {
            position = "right", -- | top | left | right | horizontal | vertical
            ratio = 0.4,
          },
        },
        suggestion = {
          enabled = true,
          auto_trigger = true,
          hide_during_completion = false,
          debounce = 200,
          keymap = {
            -- accept = "<M-l>",
            -- accept_word = false,
            -- accept_line = false,
            -- next = "<M-]>",
            -- prev = "<M-[>",
            -- dismiss = "<C-]>",
          },
        },
        filetypes = {
          yaml = false,
          markdown = false,
          help = false,
          gitcommit = false,
          gitrebase = false,
          hgcommit = false,
          svn = false,
          cvs = false,
          ["."] = false,
        },
        copilot_node_command = "node", -- Node.js version must be > 18.x
        server_opts_overrides = {},
      }
      local keymap = vim.keymap
      keymap.amend = require "keymap-amend"
      local suggestion = require "copilot.suggestion"
      local client = require "copilot.client"
      local amend_if_running = function(lhs, callback)
        keymap.amend("i", lhs, function(original)
          if not client.is_disabled() then
            callback()
          else
            original()
          end
        end)
      end
      amend_if_running("<A-f>", suggestion.accept)
      amend_if_running("<A-a>", suggestion.accept_line)
      amend_if_running("<A-w>", suggestion.accept_word)
      amend_if_running("<A-r>", suggestion.next)
      amend_if_running("<A-c>", suggestion.dismiss)
    end,
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
  },

  {
    "kiddos/gemini.nvim",
    enabled = false,
    build = { "pip install -r requirements.txt", ":UpdateRemotePlugins" },
    config = function() require("gemini").setup() end,
  },

  {
    "yetone/avante.nvim",
    -- event = "VeryLazy",
    -- lazy = false,
    opts = {
      ---@alias Provider "claude" | "openai" | "azure" | "gemini" | "cohere" | "copilot" | string
      provider = "claude", -- Recommend using Claude
      auto_suggestions_provider = "claude", -- Since auto-suggestions are a high-frequency operation and therefore expensive, it is recommended to specify an inexpensive provider or even a free provider: copilot
      claude = {
        endpoint = "https://api.anthropic.com",
        model = "claude-3-5-sonnet-20241022",
        temperature = 0,
        max_tokens = 4096,
      },
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        euto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
      },
      windows = {
        ---@type "right" | "left" | "top" | "bottom"
        position = "right", -- the position of the sidebar
        wrap = true, -- similar to vim.o.wrap
        width = 40, -- default % based on available width
        sidebar_header = {
          enabled = true, -- true, false to enable/disable the header
          align = "center", -- left, center, right for title
          rounded = true,
        },
        input = {
          prefix = "> ",
          height = 10, -- Height of the input window in vertical layout
        },
        edit = {
          border = "rounded",
          start_insert = true, -- Start insert mode when opening the edit window
        },
        ask = {
          floating = false, -- Open the 'AvanteAsk' prompt in a floating window
          start_insert = true, -- Start insert mode when opening the ask window
          border = "rounded",
          ---@type "ours" | "theirs"
          focus_on_apply = "ours", -- which diff to focus after applying
        },
      },
    },
    build = "make",
    keys = {
      { "<leader>aa", function() require("avante.api").ask() end, desc = "avante: ask", mode = { "n", "v" } },
      { "<leader>at", function() require("avante.api").toggle() end, desc = "avante: toggle", mode = { "n", "v" } },
      { "<leader>ar", function() require("avante.api").refresh() end, desc = "avante: refresh" },
      { "<leader>ae", function() require("avante.api").edit() end, desc = "avante: edit", mode = "v" },
    },
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to setup it properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
