return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls" },
      })

      vim.diagnostic.config({
        virtual_text  = true,
        severity_sort = true,
        float         = {
          style  = 'minimal',
          border = 'rounded',
          source = 'if_many',
          header = '',
          prefix = '',
        },
        signs         = {
          text = {
            [vim.diagnostic.severity.ERROR] = '✘',
            [vim.diagnostic.severity.WARN]  = '▲',
            [vim.diagnostic.severity.HINT]  = '⚑',
            [vim.diagnostic.severity.INFO]  = '»',
          },
        },
      })

      local orig = vim.lsp.util.open_floating_preview
      ---@diagnostic disable-next-line: duplicate-set-field
      function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
        opts            = opts or {}
        opts.border     = opts.border or 'rounded'
        opts.max_width  = opts.max_width or 80
        opts.max_height = opts.max_height or 24
        opts.wrap       = opts.wrap ~= false
        return orig(contents, syntax, opts, ...)
      end

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
          local buf    = args.buf
          local map    = function(mode, lhs, rhs) vim.keymap.set(mode, lhs, rhs, { buffer = buf }) end

          map('n', 'K', vim.lsp.buf.hover)
          map('n', 'gd', vim.lsp.buf.definition)
          map('n', 'gD', vim.lsp.buf.declaration)
          map('n', 'gi', vim.lsp.buf.implementation)
          map('n', 'go', vim.lsp.buf.type_definition)
          map('n', 'gr', vim.lsp.buf.references)
          map('n', 'gs', vim.lsp.buf.signature_help)
          map('n', 'gl', vim.diagnostic.open_float)
          map('n', '<F2>', vim.lsp.buf.rename)
          map({ 'n', 'x' }, '<F3>', function() vim.lsp.buf.format({ async = true }) end)
          map('n', '<F4>', vim.lsp.buf.code_action)

          if client:supports_method('textDocument/documentHighlight') then
            local highlight_augroup = vim.api.nvim_create_augroup('my.lsp.highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })
            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })
          end

          -- Format on Save automation rule
          local excluded_filetypes = { c = true, cpp = true }
          if not client:supports_method('textDocument/willSaveWaitUntil')
              and client:supports_method('textDocument/formatting')
              and not excluded_filetypes[vim.bo[buf].filetype]
          then
            vim.api.nvim_create_autocmd('BufWritePre', {
              group = vim.api.nvim_create_augroup('my.lsp.format', { clear = false }),
              buffer = buf,
              callback = function()
                vim.lsp.buf.format({ bufnr = buf, id = client.id, timeout_ms = 1000 })
              end,
            })
          end
        end,
      })

      local caps = capabilities
      local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
      if has_cmp then caps = cmp_lsp.default_capabilities() end

      vim.lsp.config("lua_ls", {
        capabilities = caps,
        settings = {
          Lua = { diagnostics = { globals = { "vim" } } },
        },
      })
      vim.lsp.enable("lua_ls")

      vim.lsp.config["slang_hardware"] = {
        config = {
          cmd = { vim.fn.stdpath("data") .. "/mason/bin/slang-server" },
          filetypes = { "verilog", "systemverilog" },
          capabilities = caps,
          root_dir = function(fname)
            return vim.fs.root(fname, { ".git", "slang.txt" }) or vim.uv.cwd()
          end,
        },
        meta = {
          description = "SystemVerilog/Verilog compiler language server engine (slang)",
        },
      }
      vim.lsp.enable("slang_hardware")
    end,
  },
}
