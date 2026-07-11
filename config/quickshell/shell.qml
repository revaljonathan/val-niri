import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

ShellRoot {
	FloatingWindow {
		// match the system theme background color, but force the alpha channel to 85%
		// to workaround Qt GTK3 theme parsing sometimes setting it to 0% opacity.
		color: Qt.alpha(contentItem.palette.active.window, 0.85)
		width: 400
		height: 500

		ScrollView {
			anchors.fill: parent
			anchors.margins: 16
			contentWidth: availableWidth
			clip: true
			ScrollBar.horizontal.policy: ScrollBar.AlwaysOff

			ColumnLayout {
				width: parent.width
				spacing: 16

				// get a list of nodes that output to the default sink
				PwNodeLinkTracker {
					id: linkTracker
					node: Pipewire.defaultAudioSink
				}

				Label {
					text: "Master Volume"
					font.bold: true
					font.pixelSize: 16
				}

				MixerEntry {
					Layout.fillWidth: true
					node: Pipewire.defaultAudioSink
				}

				Rectangle {
					Layout.fillWidth: true
					Layout.preferredHeight: 1
					color: palette.active.text
					opacity: 0.15
				}

				Label {
					text: "Applications"
					font.bold: true
					font.pixelSize: 16
					visible: linkTracker.linkGroups.length > 0
				}

				Repeater {
					model: linkTracker.linkGroups

					MixerEntry {
						Layout.fillWidth: true
						required property PwLinkGroup modelData
						// Each link group contains a source and a target.
						// Since the target is the default sink, we want the source.
						node: modelData.source
					}
				}
			}
		}
	}
}
