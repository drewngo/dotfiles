return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'master', -- Force Lazy to lock onto the stable legacy branch
  build = ':TSUpdate',
  config = function()
    -- Map Verilog file extensions cleanly
    vim.filetype.add({
      extension = {
        v = "verilog",
        sv = "verilog",
      }
    })

    -- The master branch setup API works exactly as expected
    require('nvim-treesitter.configs').setup({
      highlight = { enable = true },
      indent = { enable = true },
      ensure_installed = { "lua", "verilog" },
      auto_install = false,
    })
  end
}
