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
      -- change colorscheme
      colorscheme = "github_dark_dimmed",
      -- colorscheme = "astrodark",
      -- AstroUI allows you to easily modify highlight groups easily for any and all colorschemes
      highlights = {
        init = { -- this table overrides highlights in all themes
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
        },
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
  },
  {
    "onsails/lspkind.nvim",
    opts = function(_, opts)
      -- use codicons preset
      opts.preset = "codicons"
      opts.maxwidth = function() return math.floor(0.7 * vim.o.columns) end
      -- set some missing symbol types
      opts.symbol_map = {
        Array = "",
        Boolean = "",
        Key = "",
        Namespace = "",
        Null = "",
        Number = "",
        Object = "",
        Package = "",
        String = "",
        Codeium = "",
        Supermaven = "",
      }
    end,
  },
}
