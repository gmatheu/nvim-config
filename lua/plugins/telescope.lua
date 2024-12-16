---@type LazySpec
return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    keys = {
      { "<Leader>n", function() require("telescope.builtin").buffers() end, desc = "Find buffers [telescope]" },
      { "<Leader>bb", function() require("telescope.builtin").jumplist() end, desc = "Find Jumplist [telescope]" },
      { "<Leader>`", function() require("telescope.builtin").find_files() end, desc = "Find files [telescope]" },
      { "<Leader>m", "<cmd>Telescope frecency<cr>", desc = "Find history [frecency]" },
      { "<Leader>w", function() require("telescope.builtin").live_grep() end, desc = "Live grep [telescope]" },
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
          layout_strategy = "horizontal",
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
