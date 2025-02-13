return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre", -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    {
        "neovim/nvim-lspconfig",
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require "configs.lspconfig"
        end,
    },

    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                "lua-language-server",
                "stylua",
                "html-lsp",
                "css-lsp",
                "prettier",
            },
        },
    },

    {
        "nvchad/ui",
        config = function()
            require "nvchad"
        end,
    },

    {
        "nvchad/base46",
        lazy = true,
        build = function()
            require("base46").load_all_highlights()
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            auto_install = true,
            ensure_installed = {
                "vim",
                "lua",
                "vimdoc",
                "html",
                "css",
                "typescript",
                "javascript",
                "java",
                "jsdoc",
                "c_sharp",
                "powershell",
            },
        },
    },
}
