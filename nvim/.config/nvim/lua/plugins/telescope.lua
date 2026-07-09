return {
  'nvim-telescope/telescope.nvim', version = '*',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    -- Configure telescope to use your exact ripgrep path
    require('telescope').setup({
      defaults = {
        vimgrep_arguments = {
          "C:\\Users\\B1024310\\AppData\\Local\\Programs\\lib\\ripgrep\\tools\\ripgrep-14.1.0-x86_64-pc-windows-msvc\\rg.exe",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
        },
      },
      pickers = {
        live_grep = {
          vimgrep_arguments = {
            "C:\\Users\\B1024310\\AppData\\Local\\Programs\\lib\\ripgrep\\tools\\ripgrep-14.1.0-x86_64-pc-windows-msvc\\rg.exe",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
          },
        },
      },
    })

    -- Keymaps
    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
    vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
  end
}

