# debian-setup

Script Bash qui installe, configure et restaure un environnement de développement
complet sur une VM Debian vierge, sans intervention manuelle.

## Prérequis
- Debian 12, accès réseau
- `git` (pour cloner le dépôt) ; `sudo` ou un compte root

## Utilisation
```bash
git clone <url-du-depot> debian-setup && cd debian-setup
cp config.env.example config.env    # puis éditer GIT_NAME et GIT_EMAIL
./setup.sh
exec zsh
```

## Ce que fait le script
| Étape | Module | Action |
|---|---|---|
| 1 | `01_packages.sh` | apt update, installe git, curl, wget, zsh, vim |
| 2 | `02_git.sh` | user.name, user.email, éditeur, branche `main`, clé SSH ed25519 |
| 3 | `03_zsh.sh` | Oh My Zsh, plugins (autosuggestions, syntax-highlighting), zsh par défaut |
| 4 | `04_dotfiles.sh` | liens symboliques `.zshrc`, `.vimrc` ; inclusion de `.gitconfig` |

## Structure
- `setup.sh` : orchestrateur
- `scripts/lib.sh` : fonctions communes (logs, détection sudo, test réseau)
- `scripts/NN_*.sh` : modules
- `dotfiles/` : fichiers de configuration versionnés
- `config.env.example` : modèle de configuration (`config.env` est ignoré par Git)

## Idempotence
Le script peut être relancé sans risque : chaque action teste l'état avant d'agir
(paquet installé ? dossier présent ? clé existante ? lien déjà créé ?).
Un fichier existant est sauvegardé en `.bak.<date>` avant remplacement.

## Robustesse
- `set -euo pipefail` dans tous les scripts
- `trap ERR` : indique la ligne et l'étape en échec
- vérification du réseau et des droits (root ou sudo) avant de commencer

## Sécurité
- Oh My Zsh est installé par `git clone`, sans `curl | sh`
- La clé SSH est créée sans passphrase pour permettre l'automatisation (compromis assumé)
- Aucun secret dans le dépôt : `config.env` est dans `.gitignore`
