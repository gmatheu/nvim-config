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
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
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
    "ThePrimeagen/refactoring.nvim",
    lazy = true,
    config = function(_, _) require("refactoring").setup {} end,
  },

  {
    "ThePrimeagen/harpoon",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = { "Harpoon" },
    keys = {
      { "<leader>a" .. "a", function() require("harpoon.mark").add_file() end, desc = "Add file" },
      { "<leader>a" .. "e", function() require("harpoon.ui").toggle_quick_menu() end, desc = "Toggle quick menu" },
      {
        "<C-x>",
        function()
          vim.ui.input({ prompt = "Harpoon mark index: " }, function(input)
            local num = tonumber(input)
            if num then require("harpoon.ui").nav_file(num) end
          end)
        end,
        desc = "Goto index of mark",
      },
      { "<C-p>", function() require("harpoon.ui").nav_prev() end, desc = "Goto previous mark" },
      { "<C-n>", function() require("harpoon.ui").nav_next() end, desc = "Goto next mark" },
      { "<leader>a1", function() require("harpoon.ui").nav_file(1) end, desc = "Goto mark 1" },
      { "<leader>a2", function() require("harpoon.ui").nav_file(2) end, desc = "Goto mark 2" },
      { "<leader>a3", function() require("harpoon.ui").nav_file(3) end, desc = "Goto mark 3" },
      { "<leader>a4", function() require("harpoon.ui").nav_file(4) end, desc = "Goto mark 4" },
      { "<leader>a " .. "m", "<cmd>Telescope harpoon marks<CR>", desc = "Show marks in Telescope" },
      --{
      --  prefix .. "t",
      --  function()
      --    vim.ui.input({ prompt = term_string .. " window number: " }, function(input)
      --      local num = tonumber(input)
      --      if num then require("harpoon." .. term_string).gotoTerminal(num) end
      --    end)
      --  end,
      --  desc = "Go to " .. term_string .. " window",
      --},
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
    cmd = { "TroubleToggle", "Trouble" },
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
    keys = { "<space>m", "<space>j", "<space>s" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesj").setup { --[[ your config ]]
      }
    end,
  },

  {
    "projekt0n/github-nvim-theme",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      require("github-theme").setup {}

      vim.cmd "colorscheme github_dark"
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
    keys = {
      { "<A-j>", function() require("tsht").nodes() end, desc = "Expand hop selection" },
    },
  },

  {
    "stevearc/overseer.nvim",
    cmd = { "OverseerToggle", "OverseerRun", "OverseerQuickAction" },
    opts = {},
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    keys = {
      { "<space>fb", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>", desc = "Open file browser" },
    },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      }
      require("telescope").load_extension "file_browser"
    end,
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
    "mickael-menu/zk-nvim",
    cmd = { "ZkIndex", "ZkNew" },
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
    cmd = { "MoveLine", "MoveBlock"}
  },
}
