#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Uso: $0 user@host [user@host ...]"
  echo "Esempio: $0 sad@192.168.1.10 sad@vps.example.com"
  exit 1
fi

REPO_URL="${REPO_URL:-https://github.com/sadman746/dotfiles.git}"
DOTFILES_PATH="${DOTFILES_PATH:-\$HOME/.dotfiles}"

for host in "$@"; do
  echo "--- Deploy su $host ---"
  ssh "$host" "
    set -euo pipefail
    if [ -d \"$DOTFILES_PATH/.git\" ]; then
      git -C \"$DOTFILES_PATH\" pull --ff-only
    elif [ -d \"\$HOME/dotfiles/.git\" ]; then
      mv \"\$HOME/dotfiles\" \"$DOTFILES_PATH\"
      git -C \"$DOTFILES_PATH\" pull --ff-only
    else
      git clone \"$REPO_URL\" \"$DOTFILES_PATH\"
    fi
    DOTFILES_DIR=\"$DOTFILES_PATH\" bash \"$DOTFILES_PATH/server/bootstrap-ubuntu.sh\"
  "
done

echo "Deploy completato su tutti gli host."
