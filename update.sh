#!/bin/bash

# Script di aggiornamento dotfiles per MacBook
# Usa questo quando hai già una configurazione vecchia da aggiornare

set -e

# Colori
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}🔄 Aggiornamento configurazione dotfiles...${NC}"
echo ""

# Data per backup
BACKUP_DATE=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/dotfiles-backup-$BACKUP_DATE"
DOTFILES_DIR="${DOTFILES_DIR:-$HOME/.dotfiles}"

# Funzione per fare backup sicuro
backup_file() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        echo -e "${YELLOW}📦 Backup: $file${NC}"
        cp -r "$file" "$BACKUP_DIR/"
    fi
}

# Crea directory backup
echo -e "${BLUE}📁 Creazione backup in: $BACKUP_DIR${NC}"
mkdir -p "$BACKUP_DIR"

# Backup file esistenti (non symlink)
echo ""
echo -e "${BLUE}💾 Backup configurazioni esistenti...${NC}"
backup_file "$HOME/.zshrc"
backup_file "$HOME/.wezterm.lua"
backup_file "$HOME/.p10k.zsh"
backup_file "$HOME/.gitconfig"
backup_file "$HOME/.config/nvim"

echo -e "${GREEN}✓ Backup completato${NC}"
echo ""

# Controlla se ~/.dotfiles esiste già
if [ -d "$DOTFILES_DIR" ]; then
    echo -e "${YELLOW}⚠️  Trovata directory $DOTFILES_DIR esistente${NC}"
    echo "Aggiornamento con git pull..."
    cd "$DOTFILES_DIR"
    
    # Salva eventuali modifiche locali
    git stash
    
    # Pull aggiornamenti
    git pull origin main
    
    # Ripristina modifiche locali (se presenti)
    git stash pop 2>/dev/null || true
    
    echo -e "${GREEN}✓ Repository aggiornato${NC}"
else
    echo -e "${BLUE}📥 Clonazione repository...${NC}"
    git clone https://github.com/sadman746/dotfiles.git "$DOTFILES_DIR"
    echo -e "${GREEN}✓ Repository clonato${NC}"
fi

echo ""

# Rimuovi file vecchi (non symlink)
echo -e "${BLUE}🗑️  Rimozione configurazioni vecchie...${NC}"
remove_old() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        echo "  Rimosso: $file"
        rm -rf "$file"
    elif [ -L "$file" ]; then
        echo "  Rimosso symlink: $file"
        rm "$file"
    fi
}

remove_old "$HOME/.zshrc"
remove_old "$HOME/.wezterm.lua"
remove_old "$HOME/.p10k.zsh"
remove_old "$HOME/.gitconfig"
remove_old "$HOME/.config/nvim"
remove_old "$HOME/.tmux.conf" 2>/dev/null || true

echo -e "${GREEN}✓ Pulizia completata${NC}"
echo ""

# Crea symlinks
echo -e "${BLUE}🔗 Creazione collegamenti simbolici...${NC}"

create_link() {
    local src="$1"
    local dst="$2"
    
    # Crea directory parent se non esiste
    mkdir -p "$(dirname "$dst")"
    
    # Rimuovi esistente
    [ -e "$dst" ] && rm -rf "$dst"
    
    # Crea symlink
    ln -s "$src" "$dst"
    echo -e "${GREEN}  ✓${NC} $dst"
}

create_link "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_link "$DOTFILES_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
create_link "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
create_link "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_link "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo ""
echo -e "${GREEN}✅ Collegamenti creati con successo!${NC}"
echo ""

# Verifica installazioni
echo -e "${BLUE}🔍 Verifica installazioni...${NC}"

# Controlla se serve installare dipendenze
if ! command -v nvim &> /dev/null; then
    echo -e "${YELLOW}⚠️  Neovim non trovato${NC}"
    echo "Installa con: brew install neovim"
fi

if ! command -v git &> /dev/null; then
    echo -e "${YELLOW}⚠️  Git non trovato${NC}"
    echo "Installa con: brew install git"
fi

# Controlla WezTerm
if [ ! -d "/Applications/WezTerm.app" ] && [ ! -d "$HOME/Applications/WezTerm.app" ]; then
    echo -e "${YELLOW}⚠️  WezTerm non trovato${NC}"
    echo "Installa con: brew install --cask wezterm"
fi

echo ""
echo -e "${GREEN}🎉 Aggiornamento completato!${NC}"
echo ""
echo "📋 Riavvia il terminale per applicare le modifiche"
echo ""
echo "📝 Prossimi passi:"
echo "   1. Riavvia il terminale"
echo "   2. Apri nvim: verranno installati automaticamente i plugin"
echo "   3. Leggi il cheatsheet: nvim ~/.config/nvim/CHEATSHEET.md"
echo ""
echo "💾 Backup salvato in: $BACKUP_DIR"
echo "   (puoi eliminarlo dopo aver verificato che tutto funziona)"
echo ""
