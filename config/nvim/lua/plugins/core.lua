return {
    -- ── Shared dependencies ────────────────────────────────────────────────
    { "nvim-lua/plenary.nvim",       lazy = true },
    { "nvim-tree/nvim-web-devicons", lazy = true },

    -- ── Treesitter ─────────────────────────────────────────────────────────
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "nvim-treesitter/nvim-treesitter-context",
        },
        init = function()
            vim.filetype.add({ extension = { goon = "goon" } })
        end,
        opts = {
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query",
                "go", "javascript", "nix", "php", "rust",
                "zig", "java", "python", "bash",
                "markdown", "markdown_inline",
            },
            sync_install = false,
            auto_install = true,
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                    },
                },
            },
        },
        config = function(_, opts)
            require("nvim-treesitter").setup(opts)

            require("treesitter-context").setup({
                enable = true,
                max_lines = 1,
                trim_scope = "outer",
            })
        end,
    },

    -- ── Autocompletion ─────────────────────────────────────────────────────
    {
        "saghen/blink.cmp",
        version = "*",
        dependencies = {
            "rafamadriz/friendly-snippets",
        },
        -- setup handled in after/plugin/completion.lua
    },

    -- ── Autopairs ──────────────────────────────────────────────────────────
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        opts = { check_ts = true },
    },

    -- ── Telescope ──────────────────────────────────────────────────────────
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",
        config = function()
            local actions = require("telescope.actions")
            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = {
                            ["<C-k>"] = actions.move_selection_previous,
                            ["<C-j>"] = actions.move_selection_next,
                            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
                        },
                    },
                },
            })

            local builtin = require("telescope.builtin")
            vim.keymap.set("n", "<leader>ff", builtin.find_files)
            vim.keymap.set("n", "<leader>fo", builtin.oldfiles)
            vim.keymap.set("n", "<leader>fq", builtin.quickfix)
            vim.keymap.set("n", "<leader>fh", builtin.help_tags,   { desc = "Help tags" })
            vim.keymap.set("n", "<leader>fm", function()
                builtin.man_pages({ sections = { "ALL" } })
            end, { desc = "Man pages" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,     { desc = "Buffers" })
            vim.keymap.set("n", "<leader>fg", function()
                builtin.grep_string({ search = vim.fn.input("Grep > ") })
            end)
            vim.keymap.set("n", "<leader>fc", function()
                builtin.grep_string({ search = vim.fn.expand("%:t:r") })
            end, { desc = "Find current file" })
            vim.keymap.set("n", "<leader>fs", function()
                builtin.grep_string({})
            end, { desc = "Find current string" })
            vim.keymap.set("n", "<leader>fi", function()
                builtin.find_files({ cwd = "~/.config/nvim/" })
            end, { desc = "Find in nvim config" })
        end,
    },

    -- ── Harpoon ────────────────────────────────────────────────────────────
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>a",  function() harpoon:list():add() end)
            vim.keymap.set("n", "<C-e>",      function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
            vim.keymap.set("n", "<C-p>",      function() harpoon:list():prev() end)
            vim.keymap.set("n", "<C-n>",      function() harpoon:list():next() end)

            -- Browse harpoon list in Telescope
            vim.keymap.set("n", "<leader>fl", function()
                local conf = require("telescope.config").values
                local themes = require("telescope.themes")
                local file_paths = {}
                for _, item in ipairs(harpoon:list().items) do
                    table.insert(file_paths, item.value)
                end
                require("telescope.pickers").new(themes.get_ivy({ prompt_title = "Working List" }), {
                    finder   = require("telescope.finders").new_table({ results = file_paths }),
                    previewer = conf.file_previewer({}),
                    sorter   = conf.generic_sorter({}),
                }):find()
            end, { desc = "Harpoon list (Telescope)" })
        end,
    },

    -- ── File explorer ──────────────────────────────────────────────────────
    {
        "nvim-tree/nvim-tree.lua",
        cmd = { "NvimTreeToggle", "NvimTreeFocus" },
        init = function()
            -- must disable netrw before nvim-tree loads
            vim.g.loaded_netrw       = 1
            vim.g.loaded_netrwPlugin = 1
        end,
        -- setup handled in after/plugin/nvim-tree.lua
    },

    -- ── Utilities ──────────────────────────────────────────────────────────
    { "brenoprata10/nvim-highlight-colors", event = "VeryLazy", opts = {} },
    { "tpope/vim-fugitive",                 cmd = { "Git", "G" } },
    { "mbbill/undotree",                    cmd = "UndotreeToggle" },
    { "ojroques/vim-oscyank",               event = "VeryLazy" },
    {
        "captbaritone/better-indent-support-for-php-with-html",
        ft = { "php", "html" },
    },
}
