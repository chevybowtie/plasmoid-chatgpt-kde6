import QtQuick 2.15
import QtQuick.Layouts 1.15

import org.kde.plasma.plasmoid
import org.kde.plasma.core as PlasmaCore
import org.kde.plasma.extras as PlasmaExtras
import org.kde.plasma.components as PlasmaComponents
import org.kde.kirigami as Kirigami

import QtWebEngine

PlasmoidItem {
  id: root

  property bool pinned: false;
  property int focusTimerInterval: 100;
  // Keep popup open when pinned using built-in behavior
  hideOnWindowDeactivate: !root.pinned




  // Let Plasma handle representation switching; just define compact+full.
  // (Removed custom preferredRepresentation logic to allow expansion popup to work.)
  Plasmoid.icon: plasmoid.configuration.icon

  // Compact representation: simple icon button that toggles expanded state
  compactRepresentation: PlasmaComponents.ToolButton {
    id: compactButton
    icon.name: plasmoid.configuration.icon || "braindump"
    Accessible.name: i18n("ChatGPT")
    onClicked: root.expanded = !root.expanded

  }

  fullRepresentation: ColumnLayout {
    anchors.fill: parent
    // Provide explicit size hints for popup mode
    implicitWidth: 600
    implicitHeight: 800

  Layout.minimumWidth: 320
  Layout.minimumHeight: 480
  Layout.preferredWidth: implicitWidth
  Layout.preferredHeight: implicitHeight

    Timer {
      id: focusTimer
      interval: root.focusTimerInterval
      running: false

      onTriggered: {
        chatGptWebView.forceActiveFocus();
        chatGptWebView.focus = true;
        chatGptWebView.runJavaScript(`
          const promptInput = document.querySelector('#prompt-textarea');
          if (promptInput) {
            promptInput.focus();
          }
        `);
      }
    }

    Connections {
      target: root
      function onExpandedChanged() {
        if (root.expanded && chatGptWebView.loadProgress === 100) {
          focusTimer.start();
        }
      }
    }



    Connections {
      target: plasmoid.configuration

      function onDarkModeChanged() {
        // Apply or remove dark mode CSS based on configuration change
        var toggleDarkModeJS = `
          if (${plasmoid.configuration.darkMode}) {
            // Apply dark mode
            const injectDarkModeCSS = () => {
              const darkModeCSS = \`
                /* Force dark background for main containers */
                body, html {
                  background-color: #1a1a1a !important;
                  color: #e0e0e0 !important;
                }
                
                /* Main chat interface */
                main, [role="main"], .flex.flex-col.h-full {
                  background-color: #1a1a1a !important;
                }
                
                /* Chat messages container */
                .flex-1.overflow-hidden, .overflow-y-auto {
                  background-color: #1a1a1a !important;
                }
                
                /* Individual message containers */
                .group\\/conversation-turn, .group, .w-full {
                  background-color: #1a1a1a !important;
                }
                
                /* User messages */
                .bg-\\[\\#f4f4f4\\], .bg-gray-50 {
                  background-color: #2d2d2d !important;
                  color: #e0e0e0 !important;
                }
                
                /* Assistant messages */
                .bg-white, .bg-\\[\\#ffffff\\] {
                  background-color: #1a1a1a !important;
                  color: #e0e0e0 !important;
                }

                header {
                  background-color: #2a2a2a !important;
                }
                
                /* Text content */
                .text-gray-900, .text-black, .text-page-header {
                  color: #e0e0e0 !important;
                }
                
                .text-gray-700, .text-gray-800 {
                  color: #b0b0b0 !important;
                }
                
                /* Input area */
                #prompt-textarea, textarea {
                  background-color: #2d2d2d !important;
                  color: #e0e0e0 !important;
                  border-color: #404040 !important;
                }
                
                /* Input container */
                .bg-\\[\\#f4f4f4\\], .bg-gray-100 {
                  background-color: #2d2d2d !important;
                }
                
                /* Buttons */
                button {
                  background-color: #2d2d2d !important;
                  color: #e0e0e0 !important;
                  border-color: #404040 !important;
                }
                
                /* Send button */
                [data-testid="send-button"] {
                  background-color: #0084ff !important;
                }
                
                /* Sidebar */
                .bg-\\[\\#f9f9f9\\], .bg-gray-50, nav {
                  background-color: #252525 !important;
                  color: #e0e0e0 !important;
                }
                
                /* Links */
                a {
                  color: #4a9eff !important;
                }
                
                /* Code blocks */
                pre, code {
                  background-color: #23272e !important;
                  color: #fffae3 !important;
                  border-radius: 4px !important;
                  font-family: "Fira Mono", "Consolas", "Monaco", monospace !important;
                  padding: 2px 6px !important;
                }
                
                .prose {
                  color: #e0e0e0 !important;
                }
                
                .prose h1, .prose h2, .prose h3, .prose h4, .prose h5, .prose h6 {
                  color: #ffffff !important;
                }
                /* Bold text */
                strong, b {
                  color: #e0e0e0 !important;
                }
              \`;
              
              // Remove existing dark mode style if present
              const existingStyle = document.getElementById('plasmoid-dark-mode');
              if (existingStyle) {
                existingStyle.remove();
              }
              
              // Inject the CSS
              const style = document.createElement('style');
              style.id = 'plasmoid-dark-mode';
              style.textContent = darkModeCSS;
              document.head.appendChild(style);
            };
            injectDarkModeCSS();
          } else {
            // Remove dark mode CSS
            const existingStyle = document.getElementById('plasmoid-dark-mode');
            if (existingStyle) {
              existingStyle.remove();
            }
          }
        `;
        
        if (chatGptWebView.loadProgress === 100) {
          chatGptWebView.runJavaScript(toggleDarkModeJS);
        }
      }
    }



    PlasmaExtras.PlasmoidHeading {
      Layout.fillWidth: true

      RowLayout {
        anchors.fill: parent
        spacing: Kirigami.Units.mediumSpacing


        Kirigami.Heading {
          Layout.fillWidth: true
          text: i18n("ChatGPT")
          color: Kirigami.Theme.textColor
        }



        PlasmaComponents.ToolButton {
          text: i18n("Back")
          icon.name: "go-previous"
          display: PlasmaComponents.ToolButton.IconOnly
          PlasmaComponents.ToolTip.text: text
          PlasmaComponents.ToolTip.delay: Kirigami.Units.toolTipDelay
          PlasmaComponents.ToolTip.visible: hovered
          enabled: chatGptWebView.canGoBack
          onClicked: chatGptWebView.goBack()
        }

        PlasmaComponents.ToolButton {
          text: i18n("Refresh")
          icon.name: "view-refresh"
          display: PlasmaComponents.ToolButton.IconOnly
          PlasmaComponents.ToolTip.text: text
          PlasmaComponents.ToolTip.delay: Kirigami.Units.toolTipDelay
          PlasmaComponents.ToolTip.visible: hovered
          onClicked: chatGptWebView.reload()
        }

        PlasmaComponents.ToolButton {
          // Use icon change instead of checked highlight
          checkable: false
          icon.name: root.pinned ? "window-pin" : "window-unpin"
          text: root.pinned ? i18n("Unpin") : i18n("Pin")
          display: PlasmaComponents.ToolButton.IconOnly
          PlasmaComponents.ToolTip.delay: Kirigami.Units.toolTipDelay
          PlasmaComponents.ToolTip.visible: hovered
          onClicked: root.pinned = !root.pinned
          PlasmaComponents.ToolTip.text: root.pinned ? i18n("Pinned: stay open when focus changes") : i18n("Pin to keep open when switching windows")
        }
      }
    }

    ColumnLayout {
      WebEngineView {
        id: chatGptWebView

        Layout.fillWidth: true
        Layout.fillHeight: true

        url: "https://chatgpt.com"
        focus: true
        zoomFactor: plasmoid.configuration.zoomFactor

        profile: WebEngineProfile {
          id: chatGptProfile

          storageName: "chatgpt"
          offTheRecord: false
          httpCacheType: WebEngineProfile.DiskHttpCache
          persistentCookiesPolicy: WebEngineProfile.ForcePersistentCookies
        }

        onLoadingChanged: function(loadRequest) {
          if (loadRequest.status === WebEngineView.LoadSucceededStatus) {
            // Inject our custom JavaScript and CSS for dark mode
            var jsCode = `
              // Dark mode CSS injection
              const injectDarkModeCSS = () => {
                const darkModeCSS = \`
                  /* Force dark background for main containers */
                  body, html {
                    background-color: #1a1a1a !important;
                    color: #e0e0e0 !important;
                  }
                  
                  /* Main chat interface */
                  main, [role="main"], .flex.flex-col.h-full {
                    background-color: #1a1a1a !important;
                  }
                  
                  /* Chat messages container */
                  .flex-1.overflow-hidden, .overflow-y-auto {
                    background-color: #1a1a1a !important;
                  }
                  
                  /* Individual message containers */
                  .group\\/conversation-turn, .group, .w-full {
                    background-color: #1a1a1a !important;
                  }
                  
                  /* User messages */
                  .bg-\\[\\#f4f4f4\\], .bg-gray-50 {
                    background-color: #2d2d2d !important;
                    color: #e0e0e0 !important;
                  }
                  
                  /* Assistant messages */
                  .bg-white, .bg-\\[\\#ffffff\\] {
                    background-color: #1a1a1a !important;
                    color: #e0e0e0 !important;
                  }
                  
                  /* Text content */
                  .text-gray-900, .text-black {
                    color: #e0e0e0 !important;
                  }
                  
                  .text-gray-700, .text-gray-800 {
                    color: #b0b0b0 !important;
                  }
                  
                  /* Input area */
                  #prompt-textarea, textarea {
                    background-color: #2d2d2d !important;
                    color: #e0e0e0 !important;
                    border-color: #404040 !important;
                  }
                  
                  /* Input container */
                  .bg-\\[\\#f4f4f4\\], .bg-gray-100 {
                    background-color: #2d2d2d !important;
                  }
                  
                  /* Buttons */
                  button {
                    background-color: #2d2d2d !important;
                    color: #e0e0e0 !important;
                    border-color: #404040 !important;
                  }
                  
                  /* Send button */
                  [data-testid="send-button"] {
                    background-color: #0084ff !important;
                  }
                  
                  /* Sidebar */
                  .bg-\\[\\#f9f9f9\\], .bg-gray-50, nav {
                    background-color: #252525 !important;
                    color: #e0e0e0 !important;
                  }
                  
                  /* Links */
                  a {
                    color: #4a9eff !important;
                  }
                  
                  /* Code blocks */
                  pre, code {
                    background-color: #2d2d2d !important;
                    color: #e0e0e0 !important;
                  }
                  
                  /* Markdown content */
                  .prose {
                    color: #e0e0e0 !important;
                  }
                  
                  .prose h1, .prose h2, .prose h3, .prose h4, .prose h5, .prose h6 {
                    color: #ffffff !important;
                  }
                \`;
                
                // Remove existing dark mode style if present
                const existingStyle = document.getElementById('plasmoid-dark-mode');
                if (existingStyle) {
                  existingStyle.remove();
                }
                
                // Inject the CSS
                const style = document.createElement('style');
                style.id = 'plasmoid-dark-mode';
                style.textContent = darkModeCSS;
                document.head.appendChild(style);
              };
              
              const getPromptInput = () => document.querySelector('#prompt-textarea');
              
              const tryToFocusPromptInput = () => {
                const promptInput = getPromptInput();
                if (!promptInput) {
                  return;
                }
                promptInput.focus();
              }
              
              const onPromptInputKeydown = (event) => {
                const promptInput = event.target;
                if (promptInput.value.trim().length < 0) {
                  return
                }
                if (event.ctrlKey && event.key === 'Enter') {
                  const sendButton = document.querySelector('[data-testid="send-button"]');
                  if (!sendButton) {
                    return;
                  }
                  sendButton.click();
                }
              }
              
              // Conditionally inject dark mode CSS if enabled
              if (` + plasmoid.configuration.darkMode + `) {
                injectDarkModeCSS();
                
                // Re-inject CSS when new content is loaded (for dynamic content)
                const observer = new MutationObserver(() => {
                  injectDarkModeCSS();
                });
                
                observer.observe(document.body, { childList: true, subtree: true });
              }
              
              // Set up event listeners
              setTimeout(() => {
                const promptInput = getPromptInput();
                if (promptInput) {
                  promptInput.addEventListener('keydown', onPromptInputKeydown);
                }
                tryToFocusPromptInput();
                // Re-inject CSS after initial load if dark mode is enabled
                if (` + plasmoid.configuration.darkMode + `) {
                  injectDarkModeCSS();
                }
              }, 1000);
            `;
            chatGptWebView.runJavaScript(jsCode);
            
            // Force focus on the prompt input
            chatGptWebView.forceActiveFocus();
          }
        }

        onNavigationRequested: {
          const currentUrl = chatGptWebView.url.toString();
          // Only allow external links to be opened from the chat pages
          // ChatGPT chat page's URL example: https://chatgpt.com/c/uuid or https://chat.openai.com/c/uuid
          if (!currentUrl.startsWith("https://chatgpt.com/c") && !currentUrl.startsWith("https://chat.openai.com/c")) {
            return;
          }

          const requestedUrl = request.url.toString();
          if (requestedUrl.includes("openai.com") || requestedUrl.includes("chatgpt.com")) {
            request.action = WebEngineView.AcceptRequest;
          } else {
            request.action = WebEngineView.IgnoreRequest;

            Qt.openUrlExternally(request.url);
          }
        }

        onJavaScriptConsoleMessage: {
          // Silently handle console messages
        }
      }
    }
  }
}
