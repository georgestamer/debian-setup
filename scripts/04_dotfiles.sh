#!/usr/bin/env bash
set -euo pipefail
source "$REPO_DIR/scripts/lib.sh"

SRC="$REPO_DIR/dotfiles"
STAMP="$(date +%Y%m%d-%H%M%S)"

link_dotfile() {  # $1 = nom du fichier
  local src="$SRC/$1" dst="$HOME/$1"
  [[ -f "$src" ]] || die "Dotfile introuvable : $src"
  if [[ -L "$dst" && "$(readlink -f "$dst")" == "$(readlink -f "$src")" ]]; then
    info "Déjà lié : $1"
    return 0
  fi
  if [[ -e "$dst" || -L "$dst" ]]; then
    mv "$dst" "$dst.bak.$STAMP"
    info "Sauvegarde : $1.bak.$STAMP"
  fi
  ln -s "$src" "$dst"
  info "Lié : $1"
}

link_dotfile .zshrc
link_dotfile .vimrc

INC="$SRC/.gitconfig"
if git config --global --get-all include.path | grep -qxF "$INC"; then
  info "Déjà inclus : .gitconfig"
else
  git config --global --add include.path "$INC"
  info "Inclus : .gitconfig"
fi
