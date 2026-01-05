local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local conf = require("telescope.config").values

-->>> from: https://raw.githubusercontent.com/nvim-telescope/telescope.nvim/refs/heads/master/lua/telescope/builtin/__files.lua
local actions = require "telescope.actions"
local finders = require "telescope.finders"
local make_entry = require "telescope.make_entry"
local pickers = require "telescope.pickers"
local sorters = require "telescope.sorters"
local utils = require "telescope.utils"

local Path = require "plenary.path"

local flatten = utils.flatten
local filter = vim.tbl_filter

local has_rg_program = function(picker_name, program)
  if vim.fn.executable(program) == 1 then return true end

  utils.notify(picker_name, {
    msg = string.format(
      "'ripgrep', or similar alternative, is a required dependency for the %s picker. "
        .. "Visit https://github.com/BurntSushi/ripgrep#installation for installation instructions.",
      picker_name
    ),
    level = "ERROR",
  })
  return false
end

local get_open_filelist = function(grep_open_files, cwd)
  if not grep_open_files then return nil end

  local bufnrs = filter(function(b)
    if 1 ~= vim.fn.buflisted(b) then return false end
    return true
  end, vim.api.nvim_list_bufs())
  if not next(bufnrs) then return end

  local filelist = {}
  for _, bufnr in ipairs(bufnrs) do
    local file = vim.api.nvim_buf_get_name(bufnr)
    table.insert(filelist, Path:new(file):make_relative(cwd))
  end
  return filelist
end

local opts_contain_invert = function(args)
  local invert = false
  local files_with_matches = false

  for _, v in ipairs(args) do
    if v == "--invert-match" then
      invert = true
    elseif v == "--files-with-matches" or v == "--files-without-match" then
      files_with_matches = true
    end

    if #v >= 2 and v:sub(1, 1) == "-" and v:sub(2, 2) ~= "-" then
      local non_option = false
      for i = 2, #v do
        local vi = v:sub(i, i)
        if vi == "=" then -- ignore option -g=xxx
          break
        elseif vi == "g" or vi == "f" or vi == "m" or vi == "e" or vi == "r" or vi == "t" or vi == "T" then
          non_option = true
        elseif non_option == false and vi == "v" then
          invert = true
        elseif non_option == false and vi == "l" then
          files_with_matches = true
        end
      end
    end
  end
  return invert, files_with_matches
end

-- Special keys:
--  opts.search_dirs -- list of directory to search in
--  opts.grep_open_files -- boolean to restrict search to open files
local live_grep_plus = function(opts)
  if not opts then opts = {} end
  local vimgrep_arguments = opts.vimgrep_arguments or conf.vimgrep_arguments
  if not has_rg_program("live_grep", vimgrep_arguments[1]) then return end
  local search_dirs = opts.search_dirs
  local grep_open_files = opts.grep_open_files
  opts.cwd = opts.cwd and utils.path_expand(opts.cwd) or vim.loop.cwd()

  local filelist = get_open_filelist(grep_open_files, opts.cwd)
  if search_dirs then
    for i, path in ipairs(search_dirs) do
      search_dirs[i] = utils.path_expand(path)
    end
  end

  local additional_args = {}
  if opts.additional_args ~= nil then
    if type(opts.additional_args) == "function" then
      additional_args = opts.additional_args(opts)
    elseif type(opts.additional_args) == "table" then
      additional_args = opts.additional_args
    end
  end

  if opts.type_filter then additional_args[#additional_args + 1] = "--type=" .. opts.type_filter end

  if type(opts.glob_pattern) == "string" then
    additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern
  elseif type(opts.glob_pattern) == "table" then
    for i = 1, #opts.glob_pattern do
      additional_args[#additional_args + 1] = "--glob=" .. opts.glob_pattern[i]
    end
  end

  if opts.file_encoding then additional_args[#additional_args + 1] = "--encoding=" .. opts.file_encoding end

  local args = flatten { vimgrep_arguments, additional_args }
  opts.__inverted, opts.__matches = opts_contain_invert(args)

  local live_grepper = finders.new_job(function(prompt)
    if not prompt or prompt == "" then return nil end

    local search_list = {}

    if grep_open_files then
      search_list = filelist
    elseif search_dirs then
      search_list = search_dirs
    end
    local pieces = vim.split(prompt, "  ")

    local expression = prompt
    if pieces[1] then expression = pieces[1] end

    if pieces[2] then
      local glob = "*" .. pieces[2] .. "*"
      return flatten { args, "-g", glob, "--", expression, search_list }
    else
      return flatten { args, "--", expression, search_list }
    end
  end, opts.entry_maker or make_entry.gen_from_vimgrep(opts), opts.max_results, opts.cwd)

  pickers
    .new(opts, {
      prompt_title = "Live Grep",
      finder = live_grepper,
      previewer = conf.grep_previewer(opts),
      -- TODO: It would be cool to use `--json` output for this
      -- and then we could get the highlight positions directly.
      sorter = sorters.highlighter_only(opts),
      attach_mappings = function(_, map)
        map("i", "<c-space>", actions.to_fuzzy_refine)
        return true
      end,
      push_cursor_on_edit = true,
    })
    :find()
end
--<<< from: https://raw.githubusercontent.com/nvim-telescope/telescope.nvim/refs/heads/master/lua/telescope/builtin/__files.lua

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  local finder = finders.new_async_job {
    command_generator = function(prompt)
      if not prompt or prompt == "" then return nil end

      local pieces = vim.split(prompt, "  ")
      local args = { "rg" }
      if pieces[1] then
        table.insert(args, "-e")
        table.insert(args, pieces[1])
      end

      if pieces[2] then
        table.insert(args, "-g")
        table.insert(args, "*" .. pieces[2] .. "*")
      end

      ---@diagnostic disable-next-line: deprecated
      return vim.tbl_flatten {
        args,
        { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column", "--smart-case" },
      }
    end,
    entry_maker = make_entry.gen_from_vimgrep(opts),
    cwd = opts.cwd,
  }

  pickers
    .new(opts, {
      debounce = 100,
      prompt_title = "Multi Grep",
      finder = finder,
      previewer = conf.grep_previewer(opts),
      sorter = require("telescope.sorters").empty(),
    })
    :find()
end

---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<Leader>n", function() require("telescope.builtin").buffers() end, desc = "Find buffers [telescope]" },
      { "<Leader>b", function() require("telescope.builtin").jumplist() end, desc = "Find Jumplist [telescope]" },
      { "<Leader>`", function() require("telescope.builtin").find_files() end, desc = "Find files [telescope]" },
      { "<Leader>m", "<cmd>Telescope frecency<cr>", desc = "Find history [frecency]" },
      -- { "<Leader>w", function() require("telescope.builtin").live_grep() end, desc = "Live grep [telescope]" },
      { "<Leader>w", live_grep_plus, desc = "Live grep [telescope]" },
      {
        "<Leader>fo",
        function() require("telescope").live_grep { grep_open_files = true } end,
        desc = "Live grep open files [telescope]",
      },
      {
        "<Leader>fl",
        function() require("telescope.builtin").lsp_references() end,
        desc = "Lsp references [telescope]",
      },
      {
        "<Leader>fq",
        function() require("telescope.builtin").grep_string { search = vim.fn.expand "<cword>" } end,
        desc = "Find from selected word [telescope]",
      },
    },
    config = function()
      require("telescope").setup {
        defaults = {
          layout_strategy = "vertical",
          layout_config = {
            center = { width = 0.8, height = 0.8 },
            horizontal = { width = 0.9, height = 0.9 },
            vertical = { width = 0.9, height = 0.9 },
          },
        },
        pickers = {
          lsp_references = {
            theme = "ivy",
          },
        },
        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          },
        },
      }
      require("telescope").load_extension "fzf"
      require("telescope").load_extension "frecency"
    end,
    dependencies = {
      {
        "nvim-telescope/telescope-frecency.nvim",
      },
      "nvim-lua/plenary.nvim",
      { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
  },
}
