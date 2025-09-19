#!/bin/bash

# Upgrade the plasmoid from the official repository
TMPDIR=$(mktemp -d)
git clone https://github.com/chevybowtie/plasmoid-chatgpt-kde6.git "$TMPDIR/plasmoid-chatgpt-kde6" && \
  kpackagetool6 --upgrade "$TMPDIR/plasmoid-chatgpt-kde6/package"

if [ $? -eq 0 ]; then
  echo "ChatGPT plasmoid upgraded successfully from chevybowtie/plasmoid-chatgpt-kde6."
else
  echo "Upgrade failed. See error messages above."
fi
