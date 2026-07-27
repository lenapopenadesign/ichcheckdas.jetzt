#!/usr/bin/env bash
#
# Deploy der statischen Seite nach Uberspace (~/html).
#
# Einmalig: Uberspace-User + Host setzen – entweder hier eintragen
# oder beim Aufruf als Env-Variablen übergeben:
#   UBERSPACE_USER=meinuser ./deploy.sh
#
set -euo pipefail

USER="${UBERSPACE_USER:-DEIN_USER}"
HOST="${UBERSPACE_HOST:-${USER}.uber.space}"   # SSH-Host, i.d.R. <user>.uber.space

if [ "$USER" = "DEIN_USER" ]; then
  echo "Bitte UBERSPACE_USER setzen (in deploy.sh oder als Env-Variable)." >&2
  exit 1
fi

SRC="$(cd "$(dirname "$0")" && pwd)/"

echo "Deploye $SRC  ->  $USER@$HOST:html/"
rsync -avz --delete \
  --exclude '.git' \
  --exclude '.github' \
  --exclude '.gitignore' \
  --exclude '.claude' \
  --exclude 'deploy.sh' \
  --exclude 'DEPLOY.md' \
  --exclude '_oggen.html' \
  --exclude 'README.md' \
  --exclude 'LICENSE' \
  --exclude '.DS_Store' \
  "$SRC" "$USER@$HOST:html/"

echo "Fertig. Seite liegt jetzt unter ~/html auf $HOST."
