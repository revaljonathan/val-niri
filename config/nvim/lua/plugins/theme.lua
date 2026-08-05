return {
    -- ── Colorscheme ────────────────────────────────────────────────────────
    {
        "catppuccin/nvim",
        name = "catppuccin",
        priority = 1000,
        config = function()
            require("catppuccin").setup({
                flavour = "mocha",
                transparent_background = true,
            })
            vim.cmd.colorscheme("catppuccin")

            -- keep transparency consistent
            vim.cmd("hi Directory guibg=NONE")
            vim.cmd("hi SignColumn guibg=NONE")
            vim.api.nvim_set_hl(0, "Normal",      { bg = "none" })
            vim.api.nvim_set_hl(0, "NormalFloat",  { bg = "none" })
            vim.api.nvim_set_hl(0, "LineNr",       { bg = "none" })
            vim.api.nvim_set_hl(0, "CursorLine",   { bg = "#313245" })
        end,
    },

    -- ── Bufferline ─────────────────────────────────────────────────────────
    {
        "akinsho/bufferline.nvim",
        event = "VeryLazy",
        opts = {
            options = {
                themable              = true,
                mode                  = "buffers",
                offsets               = {
                    { filetype = "NvimTree", text = "File Explorer", text_align = "left", separator = true },
                },
                color_icons           = true,
                show_buffer_icons     = true,
                show_buffer_close_icons = false,
                show_close_icon       = false,
                persist_buffer_sort   = true,
                enforce_regular_tabs  = false,
                always_show_bufferline = false,
                sort_by               = "id",
            },
        },
    },

    -- ── Statusline ─────────────────────────────────────────────────────────
    {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        config = function()
            local ok, palettes = pcall(require, "catppuccin.palettes")
            if not ok then
                require("lualine").setup({ options = { theme = "auto" } })
                return
            end

            local colors = palettes.get_palette() or palettes.get_palette("mocha")
            local NONE   = "NONE"
            local bg     = colors.base
            local fg     = colors.text
            local primary    = colors.blue
            local secondary  = colors.mauve
            local tertiary   = colors.peach
            local error_col  = colors.red
            local surface    = colors.surface0

            local theme = {
                normal  = {
                    a = { fg = bg,  bg = primary,   gui = "bold" },
                    b = { fg = fg,  bg = surface },
                    c = { fg = primary, bg = NONE },
                    x = { fg = primary, bg = surface },
                    y = { fg = fg,  bg = surface },
                    z = { fg = bg,  bg = primary },
                },
                insert  = {
                    a = { fg = bg,  bg = tertiary,  gui = "bold" },
                    b = { fg = secondary, bg = NONE },
                    c = { fg = primary,   bg = NONE },
                    x = { fg = primary,   bg = surface },
                    y = { fg = fg,  bg = surface },
                    z = { fg = bg,  bg = tertiary },
                },
                visual  = {
                    a = { fg = bg,  bg = secondary, gui = "bold" },
                    b = { fg = fg,  bg = NONE },
                    c = { fg = primary, bg = NONE },
                    x = { fg = primary, bg = surface },
                    y = { fg = fg,  bg = surface },
                    z = { fg = bg,  bg = secondary },
                },
                replace = {
                    a = { fg = bg,  bg = error_col, gui = "bold" },
                    b = { fg = error_col, bg = NONE },
                    c = { fg = primary,   bg = NONE },
                    x = { fg = primary,   bg = surface },
                    y = { fg = fg,  bg = surface },
                    z = { fg = bg,  bg = error_col },
                },
                inactive = {
                    a = { fg = fg,  bg = bg },
                    b = { fg = fg,  bg = bg },
                    c = { fg = primary, bg = NONE },
                    x = { fg = primary, bg = surface },
                    y = { fg = fg,  bg = surface },
                    z = { fg = fg,  bg = bg },
                },
            }

            require("lualine").setup({
                options = {
                    theme = theme,
                    component_separators = { left = "", right = "|" },
                    section_separators   = { left = "", right = "" },
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "" },
                    lualine_c = {
                        {
                            "filename",
                            path = 1,
                            color = { fg = fg, bg = surface },
                            symbols = { modified = "●", readonly = "✘", unnamed = "[No Name]" },
                        },
                    },
                    lualine_x = {
                        { "fileformat", color = { fg = fg, bg = surface } },
                        { "filetype",   color = { fg = fg, bg = surface } },
                        { "progress",   color = { fg = fg, bg = surface } },
                    },
                    lualine_y = {},
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
