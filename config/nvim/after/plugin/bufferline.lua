local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

local highlights = {}
if matugen_ok then
    highlights = {
        fill = { bg = "NONE" },
        background = { bg = "NONE", fg = matugen.fg },
        buffer_selected = {
            fg = matugen.primary,
            bg = "NONE",
            bold = true,
            italic = true,
        },
        buffer_visible = { bg = "NONE", fg = matugen.secondary },
        separator = { fg = matugen.bg, bg = "NONE" },
        separator_selected = { fg = matugen.bg, bg = "NONE" },
        separator_visible = { fg = matugen.bg, bg = "NONE" },
        indicator_selected = { fg = matugen.primary, bg = "NONE" },
        modified_selected = { fg = matugen.primary, bg = "NONE" },
    }
else
    highlights = {
        fill = { bg = '#181825' },
        background = { bg = '#181825' },
        buffer_selected = {
            fg = '#cdd6f4',
            bg = '#181825',
            bold = true,
            italic = true,
        },
        buffer_visible = { bg = '#1e2030' },
        separator = { fg = '#1e2030', bg = '#1e2030' },
        separator_selected = { fg = '#1e2030', bg = '#181825' },
        separator_visible = { fg = '#1e2030', bg = '#1e2030' },
        indicator_selected = { fg = '#89b4fa', bg = '#181825' },
        modified_selected = { fg = '#89b4fa', bg = '#181825' },
    }
end

require("bufferline").setup({
    options = {
        mode = "buffers",
        offsets = {
            {
                filetype = "NvimTree",
                text = "File Explorer",
                text_align = "left",
                separator = true
            }
        },
        color_icons = true,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        persist_buffer_sort = true,
        enforce_regular_tabs = false,
        always_show_bufferline = false,
        sort_by = 'id',
    },
    highlights = highlights
})
