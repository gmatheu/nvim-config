-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.filetype.add {
  pattern = {
    [".*/i3/config.d/.*.config"] = "i3config",
  },
}

function load_log_file() end

-- https://andrewcourter.substack.com/p/create-autocommands-in-neovim
-- vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
--   callback = function()
--     if vim.bo.filetype ~= "markdown" then vim.wo.relativenumber = true end
--     if vim.bo.filetype ~= "chatgpt-input" then vim.wo.relativenumber = true end
--   end,
-- })

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
