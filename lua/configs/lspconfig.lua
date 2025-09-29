-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = vim.lsp.config
local servers = { "html", "cssls", "clangd", "lua_ls", "ts_ls", "yamlls", "rust_analyzer", "csharp_ls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig(lsp, {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    })
end
-- typescript
lspconfig("powershell_es", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    bundle_path = "/home/josp/dev-tools/powershell-editor-services/",
})

lspconfig("elixirls", {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    cmd = { "/home/josp/dev-tools/elixir-ls/language_server.sh" },
})

lspconfig("gdscript", {
    name = "godot",
    cmd = vim.lsp.rpc.connect("127.0.0.1", 6005),
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
})
