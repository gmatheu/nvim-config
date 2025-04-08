-- AstroUI provides the basis for configuring the AstroNvim User Interface
-- Configuration documentation can be found with `:h astroui`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

---@type LazySpec
return {
  {
    "AstroNvim/astroui",
    ---@type AstroUIOpts
    opts = {
      colorscheme = "astrodark",
      -- colorscheme = "astrodark",
      -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
      highlights = {
        init = function()
          local get_hlgroup = require("astroui").get_hlgroup
          -- get highlights from highlight groups
          local normal = get_hlgroup "Normal"
          local fg, bg = normal.fg, normal.bg
          local bg_alt = get_hlgroup("Visual").bg
          local green = get_hlgroup("String").fg
          local red = get_hlgroup("Error").fg

          return { -- this table overrides highlights in all themes
            TelescopeBorder = { fg = bg_alt, bg = bg },
            TelescopeNormal = { bg = bg },
            -- TelescopePreviewBorder = { fg = bg, bg = bg },
            TelescopePreviewNormal = { bg = bg },
            TelescopePreviewTitle = { fg = bg, bg = green },
            -- TelescopePromptBorder = { fg = bg_alt, bg = bg_alt },
            -- TelescopePromptNormal = { fg = fg, bg = bg_alt },
            -- TelescopePromptPrefix = { fg = red, bg = bg_alt },
            TelescopePromptTitle = { fg = bg, bg = red },
            -- TelescopeResultsBorder = { fg = bg, bg = bg },
            TelescopeResultsNormal = { bg = bg },
            -- TelescopeResultsTitle = { fg = bg, bg = bg },
            StatusLine = {
              bg = "#572e33",
            },
            LineNr = {
              fg = "yellow",
            },
            LeapMatch = {
              fg = "#fb4934",
            },
            LeapLabelPrimary = {
              fg = "#fb4934",
              bg = "#572e33",
              underline = true,
            },
          }
        end,
        astrotheme = { -- a table of overrides/changes when applying the astrotheme theme
          -- Normal = { bg = "#000000" },
        },
      },
      status = {
        -- Configure attributes of components defined in the `status` API. Check the AstroNvim documentation for a complete list of color names, this applies to colors that have `_fg` and/or `_bg` names with the suffix removed (ex. `git_branch_fg` as attributes from `git_branch`).
        attributes = {
          git_branch = { bold = true },
        },
        -- Configure colors of components defined in the `status` API. Check the AstroNvim documentation for a complete list of color names.
        colors = {
          git_branch_fg = "#ABCDEF",
        },
        -- Configure which icons that are highlighted based on context
        icon_highlights = {
          -- enable or disable breadcrumb icon highlighting
          breadcrumbs = false,
          -- Enable or disable the highlighting of filetype icons both in the statusline and tabline
          file_icon = {
            tabline = function(self) return self.is_active or self.is_visible end,
            statusline = true,
          },
        },
      },
      -- Icons can be configured throughout the interface
      icons = {
        -- configure the loading of the lsp in the status line
        LSPLoading1 = "⠋",
        LSPLoading2 = "⠙",
        LSPLoading3 = "⠹",
        LSPLoading4 = "⠸",
        LSPLoading5 = "⠼",
        LSPLoading6 = "⠴",
        LSPLoading7 = "⠦",
        LSPLoading8 = "⠧",
        LSPLoading9 = "⠇",
        LSPLoading10 = "⠏",
      },
    },
    dependencies = {
      {
        "folke/tokyonight.nvim",
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
      },
      {
        "projekt0n/github-nvim-theme",
        enabled = false,
        lazy = false, -- make sure we load this during startup if it is your main colorscheme
        priority = 1000, -- make sure to load this before all the other start plugins
        config = function() require("github-theme").setup() end,
      },
    },
  },

  {
    "echasnovski/mini.icons",
    version = false,
    config = function()
      require("mini.icons").setup {
        {
          style = "glyph",

          default = {},
          directory = {},
          extension = {},
          file = {},
          filetype = {},
          lsp = {
            Codeium = "",
            Supermaven = "",
          },
          os = {},

          use_file_extension = function(ext, file) return true end,
        },
      }
    end,
  },
}
