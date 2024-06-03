-- if true then return end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

vim.filetype.add {
  pattern = {
    [".*/i3/config.d/.*.config"] = "i3config",
  },
}
