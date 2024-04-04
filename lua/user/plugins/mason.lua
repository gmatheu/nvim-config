-- customize mason plugins
return {
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = { "lua_ls" },
      -- Whether servers that are set up (via lspconfig) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Servers are not automatically installed.
      --   - true: All servers set up via lspconfig are automatically installed.
      --   - { exclude: string[] }: All servers set up via lspconfig, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }
      automatic_installation = true,
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = { "prettier", "stylua" },
      -- Run `require("null-ls").setup`.
      -- Will automatically install masons tools based on selected sources in `null-ls`.
      -- Can also be an exclusion list.
      -- Example: `automatic_installation = { exclude = { "rust_analyzer", "solargraph" } }`
      automatic_installation = true,
      -- Whether sources that are installed in mason should be automatically set up in null-ls.
      -- Removes the need to set up null-ls manually.
      -- Can either be:
      -- 	- false: Null-ls is not automatically registered.
      -- 	- true: Null-ls is automatically registered.
      -- 	- { types = { SOURCE_NAME = {TYPES} } }. Allows overriding default configuration.
      -- 	Ex: { types = { eslint_d = {'formatting'} } }
      automatic_setup = true,
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = { "python", "typescript", "javascript" },
      -- NOTE: this is left here for future porting in case needed
      -- Whether adapters that are set up (via dap) should be automatically installed if they're not already installed.
      -- This setting has no relation with the `ensure_installed` setting.
      -- Can either be:
      --   - false: Daps are not automatically installed.
      --   - true: All adapters set up via dap are automatically installed.
      --   - { exclude: string[] }: All adapters set up via mason-nvim-dap, except the ones provided in the list, are automatically installed.
      --       Example: automatic_installation = { exclude = { "python", "delve" } }
      automatic_installation = true,
      -- Whether adapters that are installed in mason should be automatically set up in dap.
      -- Removes the need to set up dap manually.
      -- See mappings.adapters and mappings.configurations for settings.
      -- Must invoke when set to true: `require 'mason-nvim-dap'.setup_handlers()`
      -- Can either be:
      -- 	- false: Dap is not automatically configured.
      -- 	- true: Dap is automatically configured.
      -- 	- {adapters: {ADAPTER: {}, }, configurations: {configuration: {}, }, filetypes: {filetype: {}, }}. Allows overriding default configuration.
      -- 	- {adapters: function(default), configurations: function(default), filetypes: function(default), }. Allows modifying the default configuration passed in via function.
      automatic_setup = true,
    },
  },
}
