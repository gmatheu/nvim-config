---@type LazySpec
return {
  -- Overseeded by Telescope and Oil
  {
    "nvim-telescope/telescope-file-browser.nvim",
    enabled = false,
    keys = {
      {
        "<space>f",
        desc = "telescope-file-browser",
      },
      {
        "<space>fb",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
        desc = "Open file browser [telescope-file-browser]",
      },
    },
    config = function()
      require("telescope").setup {
        extensions = {
          file_browser = {
            hijack_netrw = true,
          },
        },
      }
      require("telescope").load_extension "file_browser"
    end,
  },
}
