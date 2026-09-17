local ok, blink = pcall(require, "blink.cmp")
if not ok then
    return
end

blink.setup({
    enabled = function()
        return not vim.g.blink_cmp_disabled
            and vim.bo.buftype ~= "prompt"
            and vim.b.completion ~= false
    end,

    keymap = {
        preset = "none",
        ["<CR>"] = { "accept", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-f>"] = { "scroll_documentation_down", "fallback" },
        ["<C-u>"] = { "scroll_documentation_up", "fallback" },
        ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
        ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
    },

    appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = "mono",
    },

    completion = {
        accept = {
            auto_brackets = {
                enabled = true,
            },
        },
        list = {
            selection = {
                preselect = true,
                auto_insert = false,
            },
        },
        menu = {
            border = "none",
            winhighlight = "Normal:BlinkCmpMenu,FloatBorder:BlinkCmpMenuBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
            draw = {
                columns = {
                    { "label", "label_description", gap = 1 },
                    { "kind_icon", "kind", gap = 1 },
                },
            },
        },
        documentation = {
            auto_show = true,
            auto_show_delay_ms = 200,
            window = {
                border = "none",
                winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,CursorLine:BlinkCmpMenuSelection,Search:None",
            },
        },
    },

    sources = {
        default = { "lsp", "path", "snippets", "buffer" },
        providers = {
            buffer = {
                min_keyword_length = 3,
            },
        },
    },
})

-- Matugen-based blink / cmp highlights
local mat_ok, M = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")
if mat_ok then
    vim.api.nvim_set_hl(0, "Pmenu",                  { bg = M.darker, fg = M.fg })
    vim.api.nvim_set_hl(0, "PmenuSel",               { bg = M.telescope_selection_bg, fg = M.fg })
    vim.api.nvim_set_hl(0, "PmenuSbar",              { bg = M.darker })
    vim.api.nvim_set_hl(0, "PmenuThumb",             { bg = M.secondary })

    -- Blink highlight groups
    vim.api.nvim_set_hl(0, "BlinkCmpMenu",            { bg = M.darker, fg = M.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuBorder",      { fg = M.secondary, bg = M.darker })
    vim.api.nvim_set_hl(0, "BlinkCmpMenuSelection",   { bg = M.telescope_selection_bg, fg = M.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpLabel",           { fg = M.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelDeprecated", { fg = M.cursorline_fg, strikethrough = true })
    vim.api.nvim_set_hl(0, "BlinkCmpLabelMatch",      { fg = M.primary, bold = true })
    vim.api.nvim_set_hl(0, "BlinkCmpKind",            { fg = M.secondary })
    vim.api.nvim_set_hl(0, "BlinkCmpDoc",             { bg = M.darker, fg = M.fg })
    vim.api.nvim_set_hl(0, "BlinkCmpDocBorder",       { fg = M.secondary, bg = M.darker })

    -- Compatibility fallback for cmp groups
    vim.api.nvim_set_hl(0, "CmpNormal",              { link = "BlinkCmpMenu" })
    vim.api.nvim_set_hl(0, "CmpBorder",              { link = "BlinkCmpMenuBorder" })
    vim.api.nvim_set_hl(0, "CmpSel",                 { link = "BlinkCmpMenuSelection" })
    vim.api.nvim_set_hl(0, "CmpItemAbbr",            { link = "BlinkCmpLabel" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrDeprecated",  { link = "BlinkCmpLabelDeprecated" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",       { link = "BlinkCmpLabelMatch" })
    vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy",  { link = "BlinkCmpLabelMatch" })
    vim.api.nvim_set_hl(0, "CmpItemKind",            { link = "BlinkCmpKind" })
    vim.api.nvim_set_hl(0, "CmpDoc",                 { link = "BlinkCmpDoc" })
    vim.api.nvim_set_hl(0, "CmpDocBorder",           { link = "BlinkCmpDocBorder" })

    -- Ensure all kind items follow matugen
    local kinds = {
        "Text", "Method", "Function", "Constructor", "Field", "Variable", "Class",
        "Interface", "Module", "Property", "Unit", "Value", "Enum", "Keyword",
        "Snippet", "Color", "File", "Reference", "Folder", "EnumMember",
        "Constant", "Struct", "Event", "Operator", "TypeParameter", "Copilot",
    }
    for _, kind in ipairs(kinds) do
        vim.api.nvim_set_hl(0, "BlinkCmpKind" .. kind, { link = "BlinkCmpKind" })
        vim.api.nvim_set_hl(0, "CmpItemKind" .. kind,  { link = "BlinkCmpKind" })
    end
end
