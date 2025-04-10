-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.filetype.add {
  pattern = {
    [".*/i3/config.d/.*.config"] = "i3config",
    [".*.kbd"] = "lisp",
    [".envrc"] = "bash",
  },
}

function load_log_file() end

-- https://andrewcourter.substack.com/p/create-autocommands-in-neovim
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter" }, {
  callback = function()
    if vim.bo.filetype == "TelescopePrompt" then
      vim.wo.relativenumber = false
      if require("lazy.core.config").plugins["neocodeium"]._.loaded then
        require("neocodeium.commands").disable_buffer()
      end
    end
    if vim.bo.filetype ~= "Avante" then vim.wo.relativenumber = true end
    if vim.bo.filetype ~= "AvanteInput" then
      vim.wo.number = true
      vim.wo.relativenumber = true
    end
    if vim.bo.filetype ~= "aerial" then vim.wo.relativenumber = true end
  end,
})

vim.opt.path:append { "**" }
vim.opt.wildmenu = true
vim.opt.exrc = true

local function disable_completion()
  -- Assuming you are using nvim-compe or a similar completion plugin
  -- For nvim-completion:
  vim.g.completion_enable_auto_popup = 0
  -- TODO: Make it work with blink.cmp for v5 migration
  -- For nvim-cmp:
  if require("lazy.core.config").plugins["nvim-cmp"] then require("cmp").setup.buffer { enabled = false } end
end
vim.api.nvim_create_augroup("DisableCompletionForCodeCompanion", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = "DisableCompletionForCodeCompanion",
  pattern = "codecompanion",
  callback = disable_completion,
})

if not vim.g.vscode then
  local lazyState = {
    count = 0,
    veryLazyTriggered = false,
    veryLazyCount = 0,
  }
  -- vim.api.nvim_create_autocmd("VimEnter", {
  --   pattern = "*",
  --   callback = function() vim.notify "VimEnter" end,
  -- })
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "LazyDone",
  --   callback = function() vim.notify "LazyDone" end,
  -- })
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "LazyVimStarted",
  --   callback = function() vim.notify "LazyVimStarted" end,
  -- })
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "VeryLazy",
  --   callback = function()
  --     vim.notify "Very Lazy"
  --     lazyState.veryLazyTriggered = true
  --   end,
  -- })
  -- vim.api.nvim_create_autocmd("User", {
  --   pattern = "LazyLoad",
  --   callback = function(args)
  --     lazyState.count = lazyState.count + 1
  --     if lazyState.veryLazyTriggered then
  --       lazyState.veryLazyCount = lazyState.veryLazyCount + 1
  --       -- vim.notify(
  --       --   "Plugin loaded (" .. lazyState.veryLazyCount .. "/" .. lazyState.count .. "): " .. vim.inspect(args.data)
  --       -- )
  --     else
  --       -- vim.notify("Plugin loaded (" .. lazyState.count .. "): " .. vim.inspect(args.data))
  --     end
  --   end,
  -- })

  -- https://github.com/monkoose/neocodeium?tab=readme-ov-file#-tips
  if not vim.env.ASTRONVIM_SKIP_NEOCODEIUM then
    -- TODO: Make it work with blink.cmp for v5 migration
    if require("lazy.core.config").plugins["nvim-cmp"] then
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
  end
else
  vim.notify("VS Code neovim loaded (v" .. vim.version().major .. "." .. vim.version().minor .. ")")
end
