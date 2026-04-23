return {
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = "Disable" },
            diagnostics = { globals = { "vim" } },
        },
    },
    nixd = {},
    clangd = {
        cmd = {
            "clangd",
            "--compile-commands-dir=build/debug",
            "--background-index",
            "--clang-tidy",
            "--all-scopes-completion",
            "--header-insertion=iwyu",
            "--query-driver=/nix/store/*/bin/*",
        },
    },
    rust_analyzer = {},
    pyright = {},
    tsgo = { cmd = { "tsgo", "--lsp", "--stdio" } },
    biome = {},
    cssls = {},
    texlab = {},
}
