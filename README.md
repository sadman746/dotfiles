# Dotfiles - sadman746

Configurazione personale per macOS + Web Development

## 📁 Struttura

```
dotfiles/
├── .zshrc              # Configurazione Zsh + Powerlevel10k
├── .wezterm.lua        # Configurazione WezTerm
├── .p10k.zsh           # Tema Powerlevel10k
├── .gitconfig          # Configurazione Git
├── .config/
│   └── nvim/           # Configurazione Neovim completa
└── install.sh          # Script installazione automatica
```

## 🚀 Installazione Rapida

```bash
git clone https://github.com/sadman746/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## 📦 Requisiti

- macOS
- Homebrew
- Git

## ⚙️ Programmi Installati

- **Neovim** - Editor con 20+ plugin per web dev
- **WezTerm** - Terminale moderno
- **Zsh** + Powerlevel10k - Shell con tema
- **Git** - Version control

## 🔧 Manutenzione

### Aggiornare configurazione

```bash
cd ~/dotfiles
# Modifica i file
nvim .zshrc  # o qualsiasi altro file
git add .
git commit -m "Aggiornamento configurazione"
git push
```

### Sincronizzare su altro Mac

```bash
cd ~/dotfiles
git pull
# I cambiamenti sono automaticamente attivi (symlink)
```

## 📝 Note

- I file sono gestiti tramite **symlink** (collegamenti simbolici)
- La directory `~/dotfiles/` è il repository Git
- I programmi cercano i config in `~/` ma trovano i symlink che puntano a `~/dotfiles/`

## 📄 License

MIT
