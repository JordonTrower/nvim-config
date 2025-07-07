return {
    {
        "mfussenegger/nvim-jdtls",
        event = "BufRead *.ftl,*.java,*.jsp",
        dependencies = {
            "mfussenegger/nvim-dap",
        },
        config = function()
            require "configs.jdtls"
        end,
    },

    {
        "mfussenegger/nvim-dap",
        config = function()
            require "configs.dap"
        end,
    },

    {
        "rcarriga/nvim-dap-ui",
        dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    },

    {
        "kdheepak/lazygit.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        },
        cmd = "LazyGit",
        config = function()
            require("telescope").load_extension "lazygit"
        end,
    },

    {
        "chentoast/marks.nvim",
        event = "VeryLazy",
        opts = {},
        config = function()
            require "marks"
        end,
    },

    {
        "kylechui/nvim-surround",
        event = "VeryLazy",
        opts = {},
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "html-lsp",
                "css-lsp",
                "csharp-language-server",
                "java-language-server",
                "eslint-lsp",
                "json-lsp",
                "yaml-language-server",
                "powershell-editor-services",
                "typescript-language-server",
                -- Formatters
                "prettier",
                -- linter
                "stylua",
                "eslint_d",
                "chrome-debug-adapter",
                "java-debug-adapter",
            },
        },
    },
}
