#!/usr/bin/env bash
set -euo pipefail
source "$REPO_DIR/scripts/lib.sh"

PACKAGES=(git curl wget zsh vim)

export DEBIAN_FRONTEND=noninteractive
info "Mise à jour de l'index apt"
$SUDO apt-get -o DPkg::Lock::Timeout=300 -o Acquire::Retries=3 update -qq

MISSING=()
for pkg in "${PACKAGES[@]}"; do
  dpkg -s "$pkg" &>/dev/null || MISSING+=("$pkg")
done

if (( ${#MISSING[@]} )); then
  info "Installation : ${MISSING[*]}"
  $SUDO apt-get -o DPkg::Lock::Timeout=300 -o Acquire::Retries=3 install -y -qq "${MISSING[@]}"
else
  info "Tous les paquets sont déjà installés"
fi
