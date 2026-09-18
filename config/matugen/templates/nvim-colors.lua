local M = {}

M.bg      = "{{ colors.surface.default.hex | lighten: 4 }}"
M.fg      = "{{ colors.on_surface.default.hex }}"
M.primary = "{{ colors.primary.default.hex }}"
M.secondary = "{{ colors.secondary.default.hex }}"
M.tertiary = "{{ colors.tertiary.default.hex }}"
M.error   = "{{ colors.error.default.hex }}"
M.cursorline_bg = "{{ colors.secondary_container.default.hex | lighten: -3.3 }}"
M.darker = "{{ colors.secondary_container.default.hex | lighten: -6.6 }}"
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

M.branch = "{{ colors.primary.default.hex | set_hue: 90 }}"

M.syn_keyword  = "{{ colors.tertiary.default.hex }}"
M.syn_func     = "{{ colors.primary.default.hex }}"
M.syn_string   = "{{ colors.primary.default.hex | set_hue: 90 }}"
M.syn_type     = "{{ colors.primary.default.hex | set_hue: 45 }}"
M.syn_constant = "{{ colors.primary.default.hex | lighten: -3 | set_hue: 22 }}"
M.syn_comment  = "{{ colors.outline.default.hex }}"
M.syn_variable = "{{ colors.on_surface.default.hex }}"
M.syn_operator = "{{ colors.secondary.default.hex }}"
M.syn_special  = "{{ colors.error.default.hex }}"

return M
