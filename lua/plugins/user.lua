---@type LazySpec
return {
  -- {
  --   "navarasu/onedark.nvim",
  --   config = function()
  --     require("onedark").setup {
  --       style = "warmer",
  --     }
  --     require("onedark").load()
  --   end,
  -- },
  -- { "ellisonleao/gruvbox.nvim", lazy = false },
  -- { "luisiacc/gruvbox-baby", lazy = false },
  { "mbbill/undotree", lazy = true, cmd = { "UndotreeToggle" } },

  {
    "kylechui/nvim-surround",
    enabled = true,
    event = "VeryLazy",
    config = function() require("nvim-surround").setup() end,
  },

  { "tpope/vim-fugitive", cmd = { "Git" } },

  {
    "filipdutescu/renamer.nvim",
    lazy = true,
    keys = { { "<leader>ra", mode = "n" }, { "<F2>", mode = "n" }, { "<leader>ra", mode = "v" } },
    config = function(_, __)
      local mappings_utils = require "renamer.mappings.utils"
      require("renamer").setup {
        -- The popup title, shown if `border` is true
        title = "Rename",
        -- The padding around the popup content
        padding = {
          top = 0,
          left = 0,
          bottom = 0,
          right = 0,
        },
        -- The minimum width of the popup
        min_width = 15,
        -- The maximum width of the popup
        max_width = 45,
        -- Whether or not to shown a border around the popup
        border = true,
        -- The characters which make up the border
        border_chars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
        -- Whether or not to highlight the current word references through LSP
        show_refs = true,
        -- Whether or not to add resulting changes to the quickfix list
        with_qf_list = true,
        -- Whether or not to enter the new name through the UI or Neovim's `input`
        -- prompt
        with_popup = true,
        -- The keymaps available while in the `renamer` buffer. The example below
        -- overrides the default values, but you can add others as well.
        mappings = {
          ["<c-i>"] = mappings_utils.set_cursor_to_start,
          ["<c-a>"] = mappings_utils.set_cursor_to_end,
          ["<c-e>"] = mappings_utils.set_cursor_to_word_end,
          ["<c-b>"] = mappings_utils.set_cursor_to_word_start,
          ["<c-c>"] = mappings_utils.clear_line,
          ["<c-u>"] = mappings_utils.undo,
          ["<c-r>"] = mappings_utils.redo,
        },
        -- Custom handler to be run after successfully renaming the word. Receives
        -- the LSP 'textDocument/rename' raw response as its parameter.
        handler = nil,
      }
    end,
  },

  {
    "ThePrimeagen/harpoon",
    enabled = false,
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function() require("harpoon"):setup {} end,
    cmd = { "Harpoon" },
    keys = {
      { "<leader>A", function() require("harpoon"):list():append() end, desc = "harpoon file" },
      { "<leader>a" .. "a", function() require("harpoon"):list():append() end, desc = "harpoon file" },
      {
        "<leader>a" .. "e",
        function()
          local harpoon = require "harpoon"
          harpoon.ui:toggle_quick_menu(harpoon:list())
        end,
        desc = "harpoon quick menu",
      },
      { "<leader>a" .. "r", function() require("harpoon"):list():remove() end, desc = "remove file harpoon" },
      { "<leader>a" .. "c", function() require("harpoon"):list():clear() end, desc = "clear all files harpoon" },
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "harpoon to file 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "harpoon to file 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "harpoon to file 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "harpoon to file 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "harpoon to file 5" },
    },
  },

  {
    "windwp/nvim-spectre",
    enabled = false,
    lazy = true,
    keys = {},
    cmd = { "Spectre" },
    config = function()
      require("spectre").setup {
        highlight = {
          ui = "String",
          search = "DiffChange",
          replace = "DiffDelete",
        },
      }
    end,
  },
  {
    "AckslD/muren.nvim",
    cmd = { "MurenToggle" },
    config = function()
      require("muren").setup {
        -- general
        create_commands = true,
        filetype_in_preview = true,
        -- default togglable options
        two_step = false,
        all_on_line = true,
        preview = true,
        cwd = false,
        files = "**/*",
        -- keymaps
        keys = {
          close = "q",
          toggle_side = "<Tab>",
          toggle_options_focus = "<C-s>",
          toggle_option_under_cursor = "<CR>",
          scroll_preview_up = "<Up>",
          scroll_preview_down = "<Down>",
          do_replace = "<CR>",
          -- NOTE these are not guaranteed to work, what they do is just apply `:normal! u` vs :normal! <C-r>`
          -- on the last affected buffers so if you do some edit in these buffers in the meantime it won't do the correct thing
          do_undo = "<localleader>u",
          do_redo = "<localleader>r",
        },
        -- ui sizes
        patterns_width = 60,
        patterns_height = 20,
        options_width = 20,
        preview_height = 16,
        -- options order in ui
        order = {
          "buffer",
          "dir",
          "files",
          "two_step",
          "all_on_line",
          "preview",
        },
        -- highlights used for options ui
        hl = {
          options = {
            on = "@string",
            off = "@variable.builtin",
          },
          preview = {
            cwd = {
              path = "Comment",
              lnum = "Number",
            },
          },
        },
      }
    end,
  },

  {
    "otavioschwanck/tmux-awesome-manager.nvim",
    event = "VeryLazy",
    config = function()
      require("tmux-awesome-manager").setup {
        per_project_commands = {
          -- Configure your per project servers with
          -- project name = { { cmd, name } }
          api = { { cmd = "rails server", name = "Rails Server" } },
          front = { { cmd = "yarn dev", name = "react server" } },
        },
        -- session_name = 'Neovim Terminals',
        -- use_icon = false, -- use prefix icon
        -- icon = ' ', -- Prefix icon to use
        -- project_open_as = 'window', -- Open per_project_commands as.  Default: separated_session
        -- default_size = '30%', -- on panes, the default size
        -- open_new_as = 'window' -- open new command as.  options: pane, window, separated_session.
      }
    end,
  },

  {
    "chentoast/marks.nvim",
    event = "VeryLazy",
    config = function()
      require("marks").setup {
        -- whether to map keybinds or not. default true
        default_mappings = true,
        -- which builtin marks to show. default {}
        builtin_marks = { ".", "<", ">", "^" },
        -- whether movements cycle back to the beginning/end of buffer. default true
        cyclic = true,
        -- whether the shada file is updated after modifying uppercase marks. default false
        force_write_shada = false,
        -- how often (in ms) to redraw signs/recompute mark positions.
        -- higher values will have better performance but may cause visual lag,
        -- while lower values may cause performance penalties. default 150.
        refresh_interval = 250,
        -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
        -- marks, and bookmarks.
        -- can be either a table with all/none of the keys, or a single number, in which case
        -- the priority applies to all marks.
        -- default 10.
        sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
        -- disables mark tracking for specific filetypes. default {}
        excluded_filetypes = {},
        -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
        -- sign/virttext. Bookmarks can be used to group together positions and quickly move
        -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
        -- default virt_text is "".
        bookmark_0 = {
          sign = "⚑",
          virt_text = "hello world",
          -- explicitly prompt for a virtual line annotation when setting a bookmark from this group.
          -- defaults to false.
          annotate = false,
        },
        mappings = {},
      }
    end,
  },

  -- { "echasnovski/mini.nvim", version = false },
  {
    "folke/trouble.nvim",
    cmd = { "Trouble" },
    keys = {
      {
        "<leader>tt",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>tf",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>tL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>tQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    opts = {
      use_diagnostic_signs = true,
      action_keys = {
        close = { "q", "<esc>" },
        cancel = "<c-e>",
      },
    },
  },
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      if not opts.bottom then opts.bottom = {} end
      table.insert(opts.bottom, "Trouble")
    end,
  },

  {
    "ggandor/leap.nvim",
    keys = {
      { "s", mode = { "n", "x", "o" }, desc = "Leap forward to" },
      { "S", mode = { "n", "x", "o" }, desc = "Leap backward to" },
      { "gs", mode = { "n", "x", "o" }, desc = "Leap from windows" },
    },
    config = function(_, opts)
      local leap = require "leap"
      for k, v in pairs(opts) do
        leap.opts[k] = v
      end
      leap.add_default_mappings(true)
      vim.keymap.del({ "x", "o" }, "x")
      vim.keymap.del({ "x", "o" }, "X")
    end,
  },
  { "tpope/vim-repeat", event = "VeryLazy" },

  {
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = { delay = 500 },
    config = function(_, opts)
      require("illuminate").configure(opts)

      local function map(key, dir, buffer)
        vim.keymap.set(
          "n",
          key,
          function() require("illuminate")["goto_" .. dir .. "_reference"](false) end,
          { desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference", buffer = buffer }
        )
      end

      map("]]", "next")
      map("[[", "prev")

      -- also set it after loading ftplugins, since a lot overwrite [[ and ]]
      vim.api.nvim_create_autocmd("FileType", {
        callback = function()
          local buffer = vim.api.nvim_get_current_buf()
          map("]]", "next", buffer)
          map("[[", "prev", buffer)
        end,
      })
    end,
    keys = {
      { "]]", desc = "Next Reference" },
      { "[[", desc = "Prev Reference" },
    },
  },

  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
  },

  {
    "Wansmer/treesj",
    keys = {
      {
        "<space>m",
        function() require("treesj").toggle() end,
        desc = "Toggle Split-Join code block with autodetect (treesj)",
      },
      { "<space>s", function() require("treesj").split() end, desc = "Split code block (treesj)" },
      { "<space>j", function() require("treesj").join() end, desc = "Join code block (treesj)" },
    },
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup {
        dot_repeat = true,
        use_default_keymaps = true,
      }
    end,
  },

  {
    "LeonGr/neovim-expand-selection",
    cmd = { "ExpSel" },
    keys = {
      { "<A-j>", function() require("expand-selection").expsel() end, desc = "Expand selection" },
    },
  },

  {
    "mfussenegger/nvim-treehopper",
    enabled = false,
    keys = {
      { "<A-j>", function() require("tsht").nodes() end, desc = "Expand hop selection" },
    },
  },

  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerToggle", "OverseerRun", "OverseerQuickAction", "Make" },
    opts = {},
    config = function(_, opts)
      require("overseer").setup(opts)

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local overseer = require "overseer"
        local tasks = overseer.list_tasks { recent_first = true }
        if vim.tbl_isempty(tasks) then
          vim.notify("No tasks found", vim.log.levels.WARN)
        else
          overseer.run_action(tasks[1], "restart")
        end
      end, {})

      vim.api.nvim_create_user_command("Make", function(params)
        -- Insert args at the '$*' in the makeprg
        local cmd, num_subs = vim.o.makeprg:gsub("%$%*", params.args)
        if num_subs == 0 then cmd = cmd .. " " .. params.args end
        local task = require("overseer").new_task {
          cmd = vim.fn.expandcmd(cmd),
          components = {
            { "on_output_quickfix", open = not params.bang, open_height = 8 },
            "default",
          },
        }
        task:start()
      end, {
        desc = "Run your makeprg as an Overseer task",
        nargs = "*",
        bang = true,
      })
    end,
    keys = {
      { "<Leader>qr", "<cmd>OverseerRun<CR>", desc = "Run tasks [overseer]" },
      { "<Leader>qt", "<cmd>OverseerToggle<CR>", desc = "Overseer toggle [overseer]" },
      { "<Leader>qa", "<cmd>OverseerQuickAction<CR>", desc = "Quick actions [overseer]" },
    },
  },
  {
    "mawkler/modicator.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    config = function() require("modicator").setup() end,
  },

  -- Maybe https://github.com/ggandor/flit.nvim
  {
    "ggandor/flit.nvim",
    event = "VeryLazy",
    config = function()
      require("flit").setup {
        keys = { f = "f", F = "F", t = "t", T = "T" },
        -- A string like "nv", "nvo", "o", etc.
        labeled_modes = "v",
        multiline = false,
        opts = {},
      }
    end,
  },

  {
    "mickael-menu/zk-nvim",
    cmd = { "ZkIndex", "ZkNew", "ZkNotes", "ZkLinks", "ZkTags" },
    keys = {
      { "<Leader>zl", "<cmd>ZkLinks<CR>", desc = "List notes links (zk)" },
      { "<Leader>zt", "<cmd>ZkTags<CR>", desc = "List tags (zk)" },
      { "<Leader>zn", "<cmd>ZkNew<CR>", desc = "New note (zk)" },
      { "<Leader>zo", "<Cmd>ZkNotes { sort = { 'modified' } }<CR>", desc = "Open Notes (zk)" },
    },
    config = function()
      require("zk").setup {
        -- See Setup section below
        picker = "telescope",

        lsp = {
          -- `config` is passed to `vim.lsp.start_client(config)`
          config = {
            cmd = { "zk", "lsp" },
            name = "zk",
            -- on_attach = ...
            -- etc, see `:h vim.lsp.start_client()`
          },

          -- automatically attach buffers in a zk notebook that match the given filetypes
          auto_attach = {
            enabled = true,
            filetypes = { "markdown" },
          },
        },
      }
    end,
  },
  {
    "fedepujol/move.nvim",
    cmd = { "MoveLine", "MoveBlock" },
  },

  {
    "scheisa/relpointers.nvim",
    event = "VeryLazy",
    config = function()
      require("relpointers").setup {
        amount = 1,
        distance = 10,

        hl_properties = { underline = true },

        pointer_style = "line region",

        white_space_rendering = "\t",

        virtual_pointer_position = -4,
        virtual_pointer_text = "@",

        enable_autocmd = true,
        autocmd_pattern = "*",
      }
    end,
  },

  {
    "cappyzawa/trim.nvim",
    opts = {
      trim_on_write = true,
      trim_trailing = true,
      trim_last_line = true,
      trim_first_line = true,
    },
    event = "BufWritePre",
    cmd = { "Trim", "TrimToggle" },
  },

  {
    "jokajak/keyseer.nvim",
    version = false,
    config = function() require("keyseer").setup() end,
    cmd = { "KeySeer" },
  },

  {
    "00sapo/visual.nvim",
    opts = { treesitter_textobjects = true },
    dependencies = { "nvim-treesitter", "nvim-treesitter-textobjects" },
    config = function()
      require("visual").setup {
        serendipity = {
          highlight = "guibg=LightCyan guifg=none",
        },
      }
    end,
    enabled = false,
    event = "VeryLazy", -- this is for making sure our keymaps are applied after the others: we call the previous mapppings, but other plugins/configs usually not!
  },

  {
    "rmagatti/auto-session",
    enabled = false,
    lazy = false,
    config = function()
      local opts = {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
        auto_session_use_git_branch = false,
        auto_session_enable_last_session = true,

        -- ⚠️ This will only work if Telescope.nvim is installed
        -- The following are already the default values, no need to provide them if these are already the settings you want.
        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
      }
      require("auto-session").setup(opts)
    end,
  },
  {
    "yorickpeterse/nvim-window",
    keys = {
      { "<leader>w" .. "w", function() require("nvim-window").pick() end, desc = "Show Windows picker [nvim-window]" },
    },
    config = function()
      require("nvim-window").setup {
        -- The characters available for hinting windows.
        chars = {
          "a",
          "b",
          "c",
          "d",
          "e",
          "f",
        },

        -- A group to use for overwriting the Normal highlight group in the floating
        -- window. This can be used to change the background color.
        normal_hl = "Normal",

        -- The highlight group to apply to the line that contains the hint characters.
        -- This is used to make them stand out more.
        hint_hl = "Bold",

        -- The border style to use for the floating window.
        border = "single",
      }
    end,
  },
  {
    "nvim-focus/focus.nvim",
    version = false,
    cmd = { "FocusSplitNicely", "FocusToggle", "FocusSplitRight", "FocusSplitDown" },
    keys = {
      { "<leader>w" .. "n", function() require("focus").split_nicely() end, desc = "Split nicely [focus]" },
    },
    config = function()
      require("focus").setup {
        enable = true, -- Enable module
        commands = true, -- Create Focus commands
        autoresize = {
          enable = true, -- Enable or disable auto-resizing of splits
          width = 0, -- Force width for the focused window
          height = 0, -- Force height for the focused window
          minwidth = 0, -- Force minimum width for the unfocused window
          minheight = 0, -- Force minimum height for the unfocused window
          height_quickfix = 10, -- Set the height of quickfix panel
        },
        split = {
          bufnew = false, -- Create blank buffer for new split windows
          tmux = false, -- Create tmux splits instead of neovim splits
        },
        ui = {
          number = false, -- Display line numbers in the focussed window only
          relativenumber = false, -- Display relative line numbers in the focussed window only
          hybridnumber = false, -- Display hybrid line numbers in the focussed window only
          absolutenumber_unfocussed = false, -- Preserve absolute numbers in the unfocussed windows

          cursorline = true, -- Display a cursorline in the focussed window only
          cursorcolumn = false, -- Display cursorcolumn in the focussed window only
          colorcolumn = {
            enable = false, -- Display colorcolumn in the foccused window only
            list = "+1", -- Set the comma-saperated list for the colorcolumn
          },
          signcolumn = true, -- Display signcolumn in the focussed window only
          winhighlight = false, -- Auto highlighting for focussed/unfocussed windows
        },
      }
    end,
  },

  {
    "mrquantumcodes/bufferchad.nvim",
    keys = {
      {
        "<leader>b" .. "bl",
        function() require("bufferchad").BufferChadListBuffers() end,
        desc = "List buffers [bufferchad]",
      },
      {
        "<leader>b" .. "m",
        function() require("bufferchad").OpenBufferWindow(require("bufferchad").marked, "Marked Buffers") end,
        desc = "Marked Buffers [bufferchad]",
      },
    },
    config = function()
      require("bufferchad").setup {
        -- mapping = "<leader>bb", -- Map any key, or set to NONE to disable key mapping
        -- mark_mapping = "<leader>bm", -- The keybinding to display just the marked buffers
        order = "LAST_USED_UP", -- LAST_USED_UP (default)/ASCENDING/DESCENDING/REGULAR
        style = "modern", -- default, modern (requires dressing.nvim and nui.nvim), telescope (requires telescope.nvim)
        close_mapping = "<Esc><Esc>", -- only for the default style window.
      }
    end,

    -- uncomment if you want fuzzy search with telescope and a modern ui

    -- dependencies = {
    --    {"nvim-lua/plenary.nvim"},
    --    {"MunifTanjim/nui.nvim"},
    --    {"stevearc/dressing.nvim"},
    --    {"nvim-telescope/telescope.nvim"} -- needed for fuzzy search, but should work fine even without it
    -- }
  },

  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("hardtime").setup()
      if os.getenv("HARDTIME_NVIM" .. "_DEBUG") or os.getenv("ASTRONVIM" .. "_DEBUG") then
        vim.notify("Instrumentation completed", vim.log.levels.INFO, { title = "hardtime" })
      end
    end,
    opts = {
      max_count = 5,
      hint = true,
      notification = true,
      disabled_filetypes = {
        "NvimTree",
        "TelescopePrompt",
        "aerial",
        "alpha",
        "checkhealth",
        "dapui*",
        "Diffview*",
        "Dressing*",
        "help",
        "httpResult",
        "lazy",
        "lspinfo",
        "Neogit*",
        "mason",
        "neotest%-summary",
        "minifiles",
        "neo%-tree*",
        "netrw",
        "noice",
        "notify",
        "prompt",
        "qf",
        "query",
        "oil",
        "undotree",
        "trouble",
        "Trouble",
        "fugitive",
        "markdown",
        "chatgpt-input",
      },
      disabled_keys = {
        ["<Insert>"] = { "", "i" },
        ["<Home>"] = { "", "i" },
        ["<End>"] = { "", "i" },
        ["<PageUp>"] = { "", "i" },
        ["<PageDown>"] = { "", "i" },
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      scroll = {
        enabled = true,
        animate = {
          duration = { step = 10, total = 100 },
          easing = "linear",
        },
      },
      bigfile = { enabled = true },
      quickfile = { enabled = true },
      statuscolumn = { enabled = false },
      profiler = {
        enabled = true,
      },
      words = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 3000,
      },
      styles = {
        notification = {
          border = "rounded",
          zindex = 100,
          ft = "markdown",
          wo = {
            winblend = 5,
            wrap = true,
            conceallevel = 2,
            colorcolumn = "",
          },
          bo = { filetype = "snacks_notif" },
        },
        notification_history = {
          border = "rounded",
          zindex = 100,
          width = 0.8,
          height = 0.8,
          minimal = false,
          title = " Notification History ",
          title_pos = "center",
          ft = "markdown",
          bo = { filetype = "snacks_notif_history", modifiable = false },
          wo = { winhighlight = "Normal:SnacksNotifierHistory", wrap = true },
          keys = { q = "close" },
        },
        scratch = {
          enabled = true,
          width = 150,
          height = 40,
          bo = { buftype = "", buflisted = false, bufhidden = "hide", swapfile = false },
          minimal = false,
          noautocmd = false,
          -- position = "right",
          zindex = 20,
          wo = { winhighlight = "NormalFloat:Normal" },
          border = "rounded",
          title_pos = "center",
          footer_pos = "center",
        },
      },
    },
    keys = {
      -- {
      --   "]]",
      --   function() require("snacks").words.jump(vim.v.count1) end,
      --   desc = "Next Reference [snacks]",
      --   mode = { "n", "t" },
      -- },
      -- {
      --   "[[",
      --   function() require("snacks").words.jump(-vim.v.count1) end,
      --   desc = "Prev Reference [snacks]",
      --   mode = { "n", "t" },
      -- },
      { "<leader>zZ", function() require("snacks").zen() end, desc = "Toggle Zen Mode" },
      { "<leader>zz", function() require("snacks").zen.zoom() end, desc = "Toggle Zoom" },
      {
        "<leader>fn",
        function() require("snacks").notifier.show_history() end,
        desc = "Notifications history [snacks]",
      },
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "Lazygit [snacks]" },
      { "<leader>sn", function() require("snacks").scratch() end, desc = "Toggle Scratch Buffer [snacks]" },
      { "<leader>so", function() require("snacks").scratch.open() end, desc = "Toggle Scratch Buffer [snacks]" },
      { "<leader>sl", function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer [snacks]" },
      { "<leader>sp", function() require("snacks").profiler.scratch() end, desc = "Profiler Scratch Buffer [snacks]" },
      {
        "<LocalLeader>Xis",
        function() require("snacks").profiler.start() end,
        desc = "Start profiler [snacks]",
      },
      {
        "<LocalLeader>XiS",
        function() require("snacks").profiler.stop() end,
        desc = "Stop profiler [snacks]",
      },
      {
        "<LocalLeader>Xih",
        function() require("snacks").profiler.highlight() end,
        desc = "Toggle profiler highlights [snacks]",
      },
      {
        "<LocalLeader>Xic",
        function() vim.notify("Profiler status: " .. require("snacks").profiler.running()) end,
        desc = "Stop profiler [snacks]",
      },
    },
  },

  -- The orange letters indicate the unique letter in the word that you can jump to with f/F right away.
  -- Blue letters indicate that there is no unique letter in the word, but you can get to it with f/F and then a repeat with ;.
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
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup {
        chunk = {
          enable = true,
        },
        indent = {
          enable = true,
        },
        line_num = {
          enable = true,
        },
        blank = {
          enable = true,
        },
      }
    end,
  },
}
