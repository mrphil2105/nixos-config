return {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
        library = {
            { path = "snacks.nvim", words = { "Snacks" } },
            { path = "/run/current-system/sw/share/hypr/stubs", words = { "hl" } },
        },
        integrations = { cmp = false },
    },
}
