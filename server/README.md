# Server setup (Ubuntu)

Questa cartella contiene il setup minimale server-only:

- Zsh + Powerlevel10k
- Neovim config condivisa dalla repo

## Setup rapido su nuovo server

```bash
git clone https://github.com/sadman746/dotfiles.git ~/dotfiles
bash ~/dotfiles/server/bootstrap-ubuntu.sh
```

## Aggiornare server gia esistente

```bash
cd ~/dotfiles
git pull --ff-only
bash ~/dotfiles/server/bootstrap-ubuntu.sh
```

## Deploy da Mac su piu server

Dal Mac locale:

```bash
cd ~/dotfiles
bash server/deploy.sh sad@192.168.1.10 sad@vps.example.com
```

## Cosa fa bootstrap-ubuntu.sh

- Installa dipendenze Ubuntu con apt
- Installa Powerlevel10k in `~/.local/share/powerlevel10k`
- Crea symlink per `~/.zshrc`, `~/.p10k.zsh`, `~/.config/nvim`
- Fa backup automatico dei file sostituiti in `~/.dotfiles-backups/<timestamp>`
