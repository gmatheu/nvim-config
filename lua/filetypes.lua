vim.filetype.add {
  extension = {
    env = "dotenv",
  },
  filename = {
    [".env"] = "dotenv",
    ["env"] = "dotenv",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
    ["%.env%.[%w_.-]+"] = "dotenv",
    [".*/i3/config.d/.*.config"] = "i3config",
    [".*.kbd"] = "lisp",
    [".*.njk"] = "jinja",
    [".envrc"] = "bash",
  },
}
