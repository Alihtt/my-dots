-- lua/configs/treesitter.lua

local options = {
    ensure_installed = {
        "html",
        "css",
        "javascript",
        "python",
        "typescript",
        "bash",
        -- "django", -- REMOVE THIS LINE: We will add it as a custom parser below
        -- "c",
        -- "cmake",
        -- "cpp",
        "fish",
        "go",
        -- "gomod",
        -- "gosum",
        -- "gotmpl",
        -- "gowork",
        -- "haskell",
        "lua",
        "luadoc",
        -- "make",
        "markdown",
        -- "odin",
        "printf",
        "python",
        "toml",
        "vim",
        "vimdoc",
        "yaml",
    },

    highlight = {
        enable = true,
        use_languagetree = true,
    },

    indent = { enable = true },

    -- Configure injections for Django templates.
    injections = {
        htmldjango = {
            query = "(raw_text) @html",
            filetype = "html",
        },
    },
}

require("nvim-treesitter.configs").setup(options)

-- Auto-set filetype for HTML files that are likely Django templates
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = vim.api.nvim_create_augroup("DjangoHtmlDetection", { clear = true }),
    pattern = {
        "*/templates/*.html", -- Common Django template path
        "*/templates/**/*.html", -- Subdirectories within templates
        "**/admin/**/*.html", -- Django admin templates
        "*.html", -- Generic fallback for other HTML files,
        -- but the `manage.py` check below will refine it.
    },
    callback = function()
        -- Use vim.fs.find for a more reliable check for 'manage.py' in parent directories
        local current_file = vim.fn.expand("<afile>:p")
        local root_dir = vim.fs.find("manage.py", { upward = true, path = current_file })[1] -- [1] gets the first result

        if root_dir then
            vim.bo.filetype = "htmldjango"
        end
    end,
})
