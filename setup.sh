#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export REPO_DIR
source "$REPO_DIR/scripts/lib.sh"

STEPS=(01_packages 02_git 03_zsh 04_dotfiles)
CURRENT_STEP="init"
trap 'err "Échec à la ligne $LINENO (étape : $CURRENT_STEP)"' ERR

preflight

for step in "${STEPS[@]}"; do
  CURRENT_STEP="$step"
  info "▶ $step"
  bash "$REPO_DIR/scripts/$step.sh"
  ok "✔ $step"
done
ok "Terminé."
