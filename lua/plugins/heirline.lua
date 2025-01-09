local CodeCompanion = {
  static = {
    processing = false,
  },
  update = {
    "User",
    pattern = "CodeCompanionRequest",
    callback = function(self, args)
      self.processing = (args.data.status == "started")
      vim.cmd "redrawstatus"
    end,
  },
  {
    condition = function(self) return self.processing end,
    provider = "GPT ",
    hl = { fg = "yellow" },
  },
}
local NeoCodeium = {
  static = {
    symbols = {
      status = {
        [0] = "󰚩 ", -- Enabled
        [1] = "󱚧 ", -- Disabled Globally
        [2] = "󱙻 ", -- Disabled for Buffer
        [3] = "󱙺 ", -- Disabled for Buffer filetype
        [4] = "󱙺 ", -- Disabled for Buffer with enabled function
        [5] = "󱚠 ", -- Disabled for Buffer encoding
      },
      server_status = {
        [0] = "󰣺 ", -- Connected
        [1] = "󰣻 ", -- Connecting
        [2] = "󰣽 ", -- Disconnected
      },
    },
  },
  update = {
    "User",
    pattern = { "NeoCodeiumServer*", "NeoCodeium*{En,Dis}abled" },
    callback = function() vim.cmd.redrawstatus() end,
  },
  provider = function(self)
    local symbols = self.symbols
    local status, server_status = require("neocodeium").get_status()
    return symbols.status[status] .. symbols.server_status[server_status]
  end,
  hl = { fg = "yellow" },
}

return {
  "rebelot/heirline.nvim",
  opts = function(_, opts)
    local status = require "astroui.status"

    opts.statusline = { -- statusline
      hl = { fg = "fg", bg = "bg" },
      status.component.mode { mode_text = { padding = { left = 1, right = 1 } } },
      status.component.git_branch(),
      status.component.file_info { filetype = false, filename = {}, file_modified = {} },
      status.component.git_diff(),
      status.component.diagnostics(),
      status.component.fill(),
      status.component.cmd_info(),
      status.component.fill(),
      CodeCompanion,
      NeoCodeium,
      status.component.lsp(),
      status.component.virtual_env(),
      status.component.treesitter(),
      status.component.nav(),
      status.component.mode { surround = { separator = "right" } },
    }

    opts.winbar = { -- winbar
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      fallthrough = false,
      { -- inactive winbar
        condition = function() return not status.condition.is_active() end,
        status.component.separated_path(),
        status.component.file_info {
          file_icon = {
            hl = status.hl.file_icon "winbar",
            padding = { left = 0 },
          },
          filename = {},
          filetype = false,
          file_read_only = false,
          hl = status.hl.get_attributes("winbarnc", true),
          surround = false,
          update = "BufEnter",
        },
      },
      { -- active winbar
        status.component.breadcrumbs {
          hl = status.hl.get_attributes("winbar", true),
        },
      },
    }

    opts.statuscolumn = { -- statuscolumn
      init = function(self) self.bufnr = vim.api.nvim_get_current_buf() end,
      status.component.foldcolumn(),
      status.component.numbercolumn(),
      status.component.signcolumn(),
    }
  end,
}
