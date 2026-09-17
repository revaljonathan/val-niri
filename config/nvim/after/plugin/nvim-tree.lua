-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- empty setup using defaults
require("nvim-tree").setup({
  sort = {
    sorter = "case_sensitive",
  },
  view = {
    width = 30,
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

local matugen_ok, matugen = pcall(dofile, vim.fn.stdpath("config") .. "/after/plugin/matugen_colors.lua")
if matugen_ok and matugen.bg then
    vim.api.nvim_set_hl(0, "NvimTreeStatuslineNc", { fg = matugen.bg, bg = matugen.bg })
    vim.api.nvim_set_hl(0, "NvimTreeStatusLine",   { fg = matugen.bg, bg = matugen.bg })
end
