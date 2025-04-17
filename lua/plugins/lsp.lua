return {
    -- Mason: LSP / DAP / Linter / Formatter manager
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = true,
    },

    -- Mason-lspconfig: Bridge between Mason and lspconfig
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
        },
    },

    -- LSP Configuration
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            -- Add LSP progress status
            "j-hui/fidget.nvim",
        },
    },

    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",  -- Fixed capitalization here
            "saadparwaiz1/cmp_luasnip",
            "rafamadriz/friendly-snippets",
        },
    },
}
