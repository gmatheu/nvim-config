local overrides = require "custom.plugins.overrides"

---@type {[PluginName]: PluginConfig|false}
local plugins = {

  -- ["goolord/alpha-nvim"] = { disable = false } -- enables dashboard

  -- Override plugin definition options
  ["neovim/nvim-lspconfig"] = {
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.plugins.lspconfig"
    end,
  },

  -- overrde plugin configs
  ["nvim-treesitter/nvim-treesitter"] = {
    override_options = overrides.treesitter,
  },

  ["williamboman/mason.nvim"] = {
    override_options = overrides.mason,
  },

  ["nvim-tree/nvim-tree.lua"] = {
    override_options = overrides.nvimtree,
  },

  -- Install a plugin
  ["max397574/better-escape.nvim"] = {
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

  -- code formatting, linting etc
  ["jose-elias-alvarez/null-ls.nvim"] = {
    after = "nvim-lspconfig",
    config = function()
      require "custom.plugins.null-ls"
    end,
  },

  -- remove plugin
  -- ["hrsh7th/cmp-path"] = false,
  --
  ["nvim-telescope/telescope.nvim"] = {
    override_options = function()
      return {
        defaults = {
          layout_config = {
            horizontal = {
              prompt_position = "bottom",
              preview_width = 0.55,
              results_width = 0.8,
            },
            vertical = {
              mirror = false,
            },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
        },
      }
    end,
  },

  ["folke/which-key.nvim"] = {
    -- disable = true,
    module = "which-key",
    keys = { "<leader>", '"', "'", "`" },
    config = function()
      require "plugins.configs.whichkey"
    end,
    setup = function()
      require("core.utils").load_mappings "whichkey"
    end,
  },

  ["sitiom/nvim-numbertoggle"] = {},
  ["mbbill/undotree"] = {},
  ["tpope/vim-fugitive"] = {},
  ["theprimeagen/harpoon"] = {},
  ["kylechui/nvim-surround"] = {
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  ["nvim-treesitter/nvim-treesitter-textobjects"] = {},

  ["nvim-neotest/neotest-python"] = {},
  ["nvim-neotest/neotest-plenary"] = {},
  ["nvim-neotest/neotest-vim-test"] = {},
  ["nvim-neotest/neotest"] = {
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-python" {
            dap = { justMyCode = false },
          },
          require "neotest-plenary",
          require "neotest-vim-test" {
            ignore_file_types = { "python", "vim", "lua" },
          },
        },
      }
    end,
  },
  ["antoinemadec/FixCursorHold.nvim"] = {},
  ["tzachar/local-highlight.nvim"] = {
      setup = function()
        require('local-highlight').setup({
            file_types = {'python', 'cpp', 'tsx', 'lua'},
            hlgroup = 'TSDefinitionUsage',
        })
      end
  }
}

return plugins
