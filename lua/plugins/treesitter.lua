return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    treesitter = {
      enabled = function(lang, bufnr) return not require("astrocore.buffer").is_large(bufnr) end,
      highlight = true,
      indent = true,
      ensure_installed = {
        "lua",
        "vim",
        "python",
        "javascript",
        "typescript",
        "java",
        "sql",
        "tsx",
        "json",
      },
      auto_install = true,
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>",
        },
      },
      textobjects = {
        select = {
          select_textobject = {
            ["af"] = { query = "@function.outer", desc = "around function" },
            ["if"] = { query = "@function.inner", desc = "around function" },
          },
        },
        move = {
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next function start" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next function end" },
          },
          goto_previous_start = {
            ["[f"] = {
              query = "@function.outer",
              desc = "Previous function start",
            },
          },
          goto_previous_end = {
            ["[F"] = {
              query = "@function.outer",
              desc = "Previous function end",
            },
          },
        },
        swap = {
          swap_next = {
            [">F"] = { query = "@function.outer", desc = "Swap next function" },
          },
          swap_previous = {
            ["<F"] = {
              query = "@function.outer",
              desc = "Swap previous function",
            },
          },
        },
      },
    },
  },
}
