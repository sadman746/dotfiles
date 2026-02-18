# Enable Powerlevel10k instant prompt.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [[ -r "$HOME/.local/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "$HOME/.local/share/powerlevel10k/powerlevel10k.zsh-theme"
elif [[ -r "/usr/share/powerlevel10k/powerlevel10k.zsh-theme" ]]; then
  source "/usr/share/powerlevel10k/powerlevel10k.zsh-theme"
fi

[[ -f "$HOME/.p10k.zsh" ]] && source "$HOME/.p10k.zsh"

for plugin_file in \
  /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh \
  /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
do
  [[ -r "$plugin_file" ]] && source "$plugin_file" && break
done

for plugin_file in \
  /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh \
  /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
do
  [[ -r "$plugin_file" ]] && source "$plugin_file" && break
done

if command -v eza >/dev/null 2>&1; then
  alias ls="eza --icons=always"
else
  alias ls="ls --color=auto"
fi

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
  alias cd="z"
fi

if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  alias fd="fdfind"
fi

alias sadhost="ssh sad@192.168.1.10"

HISTFILE=$HOME/.zhistory
SAVEHIST=5000
HISTSIZE=5000
setopt share_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
