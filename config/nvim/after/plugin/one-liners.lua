local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

if matugen_ok then
    local theme = {
        normal = {
            a = { fg = matugen.bg, bg = matugen.primary, gui = "bold" },
            b = { fg = matugen.fg, bg = "NONE" },
            c = { fg = matugen.fg, bg = matugen.cursorline_bg },
            x = { fg = matugen.fg, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },

        },
        insert = {
            a = { fg = matugen.bg, bg = matugen.secondary, gui = "bold" },
            b = { fg = matugen.secondary, bg = "NONE" },
            c = { fg = matugen.fg, bg = matugen.cursorline_bg },
            x = { fg = matugen.fg, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
        },
        visual = {
            a = { fg = matugen.bg, bg = matugen.fg, gui = "bold" },
            b = { fg = matugen.fg, bg = "NONE" },
            c = { fg = matugen.fg, bg = matugen.cursorline_bg },
            x = { fg = matugen.fg, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
        },
        replace = {
            a = { fg = matugen.bg, bg = matugen.error, gui = "bold" },
            b = { fg = matugen.error, bg = "NONE" },
            c = { fg = matugen.fg, bg = matugen.cursorline_bg },
            x = { fg = matugen.fg, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
        },
        inactive = {
            a = { fg = matugen.fg, bg = matugen.bg },
            b = { fg = matugen.fg, bg = matugen.bg },
            c = { fg = matugen.fg, bg = matugen.cursorline_bg },
            x = { fg = matugen.fg, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
        },
    }

    require("lualine").setup({
        options = {
            theme = theme,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
        sections = {
lualine_c = {
    {
        "filename",
        path = 0,       
        symbols = {
            modified = "●",
            readonly = "",
            unnamed = "[No Name]",
        },
    },
},
    lualine_a = { "mode" },
    lualine_b = { "" },
    lualine_x = { "fileformat", "filetype" },
    lualine_y = { "progress" },
    lualine_z = { "location" },
    }
    })
else
    require("lualine").setup({ options = { theme = "auto" } })
end

require("nvim-highlight-colors").setup({})
