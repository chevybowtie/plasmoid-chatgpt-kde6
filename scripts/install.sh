#!/bin/bash

# Clone and install the plasmoid from the official repository
TMPDIR=$(mktemp -d)
git clone https://github.com/chevybowtie/plasmoid-chatgpt-kde6.git "$TMPDIR/plasmoid-chatgpt-kde6" && \
  kpackagetool6 --install "$TMPDIR/plasmoid-chatgpt-kde6/package"

if [ $? -eq 0 ]; then
  echo "ChatGPT plasmoid installed successfully from chevybowtie/plasmoid-chatgpt-kde6."
else
  echo "Installation failed. See error messages above."
fi
