-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`
-- NOTE: We highly recommend setting up the Lua Language Server (`:LspInstall lua_ls`)
--       as this provides autocomplete and documentation while editing

local function try_stop_codeium()
  if require("lazy.core.config").plugins["neocodeium"]._.loaded then require("neocodeium.commands").disable(true) end
end
local function try_stop_supermaven()
  if require("lazy.core.config").plugins["supermaven-nvim"]._.loaded then
    local supermaven = require "supermaven-nvim.api"
    if supermaven.is_running() then supermaven.stop() end
  end
end
local function try_stop_copilot()
  if require("lazy.core.config").plugins["copilot.lua"]._.loaded then require("copilot.command").disable() end
end
local function try_stop_augment()
  if require("lazy.core.config").plugins["augment"] and require("lazy.core.config").plugins["augment"]._.loaded then
    vim.g.augment_disable_completions = true
  end
end
local function try_stop_all()
  try_stop_codeium()
  try_stop_supermaven()
  try_stop_copilot()
  try_stop_augment()
end

local function start_augment()
  require "augment"
  vim.g.augment_disable_completions = false
end

local function ai_copilot_status()
  local supermaven_status = "unloaded"
  if require("lazy.core.config").plugins["supermaven-nvim"]._.loaded then
    local supermaven = require "supermaven-nvim.api"
    if supermaven.is_running() then
      supermaven_status = "running"
    else
      supermaven_status = "stopped"
    end
  end
  local codeium_status = "unloaded"
  if require("lazy.core.config").plugins["neocodeium"]._.loaded then
    local neocodeium_status, neocodeium_server_status = require("neocodeium").get_status()
    if neocodeium_server_status == 0 then
      codeium_status = "running"
    else
      codeium_status = "stopped"
    end
  end
  local copilot_status = "unloaded"
  if require("lazy.core.config").plugins["copilot.lua"]._.loaded then
    if require("copilot.command").status() then
      copilot_status = "running"
    else
      copilot_status = "stopped"
    end
  end
  local augment_status = "unloaded"
  if require("lazy.core.config").plugins["augment"] and require("lazy.core.config").plugins["augment"]._.loaded then
    if vim.g.augment_disable_completions then
      copilot_status = "disabled"
    else
      copilot_status = "running"
    end
  end
  local status = {}
  status.supermaven = supermaven_status
  status.codeium = codeium_status
  status.copilot = copilot_status
  status.augment = augment_status
  vim.notify("Copilot Status " .. vim.inspect(status))
end

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    -- Configure core features of AstroNvim
    features = {
      large_buf = { size = 1024 * 500, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
      autopairs = true, -- enable autopairs at start
      cmp = true, -- enable completion at start
      diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
      diagnostics = true,
      highlighturl = true, -- highlight URLs at start
      notifications = true, -- enable notifications at start
    },
    -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
    diagnostics = {
      virtual_text = true,
      virtual_lines = { current_line = true },
      underline = true,
      update_in_insert = false,
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        relativenumber = true, -- sets vim.opt.relativenumber
        number = true, -- sets vim.opt.number
        spell = false, -- sets vim.opt.spell
        signcolumn = "auto", -- sets vim.opt.signcolumn to auto
        wrap = false, -- sets vim.opt.wrap
        showtabline = 0, -- disable tab line
        wildmenu = true,
      },
      g = { -- vim.g.<key>
        -- configure global vim variables (vim.g)
        -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
        -- This can be found in the `lua/lazy_setup.lua` file
      },
    },

    rooter = {
      -- list of detectors in order of prevalence, elements can be:
      --   "lsp" : lsp detection
      --   string[] : a list of directory patterns to look for
      --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
      detector = {
        "lsp", -- highest priority is getting workspace from running language servers
        { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- next check for a version controlled parent directory
        { "lua", "MakeFile", "package.json" }, -- lastly check for known project root files
      },
      -- ignore things from root detection
      ignore = {
        servers = {}, -- list of language server names to ignore (Ex. { "efm" })
        dirs = {}, -- list of directory patterns (Ex. { "~/.cargo/*" })
      },
      -- automatically update working directory (update manually with `:AstroRoot`)
      autochdir = false,
      -- scope of working directory to change ("global"|"tab"|"win")
      scope = "global",
      -- show notification on every working directory change
      notify = true,
    },

    -- Configuration table of session options for AstroNvim's session management powered by Resession
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },

    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      -- https://docs.astronvim.com/recipes/sessions/#automatically-restore-previous-session
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              if not vim.g.vscode then
                require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
              end
            end
          end,
        },
      },
    },

    commands = {
      AiCodeium = {
        function()
          try_stop_supermaven()
          try_stop_copilot()
          require("neocodeium.commands").enable()
          vim.notify "Codeium enabled"
        end,
        desc = "Enables Codeium for inline completion",
      },
      AiSuperMaven = {
        function()
          try_stop_codeium()
          try_stop_copilot()
          local supermaven = require "supermaven-nvim.api"
          if not supermaven.is_running() then supermaven.start() end
          vim.notify "SuperMaven enabled"
        end,
        desc = "Enables SuperMaven for inline completion",
      },
      AiCopilot = {
        function()
          try_stop_codeium()
          try_stop_supermaven()
          require("copilot.command").enable()
          vim.notify "Copilot enabled"
        end,
        desc = "Enables Copilot for inline completion",
      },
      AiAugment = {
        function()
          try_stop_all()
          start_augment()
          vim.cmd "Augment status"
        end,
        desc = "Enables Copilot for inline completion",
      },
      AiCopilotStatus = {
        function() ai_copilot_status() end,
        desc = "Ai Copilot status",
      },
      AiCopilotDisable = {
        function()
          try_stop_all()
          vim.notify "All AI Copilot disabled"
        end,
        desc = "Disables any AI Copilot for inline completion",
      },
    },

    -- Mappings can be configured through AstroCore as well.
    -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
    mappings = require "mappings",
  },
}
