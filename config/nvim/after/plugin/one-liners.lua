local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

if matugen_ok then
    local theme = {
        normal = {
            a = { fg = matugen.bg, bg = matugen.primary, gui = "bold" },
            b = { fg = matugen.primary, bg = "NONE" },
            c = { fg = matugen.fg, bg = "NONE" },
        },
        insert = {
            a = { fg = matugen.bg, bg = matugen.secondary, gui = "bold" },
            b = { fg = matugen.secondary, bg = "NONE" },
        },
        visual = {
            a = { fg = matugen.bg, bg = matugen.fg, gui = "bold" },
            b = { fg = matugen.fg, bg = "NONE" },
        },
        replace = {
            a = { fg = matugen.bg, bg = matugen.error, gui = "bold" },
            b = { fg = matugen.error, bg = "NONE" },
        },
        inactive = {
            a = { fg = matugen.fg, bg = matugen.bg },
            b = { fg = matugen.fg, bg = matugen.bg },
            c = { fg = matugen.fg, bg = "NONE" },
        },
    }

    require("lualine").setup({
        options = {
            theme = theme,
            component_separators = { left = "", right = "" },
            section_separators = { left = "", right = "" },
        },
    })
else
    require("lualine").setup({ options = { theme = "auto" } })
end

require("nvim-highlight-colors").setup({})
