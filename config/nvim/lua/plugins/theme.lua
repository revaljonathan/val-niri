return {
    -- ── Colorscheme ────────────────────────────────────────────────────────
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        -- setup handled in after/plugin/colors.lua
    },

    -- ── Bufferline ─────────────────────────────────────────────────────────
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        -- setup handled in after/plugin/bufferline.lua
    },

    -- ── Statusline ─────────────────────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        -- setup handled in after/plugin/lualine.lua
    },
}
