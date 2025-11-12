vim.filetype.add {
  pattern = {
    [".*/i3/config.d/.*.config"] = "i3config",
    [".*.kbd"] = "lisp",
    [".envrc"] = "bash",
  },
}

function load_log_file() end

-- https://andrewcourter.substack.com/p/create-autocommands-in-neovim
vim.api.nvim_create_autocmd({ "VimEnter", "WinEnter", "BufWinEnter", "BufRead" }, {
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
vim.opt.secure = true
vim.o.exrc = true
vim.o.secure = false

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

-- open help in vertical split
vim.api.nvim_create_autocmd("FileType", {
  pattern = "help",
  command = "wincmd L",
})

-- auto resize splits when the terminal's window is resized
vim.api.nvim_create_autocmd("VimResized", {
  command = "wincmd =",
})

-- no auto continue comments on new line
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("no_auto_comment", {}),
  callback = function() vim.opt_local.formatoptions:remove { "c", "r", "o" } end,
})

-- -- syntax highlighting for dotenv files
-- vim.api.nvim_create_autocmd("BufRead", {
--   group = vim.api.nvim_create_augroup("dotenv_ft", { clear = true }),
--   pattern = { ".env", ".env.*" },
--   callback = function() vim.bo.filetype = "dosini" end,
-- })

-- show cursorline only in active window enable
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
  group = vim.api.nvim_create_augroup("active_cursorline", { clear = true }),
  callback = function() vim.opt_local.cursorline = true end,
})

-- show cursorline only in active window disable
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
  group = "active_cursorline",
  callback = function() vim.opt_local.cursorline = false end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMoved", {
  group = vim.api.nvim_create_augroup("LspReferenceHighlight", { clear = true }),
  desc = "Highlight references under cursor",
  callback = function()
    -- Only run if the cursor is not in insert mode
    if vim.fn.mode() ~= "i" then
      local clients = vim.lsp.get_clients { bufnr = 0 }
      local supports_highlight = false
      for _, client in ipairs(clients) do
        if client.server_capabilities.documentHighlightProvider then
          supports_highlight = true
          break -- Found a supporting client, no need to check others
        end
      end

      -- 3. Proceed only if an LSP is active AND supports the feature
      if supports_highlight then
        vim.lsp.buf.clear_references()
        vim.lsp.buf.document_highlight()
      end
    end
  end,
})

-- ide like highlight when stopping cursor
vim.api.nvim_create_autocmd("CursorMovedI", {
  group = "LspReferenceHighlight",
  desc = "Clear highlights when entering insert mode",
  callback = function() vim.lsp.buf.clear_references() end,
})
