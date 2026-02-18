#!/usr/bin/env bash

set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"
BACKUP_DIR="$HOME/.dotfiles-backups/$(date +%Y%m%d_%H%M%S)"
P10K_DIR="$HOME/.local/share/powerlevel10k"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

log() {
  printf "%b\n" "$1"
}

backup_existing() {
  local dst="$1"

  if [ -e "$dst" ] || [ -L "$dst" ]; then
    mkdir -p "$BACKUP_DIR"
    local name
    name="$(basename "$dst")"
    log "${YELLOW}Backup: $dst -> $BACKUP_DIR/$name${NC}"
    mv "$dst" "$BACKUP_DIR/$name"
  fi
}

link_file() {
  local src="$1"
  local dst="$2"

  if [ ! -e "$src" ]; then
    log "${RED}Errore: file sorgente non trovato: $src${NC}"
    exit 1
  fi

  mkdir -p "$(dirname "$dst")"

  if [ -L "$dst" ] && [ "$(readlink "$dst")" = "$src" ]; then
    log "${GREEN}Gia ok:${NC} $dst"
    return
  fi

  backup_existing "$dst"
  ln -s "$src" "$dst"
  log "${GREEN}Link:${NC} $dst -> $src"
}

if [ ! -d "$DOTFILES_DIR" ] && [ -d "$HOME/dotfiles" ]; then
  DOTFILES_DIR="$HOME/dotfiles"
  log "${YELLOW}Uso path legacy temporaneo: $DOTFILES_DIR${NC}"
fi

if [ ! -d "$DOTFILES_DIR" ]; then
  log "${RED}Errore: directory dotfiles non trovata in $DOTFILES_DIR${NC}"
  log "Clona la repo prima di eseguire questo script."
  exit 1
fi

if ! command -v apt-get >/dev/null 2>&1; then
  log "${RED}Errore: apt-get non disponibile. Questo script e pensato per Ubuntu/Debian.${NC}"
  exit 1
fi

log "${BLUE}Aggiorno indice pacchetti...${NC}"
sudo apt-get update

log "${BLUE}Installo dipendenze base...${NC}"
sudo apt-get install -y \
  zsh \
  git \
  curl \
  neovim \
  ripgrep \
  fd-find \
  fzf \
  eza \
  zoxide \
  zsh-autosuggestions \
  zsh-syntax-highlighting

if [ ! -d "$P10K_DIR" ]; then
  log "${BLUE}Installo Powerlevel10k in $P10K_DIR...${NC}"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
  log "${GREEN}Powerlevel10k gia installato${NC}"
fi

log "${BLUE}Creo symlink dotfiles server...${NC}"
link_file "$DOTFILES_DIR/server/.zshrc" "$HOME/.zshrc"
link_file "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
link_file "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7 || true)"
TARGET_SHELL="$(command -v zsh)"

if [ -n "$TARGET_SHELL" ] && [ "$CURRENT_SHELL" != "$TARGET_SHELL" ]; then
  log "${BLUE}Imposto zsh come shell di default...${NC}"
  chsh -s "$TARGET_SHELL"
  log "${YELLOW}Apri una nuova sessione SSH per usare la nuova shell.${NC}"
fi

log ""
log "${GREEN}Setup completato.${NC}"
if [ -d "$BACKUP_DIR" ]; then
  log "Backup disponibile in: $BACKUP_DIR"
fi
log "Esegui: exec zsh"
