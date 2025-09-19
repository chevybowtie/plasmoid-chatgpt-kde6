import QtQuick 2.15
import QtQuick.Controls 2.15 as QQC2
import QtQuick.Layouts 1.15

import org.kde.plasma.core as PlasmaCore
import org.kde.kirigami as Kirigami
import org.kde.plasma.components as PlasmaComponents3

Kirigami.FormLayout {
  id: page

  property string cfg_icon
  property alias cfg_zoomFactor: zoomFactor.value
  property alias cfg_darkMode: darkModeCheckBox.checked

  property int commonIconSize: PlasmaCore.Units.iconSizes.smallMedium

  Layout.fillWidth: true

  Item {
    Kirigami.FormData.label: i18n("Behavior")
    Kirigami.FormData.isSection: true
  }

  ColumnLayout {
    RowLayout {
      QQC2.Label {
        text: i18n("Zoom Factor:")
      }

      QQC2.SpinBox {
        id: zoomFactor
        from: 50
        to: 300
        value: 100
        stepSize: 5
        
        property int decimals: 2
        
        textFromValue: function(value, locale) {
          return Number(value / 100).toLocaleString(locale, 'f', zoomFactor.decimals)
        }
        
        valueFromText: function(text, locale) {
          return Number.fromLocaleString(locale, text) * 100
        }

        QQC2.ToolTip.visible: hovered
        QQC2.ToolTip.text: i18n("Zoom factor uses to scale the plasmoid")
      }
    }
    
    RowLayout {
      QQC2.CheckBox {
        id: darkModeCheckBox
        text: i18n("Enable dark mode (experimental)")
        
        QQC2.ToolTip.visible: hovered
        QQC2.ToolTip.text: i18n("Apply dark theme styling to ChatGPT interface")
      }
    }
  }

  Kirigami.Separator {
    Layout.fillWidth: true
    Kirigami.FormData.isSection: true
  }

  Item {
    Kirigami.FormData.label: i18n("Appearance")
    Kirigami.FormData.isSection: true
  }


  ColumnLayout {
    RowLayout {
      QQC2.Label {
        text: i18n("Plasmoid Icon:")
      }

      RowLayout {
        QQC2.TextField {
          id: iconNameField
          placeholderText: i18n("Icon name (e.g., go-jump)")
          text: cfg_icon
          onTextChanged: cfg_icon = text
          
          QQC2.ToolTip.visible: hovered
          QQC2.ToolTip.text: i18n("Enter icon name for plasmoid")
        }
        
        Kirigami.Icon {
          source: cfg_icon
          width: commonIconSize
          height: commonIconSize
        }
      }

      QQC2.Button {
        QQC2.ToolTip.visible: hovered
        QQC2.ToolTip.text: i18n("Set default icon for plasmoid")

        icon.name: "edit-clear"
        icon.width: commonIconSize
        icon.height: commonIconSize

        onClicked: {
          iconNameField.text = "go-jump"
          cfg_icon = "go-jump"
        }
      }
    }
  }
}
