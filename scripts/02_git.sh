#!/usr/bin/env bash
set -euo pipefail
source "$REPO_DIR/scripts/lib.sh"

[[ -f "$REPO_DIR/config.env" ]] || die "config.env introuvable"
source "$REPO_DIR/config.env"
: "${GIT_NAME:?}" "${GIT_EMAIL:?}"
have ssh-keygen || die "ssh-keygen manquant (paquet openssh-client)"

info "Configuration de Git"
git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global core.editor vim
git config --global init.defaultBranch main

KEY="$HOME/.ssh/id_ed25519"
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
if [[ -f "$KEY" ]]; then
  info "Clé SSH déjà présente"
else
  info "Génération de la clé SSH"
  ssh-keygen -t ed25519 -N "" -C "$GIT_EMAIL" -f "$KEY" -q
fi
