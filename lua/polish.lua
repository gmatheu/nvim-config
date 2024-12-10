-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.filetype.add {
  pattern = {
    [".*/i3/config.d/.*.config"] = "i3config",
  },
}

function load_log_file() end

-- https://andrewcourter.substack.com/p/create-autocommands-in-neovim
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  callback = function()
    if vim.bo.filetype ~= "Avante" then vim.wo.relativenumber = true end
    if vim.bo.filetype ~= "AvanteInput" then
      vim.wo.number = true
      vim.wo.relativenumber = true
    end
    if vim.bo.filetype ~= "aerial" then vim.wo.relativenumber = true end
  end,
})

-- local keymap = vim.keymap
-- keymap.amend = require "keymap-amend"
--
-- keymap.amend("n", "k", function(original)
--   print "k key is amended!"
--   original()
-- end)
--
--
--
--
--vi
--
vim.opt.path:append { "**" }
vim.opt.wildmenu = true
vim.opt.exrc = true

local function disable_completion()
  -- Assuming you are using nvim-compe or a similar completion plugin
  -- For nvim-compe:
  vim.g.completion_enable_auto_popup = 0
  -- For nvim-cmp:
  require("cmp").setup.buffer { enabled = false }
end
vim.api.nvim_create_augroup("DisableCompletionForCodeCompanion", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "DisableCompletionForCodeCompanion",
  pattern = "codecompanion",
  callback = disable_completion,
})

-- https://github.com/monkoose/neocodeium?tab=readme-ov-file#-tips
if not vim.env.ASTRONVIM_SKIP_NEOCODEIUM then
  local cmp = require "cmp"
  local neocodeium = require "neocodeium"
  -- local commands = require "neocodeium.commands"

  cmp.event:on("menu_opened", function() neocodeium.clear() end)

  neocodeium.setup {
    filter = function() return not cmp.visible() end,
  }

  cmp.setup {
    completion = {
      autocomplete = false,
    },
  }
end
