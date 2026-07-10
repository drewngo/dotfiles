return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,       -- Don't lazy-load completion
    priority = 100,     -- Load this early in the initialization tree
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", 
      "hrsh7th/cmp-buffer",   
      "hrsh7th/cmp-path",     
      "L3MON4D3/LuaSnip",     
      "saadparwaiz1/cmp_luasnip", 
      "rafamadriz/friendly-snippets",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
      })
    end,
  },
}
