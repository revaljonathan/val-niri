local M = {}

M.bg      = "{{ colors.surface.default.hex | lighten: 4 }}"
M.fg      = "{{ colors.on_surface.default.hex }}"
M.primary = "{{ colors.primary.default.hex }}"
M.secondary = "{{ colors.secondary.default.hex }}"
M.tertiary = "{{ colors.tertiary.default.hex }}"
M.error   = "{{ colors.error.default.hex }}"
M.cursorline_bg = "{{ colors.surface_variant.default.hex | lighten: -3 }}"
M.cursorline_fg = "{{ colors.on_surface_variant.default.hex }}"

M.telescope_border        = "{{ colors.outline.default.hex }}"
M.telescope_prompt_border = "{{ colors.primary.default.hex }}"
M.telescope_prompt_title  = "{{ colors.primary.default.hex }}"
M.telescope_selection_bg  = "{{ colors.primary_container.default.hex }}"
M.telescope_selection_fg  = "{{ colors.on_primary_container.default.hex }}"

M.tree_folder        = "{{ colors.primary.default.hex }}"
M.tree_folder_open   = "{{ colors.tertiary.default.hex }}"
M.tree_indent_marker = "{{ colors.outline_variant.default.hex }}"
M.tree_root          = "{{ colors.secondary.default.hex }}"

return M
