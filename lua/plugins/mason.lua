---@type LazySpec
return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    config = function()
      require("mason-tool-installer").setup {

        ensure_installed = {
          { "bash-language-server", auto_update = true },
          "lua-language-server",
          "vim-language-server",
          "stylua",
          "shellcheck",
          "editorconfig-checker",
          "impl",
          "json-to-struct",
          "luacheck",
          "misspell",
          "revive",
          "shellcheck",
          "shfmt",
          "staticcheck",

          "typescript-language-server",
          "sqlls",
          "dockerfile-language-server",
          "docker-compose-language-service",
          "dotenv-linter",

          "prettier",
          "stylua",
          "ruff",

          "debugpy",
          "js-debug-adapter",
          "java-debug-adapter",
        },
        auto_update = false,
        run_on_start = true,
        start_delay = 3000, -- 3 second delay
        debounce_hours = 0, -- at least 5 hours between attempts to install/update
        integrations = {
          ["mason-lspconfig"] = true,
          ["mason-null-ls"] = true,
          ["mason-nvim-dap"] = true,
        },
      }
    end,
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
      "jay-babu/mason-null-ls.nvim",
      "jay-babu/mason-nvim-dap.nvim",
    },
  },
}
