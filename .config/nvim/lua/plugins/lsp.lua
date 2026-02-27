return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/nvim-cmp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "j-hui/fidget.nvim",
      "b0o/schemastore.nvim",
    },
    config = function()
      local cmp = require('cmp')
      local cmp_lsp = require("cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        cmp_lsp.default_capabilities()
      )

      require("fidget").setup({})
      require("mason").setup({})
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",         -- Lua
          "ts_ls",          -- TypeScript/JavaScript
          "gopls",          -- Go
          "pyright",        -- Python
          "rust_analyzer",  -- Rust
          "clangd",         -- C/C++
          "jsonls",         -- JSON
          "yamlls",         -- YAML
          "html",           -- HTML
          "cssls",          -- CSS
          "tailwindcss",    -- Tailwind CSS
          "dockerls",       -- Docker
          "bashls",         -- Bash
        },
        handlers = {
          function(server_name)
            require("lspconfig")[server_name].setup {
              capabilities = capabilities
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
              }
            }
          end,

          ["ts_ls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.ts_ls.setup {
              capabilities = capabilities,
              settings = {
                typescript = {
                  inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                  }
                },
                javascript = {
                  inlayHints = {
                    includeInlayParameterNameHints = 'all',
                    includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                    includeInlayFunctionParameterTypeHints = true,
                    includeInlayVariableTypeHints = true,
                    includeInlayPropertyDeclarationTypeHints = true,
                    includeInlayFunctionLikeReturnTypeHints = true,
                    includeInlayEnumMemberValueHints = true,
                  }
                }
              }
            }
          end,

          ["gopls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.gopls.setup {
              capabilities = capabilities,
              settings = {
                gopls = {
                  analyses = {
                    unusedparams = true,
                  },
                  staticcheck = true,
                  gofumpt = true,
                }
              }
            }
          end,

          ["pyright"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.pyright.setup {
              capabilities = capabilities,
              settings = {
                python = {
                  analysis = {
                    autoSearchPaths = true,
                    diagnosticMode = "workspace",
                    useLibraryCodeForTypes = true,
                  }
                }
              }
            }
          end,

          ["rust_analyzer"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.rust_analyzer.setup {
              capabilities = capabilities,
              settings = {
                ["rust-analyzer"] = {
                  checkOnSave = {
                    command = "cargo-clippy"
                  },
                  cargo = {
                    allFeatures = true,
                  },
                  procMacro = {
                    enable = true
                  },
                }
              }
            }
          end,

          ["clangd"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.clangd.setup {
              capabilities = capabilities,
              cmd = {
                "clangd",
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--function-arg-placeholders",
                "--fallback-style=llvm",
              },
            }
          end,

          ["jsonls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.jsonls.setup {
              capabilities = capabilities,
              settings = {
                json = {
                  schemas = require('schemastore').json.schemas(),
                  validate = { enable = true },
                },
              },
            }
          end,

          ["yamlls"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.yamlls.setup {
              capabilities = capabilities,
              settings = {
                yaml = {
                  schemaStore = {
                    enable = false,
                    url = "",
                  },
                  schemas = require('schemastore').yaml.schemas(),
                }
              }
            }
          end,

          ["tailwindcss"] = function()
            local lspconfig = require("lspconfig")
            lspconfig.tailwindcss.setup {
              capabilities = capabilities,
              settings = {
                tailwindCSS = {
                  experimental = {
                    classRegex = {
                      "tw`([^`]*)",
                      "tw=\"([^\"]*)",
                      "tw={\"([^\"}]*)",
                      "tw\\.\\w+`([^`]*)",
                      "tw\\(.*?\\)`([^`]*)",
                    },
                  },
                },
              },
            }
          end,
        }
      })

      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      cmp.setup({
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        }, {
          { name = 'buffer' },
        })
      })

      vim.diagnostic.config({
        update_in_insert = true,
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })

      -- LSP keymaps (set on LSP attach)
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
          vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
          vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
          vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
          vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
          vim.keymap.set('n', '<leader>D', vim.lsp.buf.type_definition, opts)
          vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
          vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, opts)
          vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)

          -- Enhanced diagnostics keymaps
          vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
          vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
          vim.keymap.set('n', '<leader>ld', vim.diagnostic.open_float, opts)
          vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, opts)

          -- Inlay hints toggle (for supported servers)
          if vim.lsp.inlay_hint then
            vim.keymap.set('n', '<leader>ih', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, opts)
          end
        end,
      })
    end
  }
}