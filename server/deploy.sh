#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Uso: $0 user@host [user@host ...]"
  echo "Esempio: $0 sad@192.168.1.10 sad@vps.example.com"
  exit 1
fi

REPO_URL="${REPO_URL:-https://github.com/sadman746/dotfiles.git}"
DOTFILES_PATH="${DOTFILES_PATH:-.dotfiles}"

for host in "$@"; do
  echo "--- Deploy su $host ---"
  ssh "$host" "
    set -euo pipefail
    DOTFILES_DIR=\"\$HOME/$DOTFILES_PATH\"
    if [ -d \"\$DOTFILES_DIR/.git\" ]; then
      git -C \"\$DOTFILES_DIR\" pull --ff-only
    elif [ -d \"\$HOME/dotfiles/.git\" ]; then
      mv \"\$HOME/dotfiles\" \"\$DOTFILES_DIR\"
      git -C \"\$DOTFILES_DIR\" pull --ff-only
    else
      git clone \"$REPO_URL\" \"\$DOTFILES_DIR\"
    fi
    DOTFILES_DIR=\"\$DOTFILES_DIR\" bash \"\$DOTFILES_DIR/server/bootstrap-ubuntu.sh\"
  "
done

echo "Deploy completato su tutti gli host."
