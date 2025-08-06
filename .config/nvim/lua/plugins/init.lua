return {
    -- Tag matching/navigation
    {
        "andymass/vim-matchup",
        event = "VeryLazy",
        config = function()
            vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
    },
    {
        "Bekaboo/dropbar.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.treesitter")
        end,
    },
    {
        "rmagatti/auto-session",
        lazy = false,
        keys = { { "<leader>ls", "<cmd>SessionSearch<CR>", desc = "Session search" } },

        ---enables autocomplete for opts
        ---@module "auto-session"
        opts = {
            suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
            session_lens = {
                load_on_setup = true, -- Initialize on startup (requires Telescope)
                theme_conf = { -- Pass through for Telescope theme options
                    -- layout_config = { -- As one example, can change width/height of picker
                    --   width = 0.8,    -- percent of window
                    --   height = 0.5,
                    -- },
                },
                previewer = false, -- File preview for session picker

                mappings = {
                    -- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
                    delete_session = { "i", "<C-D>" },
                    alternate_session = { "i", "<C-S>" },
                    copy_session = { "i", "<C-Y>" },
                },

                session_control = {
                    control_dir = vim.fn.stdpath("data") .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
                    control_filename = "session_control.json", -- File name of the session control file
                },
            },
            -- log_level = 'debug',
        },
    },
    {
        "github/copilot.vim",
        cmd = {
            "Copilot",
        },
    },
    {
        "Exafunction/codeium.vim",
        cmd = {
            "Codeium",
        },
        config = function()
            -- Map <Tab> to accept Codeium suggestions, fallback to regular <Tab> behavior
            vim.keymap.set("i", "<Tab>", function()
                return vim.fn["codeium#Accept"]() ~= "" and vim.fn["codeium#Accept"]() or "<Tab>"
            end, { expr = true, noremap = true, silent = true })

            -- Optional: Map <C-Space> to manually trigger Codeium suggestions
            vim.keymap.set("i", "<C-Space>", function()
                return vim.fn["codeium#Complete"]()
            end, { expr = true, noremap = true, silent = true })

            -- Optional: Map <C-D> to dismiss suggestions
            vim.keymap.set("i", "<C-D>", function()
                return vim.fn["codeium#Clear"]()
            end, { expr = true, noremap = true, silent = true })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("nvchad.configs.lspconfig").defaults()
            require("configs.lspconfig")
        end,
    },
    {
        "djlint/djLint",
    },
    {
        "mg979/vim-visual-multi",
    },
    {
        "kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = { "nvim-lua/plenary.nvim" },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>lg", "<cmd>LazyGit<cr>", desc = "Open lazy git" },
        },
    },

    {
        "williamboman/mason-lspconfig.nvim",
        event = "VeryLazy",
        dependencies = { "nvim-lspconfig" },
        config = function()
            require("configs.mason-lspconfig")
        end,
    },

    {
        "mfussenegger/nvim-lint",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("configs.lint")
        end,
    },
    {
        "CopilotC-Nvim/CopilotChat.nvim",
        dependencies = {
            { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
            { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
        },
        build = "make tiktoken", -- Only on MacOS or Linux
        opts = {
            -- See Configuration section for options
        },
        keys = {
            { "<leader>cc", "<cmd>CopilotChat<CR>", desc = "Open Copilot Chat" },
            { "<leader>cq", "<cmd>CopilotChatQuick<CR>", mode = "v", desc = "Copilot Chat Quick (Visual)" },
            { "<leader>ce", "<cmd>CopilotChatExplain<CR>", desc = "Copilot Chat Explain" },
            { "<leader>cr", "<cmd>CopilotChatReview<CR>", desc = "Copilot Chat Review" },
            { "<leader>cf", "<cmd>CopilotChatFix<CR>", desc = "Copilot Chat Fix" },
        },
    },
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        config = function()
            require("configs.conform")
        end,
    },

    {
        "zapling/mason-conform.nvim",
        event = "VeryLazy",
        dependencies = { "conform.nvim" },
        config = function()
            require("configs.mason-conform")
        end,
    },
    {
        "karb94/neoscroll.nvim",
        event = "WinScrolled",
        config = function()
            require("neoscroll").setup({
                -- All these are defaults, you can tweak as needed
                mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
                hide_cursor = true,
                stop_eof = true,
                respect_scrolloff = false,
                cursor_scrolls_alone = true,
                easing_function = "sine",
                pre_hook = nil,
                post_hook = nil,
                performance_mode = false,
            })
        end,
    },

    {
        "folke/flash.nvim",
        event = "VeryLazy",
        opts = {},
        -- stylua: ignore
        keys = {
            { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
            { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
            { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
            { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
            { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
        },
    },
}
