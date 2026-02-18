#!/usr/bin/env bash

set -euo pipefail

if [ "$#" -lt 1 ]; then
  echo "Uso: $0 user@host [user@host ...]"
  echo "Esempio: $0 sad@192.168.1.10 sad@vps.example.com"
  exit 1
fi

REPO_URL="${REPO_URL:-https://github.com/sadman746/dotfiles.git}"

for host in "$@"; do
  echo "--- Deploy su $host ---"
  ssh "$host" "
    set -euo pipefail
    if [ -d \"\$HOME/dotfiles/.git\" ]; then
      git -C \"\$HOME/dotfiles\" pull --ff-only
    else
      git clone \"$REPO_URL\" \"\$HOME/dotfiles\"
    fi
    bash \"\$HOME/dotfiles/server/bootstrap-ubuntu.sh\"
  "
done

echo "Deploy completato su tutti gli host."
