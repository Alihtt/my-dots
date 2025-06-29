local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- list of all servers configured.
-- ADD 'emmet_ls' and 'tailwindcss' here.
lspconfig.servers = {
    "lua_ls",
    -- "clangd",
    "gopls",
    -- "hls",
    -- "ols",
    "pyright",
    "emmet_ls", -- NEW: For Emmet functionality like .container
    "tailwindcss", -- NEW: For Tailwind CSS class suggestions
}

-- list of servers configured with default config.
local default_servers = {
    -- "ols",
    "gopls",
    "pyright",
    -- Add emmet_ls and tailwindcss here to use default setup
    "emmet_ls",
    "tailwindcss",
}

-- lsps with default config
for _, lsp in ipairs(default_servers) do
    lspconfig[lsp].setup({
        on_attach = on_attach,
        on_init = on_init,
        capabilities = capabilities,
        -- Pass filetypes specifically for emmet_ls and tailwindcss if they are default_servers
        -- otherwise, configure them below with their specific setups.
        -- For emmet_ls and tailwindcss, it's better to explicitly define them below for filetype control.
    })
end

-- Explicitly setup emmet_ls for filetype control
lspconfig.emmet_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "css", "javascript", "typescript", "jsx", "tsx" }, -- Crucially include htmldjango
    init_options = {
        html = {
            defaultAttributes = {
                ["div"] = { ["class"] = "" },
            },
        },
    },
})

-- Explicitly setup tailwindcss for filetype control
lspconfig.tailwindcss.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
    filetypes = { "html", "htmldjango", "css", "javascript", "typescript", "jsx", "tsx" }, -- Crucially include htmldjango
    -- If your tailwind.config.js is not in the project root, specify it
    -- settings = {
    --   tailwindCSS = {
    --     config = "tailwind.config.js",
    --   },
    -- },
})

-- lspconfig.clangd.setup({
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--     on_init = on_init,
--     capabilities = capabilities,
-- })

-- lspconfig.gopls.setup({
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--     on_init = on_init,
--     capabilities = capabilities,
--     cmd = { "gopls" },
--     filetypes = { "go", "gomod", "gotmpl", "gowork" },
--     root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
--     settings = {
--         gopls = {
--             analyses = {
--                 unusedparams = true,
--             },
--             completeUnimported = true,
--             usePlaceholders = true,
--             staticcheck = true,
--         },
--     },
-- })

-- lspconfig.hls.setup({
--     on_attach = function(client, bufnr)
--         client.server_capabilities.documentFormattingProvider = false
--         client.server_capabilities.documentRangeFormattingProvider = false
--         on_attach(client, bufnr)
--     end,
--
--     on_init = on_init,
--     capabilities = capabilities,
-- })

lspconfig.lua_ls.setup({
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,

    settings = {
        Lua = {
            diagnostics = {
                enable = false, -- Disable all diagnostics from lua_ls
                -- globals = { "vim" },
            },
            workspace = {
                library = {
                    vim.fn.expand("$VIMRUNTIME/lua"),
                    vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
                    vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
                    vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
                    "${3rd}/love2d/library",
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
        },
    },
})
