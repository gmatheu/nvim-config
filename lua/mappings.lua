local maps = {
  i = {},
  n = {},
  v = {},
  t = {},
}

maps.n["<LocalLeader>c"] = { name = "AI assisted" }
maps.n["<LocalLeader>ci"] = { name = "AI Inline completion" }
maps.n["<LocalLeader>cis"] = {
  "<cmd>AiSuperMaven<CR>",
  desc = "Enable SuperMaven for inline completion",
}
maps.n["<LocalLeader>cic"] = {
  "<cmd>AiCodeium<CR>",
  desc = "Enable Codeium for inline completion",
}

-- User --
maps.n["<Leader>q"] = { "", desc = "do nothing [was: quit]" }
maps.n["<Leader>c"] = { "", desc = "do nothing [was: close buffer]" }
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
maps.n[";"] = { ":", desc = "enter command mode" }

maps.n["<ESC>"] = { "<cmd> noh <CR>", desc = "no highlight" }
maps.n["<ESC><ESC>"] = { "<cmd> nohlsearch<CR>", desc = "no highlight" }

-- switch between windows
maps.n["<C-h>"] = { "<C-w>h", desc = "window left" }
maps.n["<C-l>"] = { "<C-w>l", desc = "window right" }
-- maps.n["<C-j>"] = { "<C-w>j", desc = "window down" }
-- maps.n["<C-k>"] = { "<C-w>k", desc = "window up" }
maps.n["<C-w><"] = { "<cmd>vertical resize -25<CR>", desc = "decrease width [window]" }
maps.n["<C-w>>"] = { "<cmd>vertical resize +25<CR>", desc = "increase width [window]" }
maps.n["<C-w>+"] = { "<cmd>resize +25<CR>", desc = "increase height [window]" }
maps.n["<C-w>-"] = { "<cmd>resize -25<CR>", desc = "decrease height [window]" }

-- save
maps.n["<C-s>"] = { "<cmd> w <CR>", desc = "save file" }
maps.n["<Leader><CR>"] = { "<cmd> w <CR>", desc = "save file" }

-- Copy all
maps.n["<C-c>"] = { "<cmd> %y+ <CR>", desc = "copy whole file" }

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
-- maps.n["<Leader>f"] = { function() vim.diagnostic.open_float() end, desc = "floating diagnostic" }
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

maps.n["<Leader>ss"] = { "<cmd>MurenToggle<CR>", desc = "Open multiple replace" }
-- maps.n["<Leader>sw"] =
-- { '<cmd>lua require("spectre").open_visual({select_word={ue})<CR>', desc = "Search current word" }
-- maps.v["<Leader>sw"] = { '<esc><cmd>lua require("spectre").open_visual()<CR>', desc = "Search current word" }
-- maps.n["<Leader>sp"] = {
--   '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>',
--   desc = "Search on current file",
-- }

maps.n["<A-j>"] = { function() require("expand-selection").expsel() end, desc = "Expand selection" }

-- TODO Review
-- maps.n["<A-e>"] = { function() require("tsht").nodes() end, desc = "Expand selection" }

-- maps.n["<Leader>qr"] = { "<cmd>OverseerRun<CR>", desc = "Run tasks [overseer]" }
-- maps.n["<Leader>qt"] = { "<cmd>OverseerToggle<CR>", desc = "Overseer toggle [overseer]" }
-- maps.n["<Leader>qa"] = { "<cmd>OverseerQuickAction<CR>", desc = "Quick actions [overseer]" }

-- "fedepujol/move.nvim",
-- TODO Review
maps.n["<C-j>"] = { "<cmd>MoveLine 1<CR>", desc = "Move line down" }
maps.n["<C-k>"] = { "<cmd>MoveLine -1<CR>", desc = "Move line up" }
-- End User --

maps.n["|"] = { "<cmd>FocusSplitDown<cr>", desc = "Vertical Split [focus]" }
maps.n["\\"] = { "<cmd>FocusSplitRight<cr>", desc = "Horizontal Split [focus]" }
-- maps.n["|"] = { "<cmd>vsplit<cr>", desc = "Vertical Split" }
-- maps.n["\\"] = { "<cmd>split<cr>", desc = "Horizontal Split" }

maps.n["<Leader>x"] = { "<cmd>bd<cr>", desc = "Close buffer" }

-- Navigate tabs
-- maps.n["]t"] = { function() vim.cmd.tabnext() end, desc = "Next tab" }
maps.n["[t"] = { function() vim.cmd.tabprevious() end, desc = "Previous tab" }

if vim.version().minor >= 11 then
  maps.n["<Leader>/"] = {
    "gcc",
    desc = "Comment line (builtin)",
    remap = true,
  }
  maps.n["<Leader>cc"] = {
    "gcc",
    desc = "Comment line (builtin))",
    remap = true,
  }
  maps.v["<Leader>/"] = {
    "gc",
    desc = "Toggle comment line (builtin)",
    remap = true,
  }
  maps.v["<Leader>cc"] = {
    "gc",
    desc = "Toggle comment line (builtin)",
    remap = true,
  }
end

maps.n["<Leader>gst"] = { "<cmd>Git<cr>", desc = "Git vim-fugitive" }
-- maps.n["<Leader>gg"] = { "<cmd>Git<cr>", desc = "Git vim-fugitive" }

-- NeoTree
maps.n["<F3>"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }

-- maps.n["<Leader>e"] = { "<cmd>Neotree toggle<cr>", desc = "Toggle Explorer" }
-- maps.n["<Leader>o"] = {
--   function()
--     if vim.bo.filetype == "neo-tree" then
--       vim.cmd.wincmd "p"
--     else
--       vim.cmd.Neotree "focus"
--     end
--   end,
--   desc = "Toggle Explorer Focus",
-- }

-- Session Manager
-- maps.n["<Leader>Sl"] = { "<cmd>Autosession search<cr>", desc = "List sessions [auto-session]" }
-- maps.n["<Leader>Ss"] = { "<cmd>SessionSave<cr>", desc = "Save this session [auto-session]" }
-- maps.n["<Leader>Sd"] = { "<cmd>Autosession delete<cr>", desc = "Delete sessions [auto-session]" }
-- maps.n["<Leader>Sr"] = { "<cmd>SessionRestore<cr>", desc = "Search sessions [auto-session]" }

-- Smart Splits
maps.n["<C-h>"] = { function() require("smart-splits").move_cursor_left() end, desc = "Move to left split" }
-- maps.n["<C-j>"] = { function() require("smart-splits").move_cursor_down() end, desc = "Move to below split" }
-- maps.n["<C-k>"] = { function() require("smart-splits").move_cursor_up() end, desc = "Move to above split" }
maps.n["<C-l>"] = { function() require("smart-splits").move_cursor_right() end, desc = "Move to right split" }
maps.n["<C-Up>"] = { function() require("smart-splits").resize_up() end, desc = "Resize split up" }
maps.n["<C-Down>"] = { function() require("smart-splits").resize_down() end, desc = "Resize split down" }
maps.n["<C-Left>"] = { function() require("smart-splits").resize_left() end, desc = "Resize split left" }
maps.n["<C-Right>"] = { function() require("smart-splits").resize_right() end, desc = "Resize split right" }
-- maps.n["<C-h>"] = { "<C-w>h", desc = "Move to left split" }
-- -- maps.n["<C-j>"] = { "<C-w>j", desc = "Move to below split" }
-- -- maps.n["<C-k>"] = { "<C-w>k", desc = "Move to above split" }
-- maps.n["<C-l>"] = { "<C-w>l", desc = "Move to right split" }
-- maps.n["<C-Up>"] = { "<cmd>resize -2<CR>", desc = "Resize split up" }
-- maps.n["<C-Down>"] = { "<cmd>resize +2<CR>", desc = "Resize split down" }
-- maps.n["<C-Left>"] = { "<cmd>vertical resize -2<CR>", desc = "Resize split left" }
-- maps.n["<C-Right>"] = { "<cmd>vertical resize +2<CR>", desc = "Resize split right" }

-- Experimental commands, not meant to be called with the keymaps, but wuti fuzzy finder
maps.n["<LocalLeader>X"] = { name = "Experimental commands" }
maps.n["<LocalLeader>Xi"] = { name = "Instrument" }
-- maps.n["<LocalLeader>Xir"] = {
--   function()
--     vim.ui.input({ prompt = "Save profile to:", completion = "file", default = "profile.log" }, function(filename)
--       if filename then require("plenary").start(filename) end
--     end)
--   end,
--   desc = "Record profile [Plenary]",
-- }
-- maps.n["<LocalLeader>Xis"] = {
--   function() require("plenary.profile").stop() end,
--   desc = "Stop recording profile [Plenary]",
-- }

-- maps.n["J"] = { "j", desc = "Next line" }

return maps
