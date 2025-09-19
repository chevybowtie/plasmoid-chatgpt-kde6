#!/bin/bash

# Uninstall the plasmoid by its plugin name
PLUGIN_ID="com.chevybowtie.chatgpt"

kpackagetool6 --remove "$PLUGIN_ID"

if [ $? -eq 0 ]; then
  echo "ChatGPT plasmoid uninstalled successfully."
else
  echo "Uninstall failed. See error messages above."
fi
