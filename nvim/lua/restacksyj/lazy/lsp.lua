vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)
    vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)

    vim.keymap.set("n", "<leader>vws", "<cmd> Telescope lsp_workspace_symbols<CR>", opts)
    vim.keymap.set("n", "<leader>vd", function()
      vim.diagnostic.open_float(nil, { focus = true, scope = "cursor" })
    end)
    vim.keymap.set("n", "[d", function()
      vim.diagnostic.goto_next()
    end, opts)
    vim.keymap.set("n", "]d", function()
      vim.diagnostic.goto_prev()
    end, opts)
    vim.keymap.set("n", "<leader>vca", function()
      vim.lsp.buf.code_action()
    end, opts)
    vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<CR>", opts)
    vim.keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)
    vim.keymap.set("n", "<leader>vrn", function()
      vim.lsp.buf.rename()
    end, opts)
    vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then return end
    if client.supports_method('textDocument/formatting', 0) then
      vim.api.nvim_create_autocmd('BufWritePre', {
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.format({ bufnr = event.buf, id = client.id })
        end
      })
    end
  end,
})

return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },

  config = function()
    local cmp = require('cmp')
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "ts_ls",
      },
      handlers = {
        function(server_name) -- default handler (optional)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            -- on_attach = on_attach
          }
        end,

        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            },
          }

          -- vim.api.nvim_create_autocmd('LspAttach', {
          --   callback = function(args)
          --     local client = vim.lsp.get_client_by_id(args.data.client_id)
          --     if not client then return end
          --     if client.supports_method('textDocument/formatting', 0) then
          --       vim.api.nvim_create_autocmd('BufWritePre', {
          --         buffer = args.buf,
          --         callback = function()
          --           vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
          --         end
          --       })
          --     end
          --   end,
          -- })
        end,

        -- ["rust_analyzer"] = function()
        --     local lspconfig = require("lspconfig")
        --     lspconfig.rust_analyzer.setup {
        --         capabilities = capabilities,
        --         cargo = {
        --             allFeatures = true,
        --         }
        --     }
        -- end
      }
    })

    -- local cmp_select = { behavior = cmp.SelectBehavior.Select }
    local has_words_before = function()
      local line, col = vim.api.nvim_win_get_cursor(0);
      return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
    end

    cmp.setup({
      preselect = "none",
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      completion = {
        completeopt = "menu,menuone,noinsert,noselect",
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-d>"] = cmp.mapping.scroll_docs(4),
        ["<C-u>"] = cmp.mapping.scroll_docs(-4),
        ['<CR>'] = cmp.mapping.confirm({ select = false }),
        ["<C-f>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(1) then
            require("luasnip").jump(1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ["<C-b>"] = cmp.mapping(function(fallback)
          if require("luasnip").jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif require("luasnip").locally_jumpable(1) then
            require("luasnip").jump(1)
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif require("luasnip").locally_jumpable(-1) then
            require("luasnip").jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
        -- ["<Tab>"] = cmp.mapping(function(fallback)
        --     if cmp.visible() then
        --         cmp.select_next_item()
        --     elseif has_words_before() then
        --         cmp.complete()
        --     else
        --         fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
        --     end
        -- end, { "i", "s" }),
        -- ["<S-Tab>"] = nil,
        ["<C-e>"] = cmp.mapping.abort(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })


    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
