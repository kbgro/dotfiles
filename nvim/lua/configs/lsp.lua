-- LSP
--

local lsp_servers = require("configs.lsp_servers")

require("mason").setup({
  registries = {
    "github:Crashdummyy/mason-registry",
    "github:mason-org/mason-registry",
  },
})

require("mason-lspconfig").setup({
  ensure_installed = lsp_servers,
})

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = {
          vim.env.VIMRUNTIME,
        },
      },
    },
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, {
        buffer = event.buf,
        desc = "LSP: " .. desc,
      })
    end

    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
    map("n", "gI", vim.lsp.buf.implementation, "Go to implementation")
    map("n", "<leader>D", vim.lsp.buf.type_definition, "Type definition")

    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename")
    map({ "n", "x" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")

    map("n", "K", vim.lsp.buf.hover, "Hover docs")

    map("n", "<leader>lf", function()
      vim.lsp.buf.format({ async = true })
    end, "Format file")
  end,
})
