require("catppuccin").setup({
    flavour = "mocha",
    transparent_background = true,
})

vim.cmd.colorscheme("catppuccin")

local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")

if matugen_ok then
    if matugen.cursorline_bg then
        vim.api.nvim_set_hl(0, "CursorLine", { bg = matugen.cursorline_bg })
    end

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
end

vim.cmd("hi Directory guibg=NONE")
vim.cmd("hi SignColumn guibg=NONE")
vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
