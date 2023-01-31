local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'ellisonleao/gruvbox.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'bluz71/vim-nightfly-colors'
  use 'vim-test/vim-test'
  use 'lewis6991/gitsigns.nvim'
  use 'preservim/vimux'
  use 'christoomey/vim-tmux-navigator'
  use 'tpope/vim-fugitive'
  -- completion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'
  use "rafamadriz/friendly-snippets"

  --use "github/copilot.vim"

--  use {
--    "williamboman/mason.nvim",
--    "williamboman/mason-lspconfig.nvim",
--    "neovim/nvim-lspconfig",
--    "glepnir/lspsaga.nvim",
--  }

  use {'neoclide/coc.nvim', branch = 'release', run = 'yarn install --frozen-lockfile'}

  use {
	  'nvim-telescope/telescope.nvim',
	  tag = '*',
	  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end,
    requires = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  })
  use({
    'nvim-treesitter/nvim-treesitter-textobjects',
    tag = '*',
    config = function()
      require'nvim-treesitter.configs'.setup({})
    end
  })

  use {
    'numToStr/Comment.nvim',
    config = function()
        require('Comment').setup({
          ---Add a space b/w comment and the line
          padding = true,
          ---Whether the cursor should stay at its position
          sticky = true,
          ---Lines to be ignored while (un)comment
          ignore = nil,
          ---LHS of toggle mappings in NORMAL mode
          toggler = {
              ---Line-comment toggle keymap
              line = 'cc',
              ---Block-comment toggle keymap
              block = 'bc',
          },
          ---LHS of operator-pending mappings in NORMAL and VISUAL mode
          opleader = {
              ---Line-comment keymap
              line = 'gc',
              ---Block-comment keymap
              block = 'gb',
          },
          ---LHS of extra mappings
          extra = {
              ---Add comment on the line above
              above = 'gcO',
              ---Add comment on the line below
              below = 'gco',
              ---Add comment at the end of line
              eol = 'gcA',
          },
          ---Enable keybindings
          ---NOTE: If given `false` then the plugin won't create any mappings
          mappings = {
              ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
              basic = true,
              ---Extra mapping; `gco`, `gcO`, `gcA`
              extra = true,
          },
          ---Function to call before (un)comment
          pre_hook = nil,
          ---Function to call after (un)comment
          post_hook = nil,
        })
    end
  }

  --use {
  --"folke/which-key.nvim",
  --config = function()
  --  vim.o.timeout = true
  --  vim.o.timeoutlen = 300
  --  require("which-key").setup {
  --    -- your configuration comes here
  --    -- or leave it empty to use the default settings
  --    -- refer to the configuration section below
  --  }
  --end
  -- }

  use 'ThePrimeagen/harpoon'
  use('mbbill/undotree')

  use { "sitiom/nvim-numbertoggle" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
