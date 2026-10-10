info(){ printf '\033[1;34m[INFO]\033[0m %s\n' "$*"; }
ok(){   printf '\033[1;32m[ OK ]\033[0m %s\n' "$*"; }
err(){  printf '\033[1;31m[ERR ]\033[0m %s\n' "$*" >&2; }
die(){  err "$*"; exit 1; }
have(){ command -v "$1" &>/dev/null; }

if [[ $EUID -eq 0 ]]; then SUDO=""
elif have sudo; then SUDO="sudo"
else die "Ni root ni sudo : impossible d'installer des paquets"; fi
export SUDO

preflight(){ getent hosts deb.debian.org &>/dev/null || die "Pas de réseau"; }
