local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

local theme

if matugen_ok then
    local NONE = "NONE"
    local bg   = matugen.bg
    local fg   = matugen.fg

    theme = {
        normal = {
            a = { fg = bg, bg = matugen.primary,   gui = "bold" },
            b = { fg = fg, bg = matugen.cursorline_bg },
            c = { fg = matugen.primary, bg = NONE },
            x = { fg = matugen.primary, bg = matugen.cursorline_bg },
            y = { fg = fg, bg = matugen.cursorline_bg },
            z = { fg = bg, bg = matugen.primary },
        },
        insert = {
            a = { fg = bg, bg = matugen.tertiary,  gui = "bold" },
            b = { fg = matugen.secondary, bg = NONE },
            c = { fg = matugen.primary,   bg = NONE },
            x = { fg = matugen.primary,   bg = matugen.cursorline_bg },
            y = { fg = fg, bg = matugen.cursorline_bg },
            z = { fg = bg, bg = matugen.tertiary },
        },
        visual = {
            a = { fg = bg, bg = matugen.secondary, gui = "bold" },
            b = { fg = fg, bg = NONE },
            c = { fg = matugen.primary, bg = NONE },
            x = { fg = matugen.primary, bg = matugen.cursorline_bg },
            y = { fg = fg, bg = matugen.cursorline_bg },
            z = { fg = bg, bg = matugen.secondary },
        },
        replace = {
            a = { fg = bg, bg = matugen.error,    gui = "bold" },
            b = { fg = matugen.error, bg = NONE },
            c = { fg = matugen.primary,   bg = NONE },
            x = { fg = matugen.primary,   bg = matugen.cursorline_bg },
            y = { fg = fg, bg = matugen.cursorline_bg },
            z = { fg = bg, bg = matugen.error },
        },
        inactive = {
            a = { fg = fg, bg = bg },
            b = { fg = fg, bg = bg },
            c = { fg = matugen.primary, bg = NONE },
            x = { fg = matugen.primary, bg = matugen.cursorline_bg },
            y = { fg = fg, bg = matugen.cursorline_bg },
            z = { fg = fg, bg = bg },
        },
    }
else
    -- fallback: catppuccin mocha palette
    local ok, palettes = pcall(require, "catppuccin.palettes")
    if ok then
        local colors  = palettes.get_palette() or palettes.get_palette("mocha")
        local NONE    = "NONE"
        local bg      = colors.base
        local fg      = colors.text
        local primary = colors.blue
        local surface = colors.surface0

        theme = {
            normal  = {
                a = { fg = bg, bg = primary,      gui = "bold" },
                b = { fg = fg, bg = surface },
                c = { fg = primary, bg = NONE },
                x = { fg = primary, bg = surface },
                y = { fg = fg, bg = surface },
                z = { fg = bg, bg = primary },
            },
            insert  = {
                a = { fg = bg, bg = colors.peach, gui = "bold" },
                b = { fg = colors.mauve, bg = NONE },
                c = { fg = primary, bg = NONE },
                x = { fg = primary, bg = surface },
                y = { fg = fg, bg = surface },
                z = { fg = bg, bg = colors.peach },
            },
            visual  = {
                a = { fg = bg, bg = colors.mauve, gui = "bold" },
                b = { fg = fg, bg = NONE },
                c = { fg = primary, bg = NONE },
                x = { fg = primary, bg = surface },
                y = { fg = fg, bg = surface },
                z = { fg = bg, bg = colors.mauve },
            },
            replace = {
                a = { fg = bg, bg = colors.red,   gui = "bold" },
                b = { fg = colors.red, bg = NONE },
                c = { fg = primary, bg = NONE },
                x = { fg = primary, bg = surface },
                y = { fg = fg, bg = surface },
                z = { fg = bg, bg = colors.red },
            },
            inactive = {
                a = { fg = fg, bg = bg },
                b = { fg = fg, bg = bg },
                c = { fg = primary, bg = NONE },
                x = { fg = primary, bg = surface },
                y = { fg = fg, bg = surface },
                z = { fg = fg, bg = bg },
            },
        }
    else
        theme = "auto"
    end
end

local fg = matugen_ok and matugen.fg or "NONE"
local surface = matugen_ok and matugen.cursorline_bg or "NONE"

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
