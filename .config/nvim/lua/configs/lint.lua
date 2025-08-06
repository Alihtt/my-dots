local lint = require("lint")

lint.linters_by_ft = {
    lua = { "luacheck" },
    -- haskell = { "hlint" },
    python = { "flake8" },
    htmldjango = { "djlint" },
    html = { "djlint" },
}

lint.linters.luacheck.args = {
    unpack(lint.linters.luacheck.args),
    "--globals",
    "love",
    "vim",
}
vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
    callback = function()
        lint.try_lint()
    end,
})
