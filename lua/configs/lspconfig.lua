-- EXAMPLE
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls", "clangd", "lua_ls", "ts_ls", "yamlls" }

-- lsps with default config
for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
    }
end
-- typescript
lspconfig.powershell_es.setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    bundle_path = "/home/jtrower/dev-tools/powershell-editor-services/",
}
