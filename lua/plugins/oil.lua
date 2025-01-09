return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  lazy = false, -- Needs to load eagerly to it can be the default file explorer
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>O"] = { function() require("oil").open() end, desc = "Open parent directory [Oil]" },
            ["<Leader>o"] = { function() require("oil").open() end, desc = "Open parent directory [Oil]" },
            ["-"] = { "<cmd>Oil --float<cr>", desc = "Open parent directory (floating) [oil]" },
          },
        },
        autocmds = {
          oil_settings = {
            {
              event = "FileType",
              desc = "Disable view saving for oil buffers",
              pattern = "oil",
              callback = function(args) vim.b[args.buf].view_activated = false end,
            },
            {
              event = "User",
              pattern = "OilActionsPost",
              desc = "Close buffers when files are deleted in Oil",
              callback = function(args)
                if args.data.err then return end
                for _, action in ipairs(args.data.actions) do
                  if action.type == "delete" then
                    local _, path = require("oil.util").parse_url(action.url)
                    local bufnr = vim.fn.bufnr(path)
                    if bufnr ~= -1 then require("astrocore.buffer").wipe(bufnr, true) end
                  end
                end
              end,
            },
          },
        },
      },
    },
    {
      "rebelot/heirline.nvim",
      optional = true,
      dependencies = { "AstroNvim/astroui", opts = { status = { winbar = { enabled = { filetype = { "^oil$" } } } } } },
      opts = function(_, opts)
        if opts.winbar then
          local status = require "astroui.status"
          table.insert(opts.winbar, 1, {
            condition = function(self) return status.condition.buffer_matches({ filetype = "^oil$" }, self.bufnr) end,
            status.component.separated_path {
              padding = { left = 2 },
              max_depth = false,
              suffix = false,
              path_func = function(self) return require("oil").get_current_dir(self.bufnr) end,
            },
          })
        end
      end,
    },
  },
  opts = function()
    local get_icon = require("astroui").get_icon
    return {
      default_file_explorer = true,
      columns = { { "icon", default_file = get_icon "DefaultFile", directory = get_icon "FolderClosed" } },
      lsp_file_methods = {
        -- Enable or disable LSP file operations
        enabled = true,
        -- Time to wait for LSP file operations to complete before skipping
        timeout_ms = 1000,
        -- Set to true to autosave buffers that are updated with LSP willRenameFiles
        -- Set to "unmodified" to only save unmodified buffers
        autosave_changes = false,
      },
    }
  end,
}
