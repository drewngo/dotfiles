return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  init = function()
    require('nvim-treesitter.install').prefer_git = true

    vim.env.PATH = vim.env.PATH .. ';C:\\Users\\B1024310\\AppData\\Local\\zig'
    vim.env.CC = "gcc.bat"

    require('nvim-treesitter.install').compilers = { "gcc" }
  end,
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    ensure_installed = {
      "lua",
    },
    auto_install = false,
  }
}
