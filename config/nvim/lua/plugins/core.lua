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
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-buffer",
            "windwp/nvim-autopairs", -- so autopairs can hook into cmp here
        },
        config = function()
            local cmp = require("cmp")

            cmp.setup({
                preselect = cmp.PreselectMode.Item,
                completion = {
                    completeopt = "menu,menuone,noinsert",
                    autocomplete = { cmp.TriggerEvent.TextChanged },
                },
                window = { documentation = cmp.config.window.bordered() },
                mapping = cmp.mapping.preset.insert({
                    ["<CR>"]    = cmp.mapping.confirm({ select = false }),
                    ["<C-e>"]   = cmp.mapping.abort(),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-n>"]   = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-p>"]   = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
                    ["<C-f>"]   = cmp.mapping.scroll_docs(4),
                    ["<C-u>"]   = cmp.mapping.scroll_docs(-4),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then cmp.select_next_item() else fallback() end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function()
                        if cmp.visible() then cmp.select_prev_item() end
                    end, { "i", "s" }),
                }),
                sources = {
                    { name = "nvim_lsp" },
                    { name = "path" },
                    { name = "buffer", keyword_length = 3 },
                },
            })

            -- autopairs cmp integration
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
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
        config = function()
            require("nvim-tree").setup({
                sort     = { sorter = "case_sensitive" },
                view     = { width = 30 },
                renderer = { group_empty = true },
                filters  = { dotfiles = false },
            })
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
        end,
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
