local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

if matugen_ok then
    local theme = {
        normal = {
            a = { fg = matugen.bg, bg = matugen.primary, gui = "bold" },
            b = { fg = matugen.primary, bg = matugen.cursorline_bg },
            c = { fg = matugen.primary, bg = NONE },
            x = { fg = matugen.primary, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
            z = { fg = matugen.bg, bg = matugen.primary },
        },
        insert = {
            a = { fg = matugen.bg, bg = matugen.tertiary, gui = "bold" },
            b = { fg = matugen.tertiary, bg = matugen.cursorline_bg },
            c = { fg = matugen.tertiary, bg = NONE },
            x = { fg = matugen.tertiary, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
            z = { fg = matugen.bg, bg = matugen.tertiary },
        },
        visual = {
            a = { fg = matugen.bg, bg = matugen.fg, gui = "bold" },
            b = { fg = matugen.secondary, bg = matugen.cursorline_bg },
            c = { fg = matugen.secondary, bg = NONE},
            x = { fg = matugen.secondary, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
            z = { fg = matugen.bg, bg = matugen.fg },
        },
        replace = {
            a = { fg = matugen.bg, bg = matugen.error, gui = "bold" },
            b = { fg = matugen.error, bg = "NONE" },
            c = { fg = matugen.primary, bg = NONE },
            x = { fg = matugen.primary, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
            z = { fg = matugen.bg, bg = matugen.error },
        },
        inactive = {
            a = { fg = matugen.fg, bg = matugen.bg },
            b = { fg = matugen.fg, bg = matugen.bg },
            c = { fg = matugen.primary, bg = NONE },
            x = { fg = matugen.primary, bg = matugen.cursorline_bg },
            y = { fg = matugen.fg, bg = matugen.cursorline_bg },
            z = { fg = matugen.fg, bg = matugen.bg },
        },
    }


    require("lualine").setup({
        options = {
            theme = theme,
            component_separators = { left = "|", right = "|" },
            section_separators = { left = "", right = "" },
        },
        sections = {
            lualine_a = { "mode" },
            lualine_b = {
                { "branch", color = { fg = matugen.branch, bg = matugen.cursorline_bg } },
                {
                    "filename",
                    path = 0,
                    color = { fg = matugen.fg, bg = matugen.cursorline_bg },
                    symbols = {
                        modified = "●",
                        readonly = "✘",
                        unnamed = "[No Name]",
                    },
                },
            },
            lualine_c = {},
            lualine_x = {
                { "fileformat", 
                color = { fg = matugen.fg, bg = matugen.cursorline_bg  },
                symbols = {
                    unix = "unix",  
                    dos = "DOS",         
                    mac = "Mac",    
                },
            },
                { "filetype", color = { fg = matugen.fg, bg = matugen.cursorline_bg  } },
                { "progress", color = { fg = matugen.fg, bg = matugen.cursorline_bg  } },
            },
            lualine_y = {},
            lualine_z = { "location" },
        }
    })
else
    require("lualine").setup({ options = { theme = "auto" } })
end

require("nvim-highlight-colors").setup({})
