#!/bin/bash

# Dotfiles Install Script
# Per macOS

set -e  # Exit on error

echo "🚀 Inizio installazione dotfiles..."

# Colori
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Directory dotfiles
DOTFILES_DIR="$HOME/dotfiles"

# Controllo se la directory esiste
if [ ! -d "$DOTFILES_DIR" ]; then
    echo -e "${RED}❌ Errore: Directory $DOTFILES_DIR non trovata${NC}"
    echo "Clona prima il repository:"
    echo "git clone https://github.com/sadman746/dotfiles.git ~/dotfiles"
    exit 1
fi

cd "$DOTFILES_DIR"

echo "📦 Installazione Homebrew..."
if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${GREEN}✓ Homebrew già installato${NC}"
fi

echo "🍺 Installazione pacchetti..."
brew install neovim git
brew install --cask wezterm

echo "🐚 Installazione Zsh plugins..."
brew install powerlevel10k zsh-autosuggestions zsh-syntax-highlighting

echo "🔗 Creazione symlink..."

# Funzione per creare symlink sicuro
create_symlink() {
    local src="$1"
    local dst="$2"
    
    # Se esiste già un file (non symlink), fai backup
    if [ -f "$dst" ] && [ ! -L "$dst" ]; then
        echo -e "${YELLOW}⚠️  Backup di $dst${NC}"
        mv "$dst" "$dst.backup.$(date +%Y%m%d_%H%M%S)"
    fi
    
    # Se esiste già un symlink, rimuovilo
    if [ -L "$dst" ]; then
        rm "$dst"
    fi
    
    # Crea symlink
    ln -s "$src" "$dst"
    echo -e "${GREEN}✓ Creato: $dst -> $src${NC}"
}

# Crea directory .config se non esiste
mkdir -p ~/.config

# Crea i symlink
create_symlink "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_DIR/.wezterm.lua" "$HOME/.wezterm.lua"
create_symlink "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
create_symlink "$DOTFILES_DIR/.gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_DIR/.config/nvim" "$HOME/.config/nvim"

echo "🎨 Configurazione font..."
# Installa MesloLGS Nerd Font (richiesto da Powerlevel10k)
brew tap homebrew/cask-fonts
brew install --cask font-meslo-lg-nerd-font

echo "⚡ Setup Zsh come shell predefinita..."
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/opt/homebrew/bin/zsh" ]; then
    chsh -s /bin/zsh
    echo -e "${YELLOW}⚠️  Cambio shell effettuato. Riavvia il terminale.${NC}"
fi

echo ""
echo -e "${GREEN}✅ Installazione completata!${NC}"
echo ""
echo "📋 Prossimi passi:"
echo "1. Riavvia il terminale"
echo "2. Apri WezTerm: Cmd+Spazio, digita 'wezterm'"
echo "3. Apri nvim: nvim"
echo "4. I plugin verranno installati automaticamente"
echo ""
echo "📖 Leggi il cheatsheet: nvim ~/.config/nvim/CHEATSHEET.md"
echo ""
