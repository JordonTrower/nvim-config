-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = vim.lsp.config
local lsp_enable = vim.lsp.enable
local servers = { "html", "cssls", "clangd", "lua_ls", "ts_ls", "yamlls", "csharp_ls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig(lsp, {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
    lsp_enable(lsp)
end
-- typescript
lspconfig("rust_analyzer", {
    on_attach = on_attach,
    capabilities = capabilities,
})
lsp_enable "rust_analyzer"

lspconfig("powershell_es", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    bundle_path = "/home/josp/dev-tools/powershell-editor-services/",
})
lsp_enable "powershell_es"

lspconfig("elixirls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "/home/josp/dev-tools/elixir-ls/language_server.sh" },
})
lsp_enable "elixirls"

lspconfig("gdscript", {
    name = "godot",
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})
lsp_enable "gdscript"

lspconfig("nixd", {
    settings = {
        nixd = {
            formatting = {
                command = { "nixfmt" },
            },
        },
    },
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})
lsp_enable "nixd"
