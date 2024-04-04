local astrocore = require "astrocore"
local is_available = astrocore.is_available
-- local ui = require "astronvim.utils.ui"

local maps = {
  i = {},
  n = {},
  v = {},
  t = {},
}

local sections = {
  f = { name = "󰍉 Find" },
  p = { name = "󰏖 Packages" },
  l = { name = " LSP" },
  c = { name = " Code" },
  u = { name = " UI" },
  b = { name = "󰓩 Buffers" },
  d = { name = " Debugger" },
  g = { name = " Git" },
  s = { name = "Search" },
  S = { name = "󱂬 Session" },
  t = { name = " Terminal" },
  q = { name = " Quick Actions" },
}
if not vim.g.icons_enabled then vim.tbl_map(function(opts) opts.name = opts.name:gsub("^.* ", "") end, sections) end

-- User --
-- go to  beginning and end
maps.i["<C-b>"] = { "<ESC>^i", desc = "beginning of line" }
maps.i["<C-e>"] = { "<End>", desc = "end of line" }
-- navigate within insert mode
maps.i["<C-h>"] = { "<Left>", desc = "move left" }
maps.i["<C-l>"] = { "<Right>", desc = "move right" }
maps.i["<C-j>"] = { "<Down>", desc = "move down" }
maps.i["<C-k>"] = { "<Up>", desc = "move up" }

maps.n["<F4>"] = { "<cmd> UndotreeToggle <CR>", desc = "Toggle Undo Tree" }

maps.n["U"] = { "<C-r>", desc = "Redo" }
maps.n["<Leader>,"] = { "<cmd> :e#<CR>", desc = "Switch Last buffer" }
-- maps.n[" "] = { "<Leader>", desc = "alternative Leader" }
-- maps.n[";"] = { ":", desc = "enter command mode" }

maps.n["<ESC>"] = { "<cmd> noh <CR>", desc = "no highlight" }
maps.n["<ESC><ESC>"] = { "<cmd> nohlsearch<CR>", desc = "no highlight" }

-- switch between windows
maps.n["<C-h>"] = { "<C-w>h", desc = "window left" }
maps.n["<C-l>"] = { "<C-w>l", desc = "window right" }
-- maps.n["<C-j>"] = { "<C-w>j", desc = "window down" }
-- maps.n["<C-k>"] = { "<C-w>k", desc = "window up" }

-- save
maps.n["<C-s>"] = { "<cmd> w <CR>", desc = "save file" }
maps.n["<Leader><CR>"] = { "<cmd> w <CR>", desc = "save file" }

-- Copy all
maps.n["<C-c>"] = { "<cmd> %y+ <CR>", desc = "copy whole file" }

maps.n["<Leader>c"] = sections.c
maps.n["<Leader>cD"] = { function() vim.lsp.buf.declaration() end, desc = "lsp declaration" }
maps.n["<Leader>cd"] = { function() vim.lsp.buf.definition() end, desc = "lsp definition" }
maps.n["gD"] = { function() vim.lsp.buf.declaration() end, desc = "lsp declaration" }
maps.n["gd"] = { function() vim.lsp.buf.definition() end, desc = "lsp definition" }
maps.n["K"] = { function() vim.lsp.buf.hover() end, desc = "lsp hover" }
maps.n["<Leader>cK"] = { function() vim.lsp.buf.hover() end, desc = "lsp hover" }
maps.n["gi"] = { function() vim.lsp.buf.implementation() end, desc = "lsp implementation" }
maps.n["<Leader>ci"] = { function() vim.lsp.buf.implementation() end, desc = "lsp implementation" }
maps.n["<Leader>ls"] = { function() vim.lsp.buf.signature_help() end, desc = "lsp signature_help" }
maps.n["<Leader>cs"] = { function() vim.lsp.buf.signature_help() end, desc = "lsp signature_help" }
maps.n["<Leader>D"] = { function() vim.lsp.buf.type_definition() end, desc = "lsp definition type" }
-- maps.n["<Leader>ra"] = { function() require("nvchad_ui.renamer").open() end, desc = "lsp rename" }

maps.n["<Leader>ca"] = { function() vim.lsp.buf.code_action() end, desc = "lsp code_action" }
maps.n["gr"] = { function() vim.lsp.buf.references() end, desc = "lsp references" }
maps.n["<Leader>f"] = { function() vim.diagnostic.open_float() end, desc = "floating diagnostic" }
maps.n["[d"] = { function() vim.diagnostic.goto_prev() end, desc = "goto prev" }
maps.n["d]"] = { function() vim.diagnostic.goto_next() end, desc = "goto_next" }
maps.n["<Leader>qq"] = { function() vim.diagnostic.setloclist() end, desc = "diagnostic setloclist" }
maps.n["<Leader>fm"] = { function() vim.lsp.buf.format { async = true } end, desc = "lsp formatting" }
maps.n["<Leader>wa"] = { function() vim.lsp.buf.add_workspace_folder() end, desc = "add workspace folder" }
maps.n["<Leader>wr"] = { function() vim.lsp.buf.remove_workspace_folder() end, desc = "remove workspace folder" }
maps.n["<Leader>wl"] = {
  function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
  desc = "list workspace folders",
}

maps.i["<F2>"] = { '<cmd>lua require("renamer").rename()<cr>', desc = "Rename action" }
maps.n["<Leader>ra"] = { '<cmd>lua require("renamer").rename()<cr>', desc = "Rename action" }
maps.v["<Leader>ra"] = { '<cmd>lua require("renamer").rename()<cr>', desc = "Rename action" }

maps.n["<Leader>s"] = sections.s
maps.n["<Leader>ss"] = { "<cmd>MurenToggle<CR>", desc = "Open multiple replace" }
-- maps.n["<Leader>sw"] =
-- { '<cmd>lua require("spectre").open_visual({select_word={ue})<CR>', desc = "Search current word" }
-- maps.v["<Leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" }
-- maps.n["<Leader>sp"] = {
--   '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
--   desc = "Search on current file",
-- }

maps.n["<Leader>tt"] = { "<cmd>TroubleToggle document_diagnostics<CR>", desc = "[T]oggle [T]rouble" }
maps.n["<Leader>tl"] = { "<cmd>TroubleToggle loclist<CR>", desc = "[T]oggle [L]oclist (Trouble)" }
maps.n["<Leader>tw"] =
  { "<cmd>TroubleToggle workspace_diagnostics<CR>", desc = "[T]oggle [W]orskpace diagnostics (Trouble)" }
maps.n["<Leader>td"] =
  { "<cmd>TroubleToggle document_diagnostics<CR>", desc = "[T]oggle [D]document diagnostics (Trouble)" }

maps.n["<A-j>"] = { function() require("expand-selection").expsel() end, desc = "Expand selection" }
maps.n["<A-e>"] = { function() require("tsht").nodes() end, desc = "Expand selection" }

maps.n["<Leader>q"] = sections.q
maps.n["<Leader>qr"] = { "<cmd>OverseerRun<CR>", desc = "Run tasks" }
maps.n["<Leader>qt"] = { "<cmd>OverseerToggle<CR>", desc = "Overseer toggle" }
maps.n["<Leader>qa"] = { "<cmd>OverseerQuickAction<CR>", desc = "Quick actions" }

-- "fedepujol/move.nvim",
maps.n["<C-j>"] = { "<cmd>MoveLine 1<CR>", desc = "Move line down" }
maps.n["<C-k>"] = { "<cmd>MoveLine -1<CR>", desc = "Move line up" }

-- "mickael-menu/zk-nvim",
maps.n["<Leader>zl"] = { "<cmd>ZkLinks<CR>", desc = "List notes links (zk)" }
maps.n["<Leader>zt"] = { "<cmd>ZkTags<CR>", desc = "List tags (zk)" }
maps.n["<Leader>zn"] = { "<cmd>ZkNew<CR>", desc = "New note (zk)" }
-- End User --

-- Normal --
-- Standard Operations
maps.n["j"] = { "v:count ? 'j' : 'gj'", expr = true, desc = "Move cursor down" }
maps.n["k"] = { "v:count ? 'k' : 'gk'", expr = true, desc = "Move cursor up" }
maps.v["j"] = maps.n.j
maps.v["k"] = maps.n.k
-- maps.n["<Leader>w"] = { "<cmd>w<cr>", desc = "Save" }
maps.n["<Leader>w"] = false
-- maps.n["<Leader>q"] = { "<cmd>confirm q<cr>", desc = "Quit" }
-- maps.n["<Leader>n"] = { "<cmd>enew<cr>", desc = "New File" }
-- maps.n["gx"] = { utils.system_open, desc = "Open the file under cursor with system app" }
maps.n["<C-s>"] = { "<cmd>w!<cr>", desc = "Force write" }
maps.n["<C-q>"] = { "<cmd>q!<cr>", desc = "Force quit" }

if is_available "focus.nvim" then
  maps.n["|"] = { "<cmd>FocusSplitDown<cr>", desc = "Vertical Split [focus]" }
  maps.n["\\"] = { "<cmd>FocusSplitRight<cr>", desc = "Horizontal Split [focus]" }
else
  maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
  maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }
end

-- Plugin Manager
maps.n["<Leader>p"] = sections.p
maps.n["<Leader>pi"] = { function() require("lazy").install() end, desc = "Plugins Install" }
maps.n["<Leader>ps"] = { function() require("lazy").home() end, desc = "Plugins Status" }
maps.n["<Leader>pS"] = { function() require("lazy").sync() end, desc = "Plugins Sync" }
maps.n["<Leader>pu"] = { function() require("lazy").check() end, desc = "Plugins Check Updates" }
maps.n["<Leader>pU"] = { function() require("lazy").update() end, desc = "Plugins Update" }

-- AstroNvim
maps.n["<Leader>pa"] = { "<cmd>AstroUpdatePackages<cr>", desc = "Update Plugins and Mason" }
maps.n["<Leader>pA"] = { "<cmd>AstroUpdate<cr>", desc = "AstroNvim Update" }
maps.n["<Leader>pv"] = { "<cmd>AstroVersion<cr>", desc = "AstroNvim Version" }
maps.n["<Leader>pl"] = { "<cmd>AstroChangelog<cr>", desc = "AstroNvim Changelog" }

-- Manage Buffers
maps.n["<Leader>x"] = { function() require("astronvim.utils.buffer").close() end, desc = "Close buffer" }
-- maps.n["<Leader>C"] = { function() require("astronvim.utils.buffer").close(0, true) end, desc = "Force close buffer" }
maps.n["<Tab>"] =
  { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
maps.n["]b"] =
  { function() require("astronvim.utils.buffer").nav(vim.v.count > 0 and vim.v.count or 1) end, desc = "Next buffer" }
maps.n["[b"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Previous buffer",
}
maps.n["<S-Tab>"] = {
  function() require("astronvim.utils.buffer").nav(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Previous buffer",
}
maps.n[">b"] = {
  function() require("astronvim.utils.buffer").move(vim.v.count > 0 and vim.v.count or 1) end,
  desc = "Move buffer tab right",
}
maps.n["<b"] = {
  function() require("astronvim.utils.buffer").move(-(vim.v.count > 0 and vim.v.count or 1)) end,
  desc = "Move buffer tab left",
}

maps.n["<Leader>b"] = sections.b
maps.n["<Leader>bc"] =
  { function() require("astronvim.utils.buffer").close_all(true) end, desc = "Close all buffers except current" }
maps.n["<Leader>bC"] = { function() require("astronvim.utils.buffer").close_all() end, desc = "Close all buffers" }
maps.n["<Leader>bb"] = {
  function() require("bufferchad").BufferChadListBuffers() end,
  desc = "List buffers [bufferchad]",
}
maps.n["<Leader>bd"] = {
  function()
    require("astronvim.utils.status").heirline.buffer_picker(
      function(bufnr) require("astronvim.utils.buffer").close(bufnr) end
    )
  end,
  desc = "Delete buffer from tabline",
}
maps.n["<Leader>b\\"] = {
  function()
    require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
      vim.cmd.split()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Horizontal split buffer from tabline",
}
maps.n["<Leader>b|"] = {
  function()
    require("astronvim.utils.status").heirline.buffer_picker(function(bufnr)
      vim.cmd.vsplit()
      vim.api.nvim_win_set_buf(0, bufnr)
    end)
  end,
  desc = "Vertical split buffer from tabline",
}
-- maps.n["<Leader>wp"] = {
--   function()
--     local picked_window_id = picker.pick_window() or vim.api.nvim_get_current_win()
--     vim.api.nvim_set_current_win(picked_window_id)
--   end,
-- }

-- Navigate tabs
maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

-- Alpha
if is_available "alpha-nvim" then
  maps.n["<Leader>h"] = {
    function()
      local wins = vim.api.nvim_tabpage_list_wins(0)
      if #wins > 1 and vim.api.nvim_get_option_value("filetype", { win = wins[1] }) == "neo-tree" then
        vim.fn.win_gotoid(wins[2]) -- go to non-neo-tree window to toggle alpha
      end
      require("alpha").start(false, require("alpha").default_config)
    end,
    desc = "Home Screen",
  }
end

-- Comment
if is_available "Comment.nvim" then
  maps.n["<Leader>/"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
  }
  maps.n["<Leader>cc"] = {
    function() require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1) end,
    desc = "Comment line",
  }
  maps.v["<Leader>/"] =
    { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }
  maps.v["<Leader>cc"] =
    { "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<cr>", desc = "Toggle comment line" }
end

-- GitSigns
if is_available "gitsigns.nvim" then
  maps.n["<Leader>g"] = sections.g
  maps.n["]g"] = { function() require("gitsigns").next_hunk() end, desc = "Next Git hunk" }
  maps.n["[g"] = { function() require("gitsigns").prev_hunk() end, desc = "Previous Git hunk" }
  maps.n["<Leader>gl"] = { function() require("gitsigns").blame_line() end, desc = "View Git blame" }
  maps.n["<Leader>gp"] = { function() require("gitsigns").preview_hunk() end, desc = "Preview Git hunk" }
  maps.n["<Leader>gh"] = { function() require("gitsigns").reset_hunk() end, desc = "Reset Git hunk" }
  maps.n["<Leader>gr"] = { function() require("gitsigns").reset_buffer() end, desc = "Reset Git buffer" }
  maps.n["<Leader>gs"] = { function() require("gitsigns").stage_hunk() end, desc = "Stage Git hunk" }
  maps.n["<Leader>gS"] = { function() require("gitsigns").stage_buffer() end, desc = "Stage Git buffer" }
  maps.n["<Leader>gu"] = { function() require("gitsigns").undo_stage_hunk() end, desc = "Unstage Git hunk" }
  maps.n["<Leader>gD"] = { function() require("gitsigns").diffthis() end, desc = "View Git diff" }
end
if is_available "vim-fugitive" then
  maps.n["<Leader>gst"] = { function() vim.cmd.Git() end, desc = "Git vim-fugitive" }
  maps.n["<Leader>gg"] = { function() vim.cmd.Git() end, desc = "Git vim-fugitive" }
end

-- NeoTree
if is_available "neo-tree.nvim" then
  maps.n["<Leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<F3>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
  maps.n["<Leader>o"] = {
    function()
      if vim.bo.filetype == "neo-tree" then
        vim.cmd.wincmd "p"
      else
        vim.cmd.Neotree "focus"
      end
    end,
    desc = "Toggle Explorer Focus",
  }
end

-- Session Manager
maps.n["<Leader>S"] = sections.S
-- if is_available "neovim-session-manager" then
--   maps.n["<Leader>Sl"] = { "<cmd>SessionManager! load_last_session<cr>", desc = "Load last session" }
--   maps.n["<Leader>Ss"] = { "<cmd>SessionManager! save_current_session<cr>", desc = "Save this session" }
--   maps.n["<Leader>Sd"] = { "<cmd>SessionManager! delete_session<cr>", desc = "Delete session" }
--   maps.n["<Leader>Sf"] = { "<cmd>SessionManager! load_session<cr>", desc = "Search sessions" }
--   maps.n["<Leader>S."] =
--     { "<cmd>SessionManager! load_current_dir_session<cr>", desc = "Load current directory session" }
-- end
if is_available "auto-session" then
  maps.n["<Leader>Sl"] = { "<cmd>Autosession search<cr>", desc = "List sessions [auto-session]" }
  maps.n["<Leader>Ss"] = { "<cmd>SessionSave<cr>", desc = "Save this session [auto-session]" }
  maps.n["<Leader>Sd"] = { "<cmd>Autosession delete<cr>", desc = "Delete sessions [auto-session]" }
  maps.n["<Leader>Sr"] = { "<cmd>SessionRestore<cr>", desc = "Search sessions [auto-session]" }
end

-- Package Manager
if is_available "mason.nvim" then
  maps.n["<Leader>pm"] = { "<cmd>Mason<cr>", desc = "Mason Installer" }
  maps.n["<Leader>pM"] = { "<cmd>MasonUpdateAll<cr>", desc = "Mason Update" }
end

-- Smart Splits
if is_available "smart-splits.nvim" then
  maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
  -- maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
  -- maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
  maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
  maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
  maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
  maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
  maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
else
  maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
  -- maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
  -- maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
  maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
  maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
  maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
  maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
  maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }
end

-- SymbolsOutline
if is_available "aerial.nvim" then
  maps.n["<Leader>l"] = sections.l
  maps.n["<Leader>lS"] = { function() require("aerial").toggle() end, desc = "Symbols outline" }
end

-- Telescope
if is_available "telescope.nvim" then
  maps.n["<Leader>f"] = sections.f
  maps.n["<Leader>g"] = sections.g
  maps.n["<Leader>gb"] = { function() require("telescope.builtin").git_branches() end, desc = "Git branches" }
  maps.n["<Leader>gc"] = { function() require("telescope.builtin").git_commits() end, desc = "Git commits" }
  maps.n["<Leader>gt"] = { function() require("telescope.builtin").git_status() end, desc = "Git status" }
  maps.n["<Leader>f<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
  maps.n["<Leader>f'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
  -- maps.n["<Leader>fa"] = {
  --   function()
  --     local cwd = vim.fn.stdpath "config" .. "/.."
  --     local search_dirs = {}
  --     for _, dir in ipairs(astronvim.supported_configs) do -- search all supported config locations
  --       if dir == astronvim.install.home then dir = dir .. "/lua/user" end -- don't search the astronvim core files
  --       if vim.fn.isdirectory(dir) == 1 then table.insert(search_dirs, dir) end -- add directory to search if exists
  --     end
  --     if vim.tbl_isempty(search_dirs) then -- if no config folders found, show warning
  --       utils.notify("No user configuration files found", "warn")
  --     else
  --       if #search_dirs == 1 then cwd = search_dirs[1] end -- if only one directory, focus cwd
  --       require("telescope.builtin").find_files {
  --         prompt_title = "Config Files",
  --         search_dirs = search_dirs,
  --         cwd = cwd,
  --       } -- call telescope
  --     end
  --   end,
  --   desc = "Find AstroNvim config files",
  -- }
  maps.n["<Leader>fb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
  maps.n["<Leader>n"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
  maps.n["<Leader>fc"] =
    { function() require("telescope.builtin").grep_string() end, desc = "Find for word under cursor" }
  maps.n["<Leader>fC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
  maps.n["<Leader>ff"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
  maps.n["<Leader>`"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
  maps.n["<Leader>fF"] = {
    function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
    desc = "Find all files",
  }
  maps.n["<Leader>fh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
  maps.n["<Leader>fk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
  -- maps.n["<Leader>fm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
  if is_available "nvim-notify" then
    maps.n["<Leader>fn"] =
      { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
  end
  maps.n["<Leader>fo"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  maps.n["<Leader>m"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
  maps.n["<Leader>fr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
  maps.n["<Leader>ft"] =
    { function() require("telescope.builtin").colorscheme { enable_preview = true } end, desc = "Find themes" }
  maps.n["<Leader>fw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
  maps.n["<Leader>fW"] = {
    function()
      require("telescope.builtin").live_grep {
        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
      }
    end,
    desc = "Find words in all files",
  }
  maps.n["<Leader>fq"] = {
    function() require("telescope.builtin").grep_string { search = vim.fn.expand "<cword>" } end,
    desc = "Find from selected word",
  }
  maps.n["<Leader>l"] = sections.l
  maps.n["<Leader>lD"] = { function() require("telescope.builtin").diagnostics() end, desc = "Search diagnostics" }
  maps.n["<Leader>ls"] = {
    function()
      local aerial_avail, _ = pcall(require, "aerial")
      if aerial_avail then
        require("telescope").extensions.aerial.aerial()
      else
        require("telescope.builtin").lsp_document_symbols()
      end
    end,
    desc = "Search symbols",
  }
end

-- Terminal
-- if is_available "toggleterm.nvim" then
--   maps.n["<Leader>t"] = sections.t
--   if vim.fn.executable "lazygit" == 1 then
--     maps.n["<Leader>g"] = sections.g
--     maps.n["<Leader>gg"] = { function() utils.toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
--     maps.n["<Leader>tl"] = { function() utils.toggle_term_cmd "lazygit" end, desc = "ToggleTerm lazygit" }
--   end
--   if vim.fn.executable "node" == 1 then
--     maps.n["<Leader>tn"] = { function() utils.toggle_term_cmd "node" end, desc = "ToggleTerm node" }
--   end
--   if vim.fn.executable "gdu" == 1 then
--     maps.n["<Leader>tu"] = { function() utils.toggle_term_cmd "gdu" end, desc = "ToggleTerm gdu" }
--   end
--   if vim.fn.executable "btm" == 1 then
--     maps.n["<Leader>tt"] = { function() utils.toggle_term_cmd "btm" end, desc = "ToggleTerm btm" }
--   end
--   local python = vim.fn.executable "python" == 1 and "python" or vim.fn.executable "python3" == 1 and "python3"
--   if python then maps.n["<Leader>tp"] = { function() utils.toggle_term_cmd(python) end, desc = "ToggleTerm python" } end
--   maps.n["<Leader>tf"] = { "<cmd>ToggleTerm direction=float<cr>", desc = "ToggleTerm float" }
--   maps.n["<Leader>th"] = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", desc = "ToggleTerm horizontal split" }
--   maps.n["<Leader>tv"] = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "ToggleTerm vertical split" }
--   maps.n["<F7>"] = { "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" }
--   maps.t["<F7>"] = maps.n["<F7>"]
--   maps.n["<C-'>"] = maps.n["<F7>"]
--   maps.t["<C-'>"] = maps.n["<F7>"]
-- end

if is_available "nvim-dap" then
  maps.n["<Leader>d"] = sections.d
  -- modified function keys found with `showkey -a` in the terminal to get key code
  -- run `nvim -V3log +quit` and search through the "Terminal info" in the `log` file for the correct keyname
  maps.n["<F5>"] = { function() require("dap").continue() end, desc = "Debugger: Start" }
  maps.n["<F17>"] = { function() require("dap").terminate() end, desc = "Debugger: Stop" } -- Shift+F5
  maps.n["<F29>"] = { function() require("dap").restart_frame() end, desc = "Debugger: Restart" } -- Control+F5
  maps.n["<F6>"] = { function() require("dap").pause() end, desc = "Debugger: Pause" }
  maps.n["<F9>"] = { function() require("dap").toggle_breakpoint() end, desc = "Debugger: Toggle Breakpoint" }
  maps.n["<F10>"] = { function() require("dap").step_over() end, desc = "Debugger: Step Over" }
  maps.n["<F11>"] = { function() require("dap").step_into() end, desc = "Debugger: Step Into" }
  maps.n["<F23>"] = { function() require("dap").step_out() end, desc = "Debugger: Step Out" } -- Shift+F11
  maps.n["<Leader>db"] = { function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint (F9)" }
  maps.n["<Leader>dB"] = { function() require("dap").clear_breakpoints() end, desc = "Clear Breakpoints" }
  maps.n["<Leader>dc"] = { function() require("dap").continue() end, desc = "Start/Continue (F5)" }
  maps.n["<Leader>di"] = { function() require("dap").step_into() end, desc = "Step Into (F11)" }
  maps.n["<Leader>do"] = { function() require("dap").step_over() end, desc = "Step Over (F10)" }
  maps.n["<Leader>dO"] = { function() require("dap").step_out() end, desc = "Step Out (S-F11)" }
  maps.n["<Leader>dq"] = { function() require("dap").close() end, desc = "Close Session" }
  maps.n["<Leader>dQ"] = { function() require("dap").terminate() end, desc = "Terminate Session (S-F5)" }
  maps.n["<Leader>dp"] = { function() require("dap").pause() end, desc = "Pause (F6)" }
  maps.n["<Leader>dr"] = { function() require("dap").restart_frame() end, desc = "Restart (C-F5)" }
  maps.n["<Leader>dR"] = { function() require("dap").repl.toggle() end, desc = "Toggle REPL" }
  if is_available "nvim-dap-ui" then
    maps.n["<Leader>du"] = { function() require("dapui").toggle() end, desc = "Toggle Debugger UI" }
    maps.n["<Leader>dh"] = { function() require("dap.ui.widgets").hover() end, desc = "Debugger Hover" }
  end
end

-- Improved Code Folding
if is_available "nvim-ufo" then
  maps.n["zR"] = { function() require("ufo").openAllFolds() end, desc = "Open all folds" }
  maps.n["zM"] = { function() require("ufo").closeAllFolds() end, desc = "Close all folds" }
  maps.n["zr"] = { function() require("ufo").openFoldsExceptKinds() end, desc = "Fold less" }
  maps.n["zm"] = { function() require("ufo").closeFoldsWith() end, desc = "Fold more" }
  maps.n["zp"] = { function() require("ufo").peekFoldedLinesUnderCursor() end, desc = "Peek fold" }
end

-- Stay in indent mode
-- maps.v["<S-Tab>"] = { "<gv", desc = "unindent line" }
-- maps.v["<Tab>"] = { ">gv", desc = "indent line" }

-- Improved Terminal Navigation
maps.t["<C-h>"] = { "<cmd>wincmd h<cr>", desc = "Terminal left window navigation" }
maps.t["<C-j>"] = { "<cmd>wincmd j<cr>", desc = "Terminal down window navigation" }
maps.t["<C-k>"] = { "<cmd>wincmd k<cr>", desc = "Terminal up window navigation" }
maps.t["<C-l>"] = { "<cmd>wincmd l<cr>", desc = "Terminal right window navigation" }

-- maps.n["<Leader>u"] = sections.u
-- -- Custom menu for modification of the user experience
-- if is_available "nvim-autopairs" then maps.n["<Leader>ua"] = { ui.toggle_autopairs, desc = "Toggle autopairs" } end
-- maps.n["<Leader>ub"] = { ui.toggle_background, desc = "Toggle background" }
-- if is_available "nvim-cmp" then maps.n["<Leader>uc"] = { ui.toggle_cmp, desc = "Toggle autocompletion" } end
-- if is_available "nvim-colorizer.lua" then
--   maps.n["<Leader>uC"] = { "<cmd>ColorizerToggle<cr>", desc = "Toggle color highlight" }
-- end
-- maps.n["<Leader>ud"] = { ui.toggle_diagnostics, desc = "Toggle diagnostics" }
-- maps.n["<Leader>ug"] = { ui.toggle_signcolumn, desc = "Toggle signcolumn" }
-- maps.n["<Leader>ui"] = { ui.set_indent, desc = "Change indent setting" }
-- maps.n["<Leader>ul"] = { ui.toggle_statusline, desc = "Toggle statusline" }
-- maps.n["<Leader>uL"] = { ui.toggle_codelens, desc = "Toggle CodeLens refresh" }
-- maps.n["<Leader>un"] = { ui.change_number, desc = "Change line numbering" }
-- maps.n["<Leader>uN"] = { ui.toggle_ui_notifications, desc = "Toggle UI notifications" }
-- maps.n["<Leader>up"] = { ui.toggle_paste, desc = "Toggle paste mode" }
-- maps.n["<Leader>us"] = { ui.toggle_spell, desc = "Toggle spellcheck" }
-- maps.n["<Leader>uS"] = { ui.toggle_conceal, desc = "Toggle conceal" }
-- maps.n["<Leader>ut"] = { ui.toggle_tabline, desc = "Toggle tabline" }
-- maps.n["<Leader>uu"] = { ui.toggle_url_match, desc = "Toggle URL highlight" }
-- maps.n["<Leader>uw"] = { ui.toggle_wrap, desc = "Toggle wrap" }
-- maps.n["<Leader>uy"] = { ui.toggle_syntax, desc = "Toggle syntax highlight" }
--
return maps
