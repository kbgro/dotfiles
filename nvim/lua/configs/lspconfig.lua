-- =====================================================================================
-- LSP Configuration
-- =====================================================================================

local M = {}

-- ======================
-- 🔑 Keymaps
-- ======================
M.on_attach = function(event)
  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if not client then
    return
  end

  local bufname = vim.api.nvim_buf_get_name(event.buf)
  if client.name == 'bashls' and bufname:match '/%.env' then
    client.stop()
    return
  end

  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    vim.keymap.set(mode, keys, func, {
      buffer = event.buf,
      desc = 'LSP: ' .. desc,
    })
  end

  map('gD', vim.lsp.buf.declaration, 'Go to declaration')
  map('gd', vim.lsp.buf.definition, 'Go to definition')
  map('gI', vim.lsp.buf.implementation, 'Go to implementation')
  map('<leader>D', vim.lsp.buf.type_definition, 'Type definition')

  map('<leader>rn', vim.lsp.buf.rename, 'Rename')
  map('<leader>ca', vim.lsp.buf.code_action, 'Code Action', { 'n', 'x' })

  map('K', vim.lsp.buf.hover, 'Hover docs')
  map('<leader>lf', function()
    vim.lsp.buf.format { async = true }
  end, 'Format file')
end

-- ======================
-- ⚙️ Capabilities
-- ======================
M.capabilities = vim.lsp.protocol.make_client_capabilities()

local ok_cmp, cmp_lsp = pcall(require, 'cmp_nvim_lsp')
if ok_cmp then
  M.capabilities = cmp_lsp.default_capabilities(M.capabilities)
end

-- ======================
-- 🚀 Setup
-- ======================
M.defaults = function()
  -- ✅ Keymaps via LspAttach
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(event)
      M.on_attach(event)
    end,
  })

  -- ✅ Mason
  require('mason').setup {
    registries = {
      'github:Crashdummyy/mason-registry',
      'github:mason-org/mason-registry',
    },
  }

  require('mason-lspconfig').setup {
    ensure_installed = {
      'lua_ls',
      'pyright',
      'ts_ls',
      'bashls',
      'jsonls',
    },
  }

  -- ======================
  -- 🧠 Native LSP configs
  -- ======================

  -- Lua
  vim.lsp.config('lua_ls', {
    capabilities = M.capabilities,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT' },
        diagnostics = { globals = { 'vim' } },
        workspace = {
          library = {
            vim.fn.expand '$VIMRUNTIME/lua',
            vim.fn.stdpath 'data' .. '/lazy/lazy.nvim/lua/lazy',
          },
        },
      },
    },
  })

  vim.lsp.config('clangd', {
    cmd = {
      'clangd',
      '--compile-commands-dir=' .. vim.fn.getcwd() .. '/build', -- change if compile_commands.json isn't in cwd
    },
    capabilities = M.capabilities,
  })

  require('roslyn').setup {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }

  -- Other servers (simple setup)
  local servers = { 'pyright', 'ts_ls', 'bashls', 'jsonls' }

  for _, server in ipairs(servers) do
    vim.lsp.config(server, {
      capabilities = M.capabilities,
    })
  end

  -- ======================
  -- 🚀 Enable all servers
  -- ======================
  vim.lsp.enable {
    'lua_ls',
    'pyright',
    'ts_ls',
    'bashls',
    'jsonls',
    'roslyn',
  }
end

return M
