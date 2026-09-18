require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
    integrations = {
        cmp = false,
        blink_cmp = false,
    },
})

vim.cmd.colorscheme("catppuccin")

local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

if matugen_ok then
    if matugen.cursorline_bg then
        vim.api.nvim_set_hl(0, "CursorLine", { bg = matugen.cursorline_bg })
    end

    vim.api.nvim_set_hl(0, "CursorLineNr", { fg = matugen.primary, bold = true })
    vim.api.nvim_set_hl(0, "LineNr", { fg = matugen.telescope_border, bg = "none" })

    -- Telescope Highlights
    if matugen.telescope_border then
        vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = matugen.telescope_border })
        vim.api.nvim_set_hl(0, "TelescopePromptBorder", { fg = matugen.telescope_prompt_border or matugen.primary })
        vim.api.nvim_set_hl(0, "TelescopePromptTitle", { fg = matugen.telescope_prompt_title or matugen.primary, bold = true })
        vim.api.nvim_set_hl(0, "TelescopeSelection", { bg = matugen.telescope_selection_bg, fg = matugen.telescope_selection_fg })
    end

    -- NvimTree Highlights
    if matugen.tree_folder then
        vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = matugen.tree_folder, bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = matugen.tree_folder_open or matugen.tree_folder, bold = true })
        vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = matugen.tree_indent_marker or matugen.cursorline_bg })
        vim.api.nvim_set_hl(0, "NvimTreeRootFolder", { fg = matugen.tree_root or matugen.error, bold = true })
    end

    if matugen.darker then
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = matugen.darker })
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = matugen.darker })

        vim.api.nvim_set_hl(0, "Visual", { bg = matugen.darker })
        vim.api.nvim_set_hl(0, "VisualNOS", { bg = matugen.darker })
        vim.api.nvim_set_hl(0, "RenderMarkdownCode", { bg = matugen.darker })
        vim.api.nvim_set_hl(0, "RenderMarkdownCodeInline", { bg = matugen.darker })
    end
end

vim.cmd("hi Directory guibg=NONE")
vim.cmd("hi SignColumn guibg=NONE")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })

-- Syntax Theme Toggling (Matugen vs Catppuccin Mocha)
local function apply_syntax_palette(c)
    local groups = {
        -- Standard Vim syntax
        Comment        = { fg = c.comment, italic = true },
        Constant       = { fg = c.constant },
        String         = { fg = c.string },
        Character      = { fg = c.string },
        Number         = { fg = c.constant },
        Boolean        = { fg = c.constant },
        Float          = { fg = c.constant },
        Identifier     = { fg = c.variable },
        Function       = { fg = c.func },
        Statement      = { fg = c.keyword },
        Conditional    = { fg = c.keyword },
        Repeat         = { fg = c.keyword },
        Label          = { fg = c.keyword },
        Operator       = { fg = c.operator },
        Keyword        = { fg = c.keyword },
        Exception      = { fg = c.keyword },
        PreProc        = { fg = c.special },
        Include        = { fg = c.keyword },
        Define         = { fg = c.special },
        Macro          = { fg = c.special },
        PreCondit      = { fg = c.special },
        Type           = { fg = c.type },
        StorageClass   = { fg = c.keyword },
        Structure      = { fg = c.type },
        Typedef        = { fg = c.type },
        Special        = { fg = c.special },
        SpecialChar    = { fg = c.special },
        Tag            = { fg = c.func },
        Delimiter      = { fg = c.operator },
        SpecialComment = { fg = c.comment, italic = true },
        Debug          = { fg = c.special },

        -- Treesitter syntax
        ["@comment"]               = { fg = c.comment, italic = true },
        ["@comment.documentation"] = { fg = c.comment, italic = true },
        ["@string"]                = { fg = c.string },
        ["@string.regex"]          = { fg = c.special },
        ["@string.escape"]         = { fg = c.special },
        ["@string.special"]        = { fg = c.special },
        ["@character"]             = { fg = c.string },
        ["@character.special"]     = { fg = c.special },
        ["@number"]                = { fg = c.constant },
        ["@number.float"]          = { fg = c.constant },
        ["@boolean"]               = { fg = c.constant },
        ["@constant"]              = { fg = c.constant },
        ["@constant.builtin"]      = { fg = c.constant },
        ["@constant.macro"]        = { fg = c.constant },
        ["@function"]              = { fg = c.func },
        ["@function.builtin"]      = { fg = c.func },
        ["@function.call"]         = { fg = c.func },
        ["@function.method"]       = { fg = c.func },
        ["@function.method.call"]  = { fg = c.func },
        ["@function.macro"]        = { fg = c.func },
        ["@constructor"]           = { fg = c.func },
        ["@keyword"]               = { fg = c.keyword },
        ["@keyword.function"]      = { fg = c.keyword },
        ["@keyword.return"]        = { fg = c.keyword },
        ["@keyword.conditional"]   = { fg = c.keyword },
        ["@keyword.repeat"]        = { fg = c.keyword },
        ["@keyword.import"]        = { fg = c.keyword },
        ["@keyword.coroutine"]     = { fg = c.keyword },
        ["@keyword.operator"]      = { fg = c.keyword },
        ["@type"]                  = { fg = c.type },
        ["@type.builtin"]          = { fg = c.type },
        ["@type.definition"]       = { fg = c.type },
        ["@type.qualifier"]        = { fg = c.keyword },
        ["@variable"]              = { fg = c.variable },
        ["@variable.builtin"]      = { fg = c.special },
        ["@variable.parameter"]    = { fg = c.param or c.variable },
        ["@variable.member"]       = { fg = c.prop or c.variable },
        ["@property"]              = { fg = c.prop or c.variable },
        ["@field"]                 = { fg = c.prop or c.variable },
        ["@operator"]              = { fg = c.operator },
        ["@punctuation.delimiter"] = { fg = c.operator },
        ["@punctuation.bracket"]   = { fg = c.operator },
        ["@punctuation.special"]   = { fg = c.special },
        ["@tag"]                   = { fg = c.func },
        ["@tag.attribute"]         = { fg = c.type },
        ["@tag.delimiter"]         = { fg = c.operator },
    }

    for name, opts in pairs(groups) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

local function set_syntax_theme(mode, notify)
    local m_ok, m = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")
    if not m_ok then return end

    if mode == "matugen" then
        if m.syn_keyword then
            apply_syntax_palette({
                keyword  = m.syn_keyword,
                func     = m.syn_func,
                string   = m.syn_string,
                type     = m.syn_type,
                constant = m.syn_constant,
                comment  = m.syn_comment,
                variable = m.syn_variable,
                operator = m.syn_operator,
                special  = m.syn_special,
            })
            vim.g.syntax_mode = "matugen"
            if notify then
                vim.notify("Syntax theme: Matugen", vim.log.levels.INFO)
            end
        end
    else
        local cp_ok, cp = pcall(function()
            return require("catppuccin.palettes").get_palette("mocha")
        end)
        if cp_ok and cp then
            apply_syntax_palette({
                keyword  = cp.mauve,
                func     = cp.blue,
                string   = cp.green,
                type     = cp.yellow,
                constant = cp.peach,
                comment  = cp.overlay2,
                variable = cp.text,
                operator = cp.sky,
                special  = cp.pink,
                param    = cp.maroon,
                prop     = cp.lavender,
            })
        end
        vim.g.syntax_mode = "catmocha"
        if notify then
            vim.notify("Syntax theme: Catppuccin Mocha", vim.log.levels.INFO)
        end
    end
end

_G.toggle_syntax_theme = function()
    if vim.g.syntax_mode == "matugen" then
        set_syntax_theme("catmocha", true)
    else
        set_syntax_theme("matugen", true)
    end
end

-- Initialize with preserved mode or default to catmocha
vim.g.syntax_mode = vim.g.syntax_mode or "catmocha"
if vim.g.syntax_mode == "matugen" then
    set_syntax_theme("matugen", false)
end

