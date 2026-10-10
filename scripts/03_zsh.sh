#!/usr/bin/env bash
set -euo pipefail
source "$REPO_DIR/scripts/lib.sh"

have zsh || die "zsh manquant (étape 01_packages ?)"

OMZ="$HOME/.oh-my-zsh"
CUSTOM="$OMZ/custom/plugins"

clone_if_missing() {  # $1 = url, $2 = destination
  if [[ -d "$2/.git" ]]; then
    info "Déjà présent : $(basename "$2")"
  else
    rm -rf "$2"
    git clone --depth=1 -q "$1" "$2"
    info "Installé : $(basename "$2")"
  fi
}

clone_if_missing https://github.com/ohmyzsh/ohmyzsh.git "$OMZ"
clone_if_missing https://github.com/zsh-users/zsh-autosuggestions.git "$CUSTOM/zsh-autosuggestions"
clone_if_missing https://github.com/zsh-users/zsh-syntax-highlighting.git "$CUSTOM/zsh-syntax-highlighting"

ZSH_BIN="$(command -v zsh)"
CURRENT_SHELL="$(getent passwd "$USER" | cut -d: -f7)"
if [[ "$CURRENT_SHELL" == "$ZSH_BIN" ]]; then
  info "zsh est déjà le shell par défaut"
else
  info "zsh devient le shell par défaut"
  $SUDO chsh -s "$ZSH_BIN" "$USER"
fi
