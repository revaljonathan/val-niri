import QtQuick
import QtQuick.Layouts
import QtQuick.Controls
import Quickshell.Services.Pipewire

ColumnLayout {
	required property PwNode node;

	// bind the node so we can read its properties
	PwObjectTracker { objects: [ node ] }
	
	spacing: 4

	RowLayout {
		Layout.fillWidth: true
		spacing: 12

		Image {
			visible: source != ""
			source: {
				const icon = node.properties["application.icon-name"] ?? "audio-volume-high-symbolic";
				return `image://icon/${icon}`;
			}
			sourceSize.width: 24
			sourceSize.height: 24
		}

		Label {
			Layout.fillWidth: true
			elide: Text.ElideRight
			font.weight: Font.DemiBold
			text: {
				// application.name -> description -> name
				const app = node.properties["application.name"] ?? (node.description != "" ? node.description : node.name);
				const media = node.properties["media.name"];
				return media != undefined ? `${app} - ${media}` : app;
			}
		}

		Button {
			icon.name: node.audio.muted ? "audio-volume-muted-symbolic" : "audio-volume-high-symbolic"
			display: AbstractButton.IconOnly
			flat: true
			onClicked: node.audio.muted = !node.audio.muted
			
			ToolTip.visible: hovered
			ToolTip.text: node.audio.muted ? "Unmute" : "Mute"
		}
	}

	RowLayout {
		Layout.fillWidth: true
		spacing: 12

		Slider {
			Layout.fillWidth: true
			value: node.audio.volume
			onValueChanged: node.audio.volume = value
		}

		Label {
			Layout.preferredWidth: 45
			horizontalAlignment: Text.AlignRight
			text: `${Math.floor(node.audio.volume * 100)}%`
			font.family: "monospace"
		}
	}
}
