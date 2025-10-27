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

          "copilot-language-server",

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
  {
    "williamboman/mason-lspconfig.nvim",
    opts = {
      ensure_installed = { "lua_ls" },
    },
  },
  {
    "jay-babu/mason-null-ls.nvim",
    opts = function(_, opts)
      opts.handlers = {
        -- for prettier
        prettier = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettier.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
        -- for prettierd
        prettierd = function()
          require("null-ls").register(require("null-ls").builtins.formatting.prettierd.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file ".prettierrc"
                or utils.root_has_file ".prettierrc.json"
                or utils.root_has_file ".prettierrc.js"
            end,
          })
        end,
        -- For eslint_d:
        eslint_d = function()
          require("null-ls").register(require("null-ls").builtins.diagnostics.eslint_d.with {
            condition = function(utils)
              return utils.root_has_file "package.json"
                or utils.root_has_file "eslint.config.mjs"
                or utils.root_has_file ".eslintrc.json"
                or utils.root_has_file ".eslintrc.js"
            end,
          })
        end,
      }
    end,
  },
}
