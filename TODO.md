### ⬅️ Research back button control option
Investigate adding a back button to the widget interface to allow users to navigate backward in the ChatGPT webview. Consider implementation options and user experience.

### 📝 Add changelog documentation
Create a CHANGELOG.md file to track notable changes, new features, bug fixes, and version history for the plasmoid. Update it with each release or significant update.

### ❓ Add FAQ section to documentation
Create a Frequently Asked Questions (FAQ) section in the README or a separate FAQ.md file. Cover common user questions about installation, usage, privacy, API keys, troubleshooting, and customization.

# KDE6 Compatibility TODO

This document tracks the progress of making the plasmoid-chatgpt widget compatible with KDE6.

## Priority Issues (Critical for basic functionality)

### 🔧 Update installation method to use kpackagetool6
Replace plasmapkg2 with kpackagetool6 in install.sh and README.md. KDE6 uses kpackagetool6 instead of the old plasmapkg2 tool.

**Files to update:**
- `install.sh`
- `README.md`

### 🔧 Update QtWebEngine import to version 6.x
Change 'import QtWebEngine 1.9' to 'import QtWebEngine 6.x' in main.qml. This is critical as Qt5's QtWebEngine won't work in KDE6/Qt6 environment.

**Files to update:**
- `package/contents/ui/main.qml`

### 🔧 Update Qt and Plasma import versions in main.qml
Update QtQuick 2.2 to 2.15+, org.kde.plasma.* imports from 2.0 to 6.0+, and org.kde.kirigami from 2.19 to newer version compatible with KDE6.

**Files to update:**
- `package/contents/ui/main.qml`

## Secondary Issues

### 🔧 Fix QtQuick.Controls imports in configGeneral.qml
Remove QtQuick.Controls 1.0 import and standardize on QtQuick.Controls 2.15+ only. Update QQC1.SpinBox to QQC2.SpinBox and adjust any related properties.

**Files to update:**
- `package/contents/ui/configGeneral.qml`

### 🔧 Update QtQuick and Kirigami imports in configGeneral.qml
Update QtQuick 2.2 to 2.15+, org.kde.kirigami from 2.9 to KDE6-compatible version, and other plasma imports to version 6.0+.

**Files to update:**
- `package/contents/ui/configGeneral.qml`

### 🔧 Update config.qml import versions
Update QtQuick 2.2 to 2.15+ and org.kde.plasma.configuration from 2.0 to 6.0+ for KDE6 compatibility.

**Files to update:**
- `package/contents/config/config.qml`

### 🔧 Update ChatGPT URL to current endpoint
Change hardcoded URL from 'https://chat.openai.com/chat' to 'https://chatgpt.com/' or 'https://chat.openai.com/' (without /chat suffix) as the old URL is deprecated.

**Files to update:**
- `package/contents/ui/main.qml`

## Testing & Validation

### 🧪 Test plasmoid installation with kpackagetool6
After making changes, test that the plasmoid can be successfully installed using kpackagetool6 --install command on KDE6 system.

### 🧪 Test plasmoid functionality in KDE6
Verify that the plasmoid loads correctly in KDE6, WebEngine view works, configuration dialog opens, and all features (pin, refresh, zoom) function properly.

### 🧪 Update metadata.json if needed for KDE6
Check if metadata.json needs any KDE6-specific updates or version requirements. May need to update API version or add KDE6 compatibility indicators.

**Files to check:**
- `package/metadata.json`


### 🌐 Add localization support
Implement localization (i18n) for the plasmoid and its configuration dialog. Extract user-facing strings and provide translation files for multiple languages. Document how to contribute translations.

**Files to update:**
- All QML and config files with user-facing text
- Add translation infrastructure (e.g., .po/.pot files or Qt Linguist)

## Notes

- Each completed item should be marked with ✅
- Any discovered issues should be added to this list



## Progress

- [x] Update installation method to use kpackagetool6
- [x] Update QtWebEngine import to version 6.x
- [x] Update Qt and Plasma import versions in main.qml
- [x] Fix QtQuick.Controls imports in configGeneral.qml
- [x] Update QtQuick and Kirigami imports in configGeneral.qml
- [x] Update config.qml import versions
- [x] Update ChatGPT URL to current endpoint
- [x] Test plasmoid installation with kpackagetool6
- [x] Test plasmoid functionality in KDE6
- [x] Update metadata.json if needed for KDE6
- [ ] Add localization support
- [ ] Add FAQ section to documentation
- [x] Research back button control option
- [ ] Add changelog documentation

