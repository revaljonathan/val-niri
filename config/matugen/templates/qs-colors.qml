    pragma Singleton
    import QtQuick
  
    QtObject {
        readonly property real bgAlpha: 0.9
  
        readonly property color shadow: "{{colors.shadow.default.hex}}"
        readonly property color crust: Qt.alpha("{{colors.surface.default.hex | lighten: -2.5}}", bgAlpha)
        readonly property color base: Qt.alpha("{{colors.surface.default.hex | lighten: 1.5}}", bgAlpha)
        readonly property color container: Qt.alpha("{{colors.surface_container.default.hex}}", bgAlpha)
        readonly property color containerHigh: Qt.alpha("{{colors.surface_container_high.default.hex}}", bgAlpha)
        readonly property color containerHighest: Qt.alpha("{{colors.surface_container_highest.default.hex}}", bgAlpha)
  
        readonly property color outlinevar: "{{colors.outline_variant.default.hex}}"
        readonly property color tertiary: "{{colors.tertiary.default.hex}}"
        readonly property color on_tertiary: "{{colors.on_tertiary.default.hex}}"
        readonly property color outline: "{{colors.outline.default.hex}}"
        readonly property color green: "{{colors.primary.default.hex | set_hue: 90}}"
        readonly property color primary: "{{colors.primary.default.hex}}"
        readonly property color on_primary: "{{colors.on_primary.default.hex}}"
  
        readonly property color fg: "{{colors.on_surface.default.hex}}"
        readonly property color onfg: "{{colors.surface.default.hex}}"
        readonly property color error: "{{colors.error.default.hex}}"
        readonly property color red: "{{colors.primary.default.hex | lighten: -7 | set_hue: 0}}"
        readonly property color yellow: "{{colors.primary.default.hex | lighten: 5 | set_hue: 60}}"
        readonly property color peach: "{{colors.primary.default.hex | lighten: -7 | set_hue: 22}}"
  
        readonly property color border: "{{colors.secondary_container.default.hex}}"
        readonly property color graph: "{{colors.secondary_container.default.hex | lighten: -12.5 }}"
        readonly property color headfoot: Qt.alpha("{{colors.surface.default.hex | lighten: -2.5}}", 0.35)
        readonly property color osd: Qt.alpha("{{colors.surface.default.hex | lighten: 2}}", 0.85)
        readonly property color icons: "{{colors.secondary.default.hex}}"
        readonly property color popupbg: Qt.alpha("{{colors.surface.default.hex | lighten: 1.5}}", 0.95)
        readonly property color darkoverlay: Qt.alpha("{{colors.surface.default.hex | lighten: 1.5}}", 0.35)
    }
