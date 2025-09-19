# ChatGPT widget for KDE Plasma

This is a widget for KDE Plasma that allows you to use ChatGPT from your desktop.

**Note:** This version is updated for KDE6/Plasma 6 compatibility.

## Attribution

This project was originally created by [aliheym](https://github.com/aliheym). The original project has been updated and is now maintained by chevybowtie (https://github.com/chevybowtie) to ensure continued KDE6/Plasma 6 compatibility.

This widget opens the chatgpt.com web client inside a Plasma panel/desktop widget. This project is not affiliated with or endorsed by OpenAI

**Original project:** https://github.com/Aliheym/plasmoid-chatgpt

## Requirements

- KDE Plasma 6.0 or later
- Qt 6.5+
- QtWebEngine
- Internet connection for ChatGPT access

## Quick Start

1. **Install the widget**:
   ```bash
   git clone https://github.com/chevybowtie/plasmoid-chatgpt-kde6.git
   cd plasmoid-chatgpt-kde6
   kpackagetool6 --type Plasma/Applet --install ./package
   ```

2. **Add to your desktop**:
   - Right-click on desktop → "Add Widget"
   - Search for "ChatGPT" and add it

3. **Start using**:
   - The widget will show the ChatGPT interface
   - Log in with your OpenAI account
   - Start chatting!

4. **Configure (optional)**:
   - Right-click desktop → "Enter Edit Mode"
   - Click the settings icon on the ChatGPT widget
   - Enable dark mode, adjust zoom, change icon

## Example

<p align="center">
   <img src="assets/example.webp" alt="ChatGPT widget example" width="600" />
</p>

## Installation

### using `kpackagetool6`

Clone this repository and install the widget using `kpackagetool6`.

```bash
git clone https://github.com/chevybowtie/plasmoid-chatgpt-kde6.git
cd plasmoid-chatgpt-kde6
kpackagetool6 --type Plasma/Applet --install ./package
```

### Manual Installation

Alternatively, you can manually install by copying the package to your local KDE directory:

```bash
cp -r ./package ~/.local/share/plasma/plasmoids/com.chevybowtie.chatgpt/
```

## Features

- [x] **Full ChatGPT web interface** - Complete ChatGPT experience in a desktop widget
- [x] **Dark mode toggle** - Apply dark theme styling to the ChatGPT interface
- [x] **Zoom factor control** - Scale the interface from 50% to 300%
- [x] **Customizable icon** - Set any system icon for the widget
- [x] **Ctrl + Enter shortcuts** - Send messages with keyboard shortcut
- [x] **External link handling** - Open links in default browser
- [x] **Session persistence** - Maintains login state and conversation history
- [x] **KDE Plasma 6 compatibility** - Full support for latest KDE Plasma

## Configuration

To configure the widget:
1. **Desktop widget**: Right-click desktop → "Enter Edit Mode" → Click settings icon on widget
2. **Panel widget**: Right-click widget → "Configure ChatGPT for KDE Plasma..."

### Available Settings:
- **Dark Mode**: Toggle dark theme for better integration with dark desktop themes
- **Zoom Factor**: Adjust interface scaling (50% - 300%)
- **Icon**: Customize widget icon (enter icon name, e.g., "go-jump", "applications-internet")

## Usage

1. **Add to Desktop**: Right-click desktop → "Add Widget" → Search for "ChatGPT" → Add widget
2. **Add to Panel**: Right-click panel → "Add Widget" → Search for "ChatGPT" → Add widget
3. **Login**: Click the widget to open ChatGPT and log in with your OpenAI account
4. **Configure**: Enter edit mode (desktop) or right-click (panel) to access settings

The widget displays the full ChatGPT web interface, allowing you to chat, access GPTs, upload files, and use all ChatGPT features directly from your desktop.

## Upgrading from Previous Versions

If you have an older version installed:

```bash
# Remove old version
kpackagetool6 --type Plasma/Applet --remove com.chevybowtie.chatgpt

# Install new version
kpackagetool6 --type Plasma/Applet --install ./package
```

## Troubleshooting

### Widget not appearing after installation
1. **Restart Plasma Shell**:
   ```bash
   systemctl --user restart plasma-plasmashell.service
   ```
2. **Check installation**: Look for "ChatGPT" in the widget list when adding widgets
3. **Verify installation path**: Widget should be in `~/.local/share/plasma/plasmoids/com.chevybowtie.chatgpt/`

### Configuration dialog is blank or won't open
- This usually indicates a compatibility issue
- Try restarting Plasma Shell (command above)
- Check system requirements (KDE Plasma 6.0+, Qt 6.5+)

### ChatGPT doesn't load or shows blank page
1. **Check internet connection**
2. **Verify QtWebEngine is installed**:
   ```bash
   # On Debian/Ubuntu:
   sudo apt install qt6-webengine-dev
   
   # On Fedora:
   sudo dnf install qt6-qtwebengine-devel
   
   # On Arch:
   sudo pacman -S qt6-webengine
   ```
3. **Clear web cache**: Remove and re-add the widget

### Dark mode not working
- Dark mode applies custom CSS to ChatGPT's interface
- It may take a few seconds to apply after enabling
- Try refreshing the widget using the refresh button in the widget header

### Performance issues
- Reduce zoom factor if the widget feels slow
- The widget uses QtWebEngine, so performance depends on your system's web browsing capabilities
- Close other web browsers if experiencing memory issues

## Uninstalling

```bash
kpackagetool6 --type Plasma/Applet --remove com.chevybowtie.chatgpt
```

## Support

For issues and feature requests:
- **GitHub Issues**: https://github.com/chevybowtie/plasmoid-chatgpt-kde6/issues
- **Original Project**: https://github.com/Aliheym/plasmoid-chatgpt

When reporting issues, please include:
- KDE Plasma version (`plasma-desktop --version`)
- Qt version (`qmake --version`)
- Operating system and version
- Steps to reproduce the issue
