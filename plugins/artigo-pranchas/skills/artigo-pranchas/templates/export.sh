#!/usr/bin/env bash
# gera img/card-NN.png (1200x675 @2x) de cada prancha do sessoes.html.
# Falha se alguma prancha estoura a área: texto cortado não aparece no PNG, só some.
set -euo pipefail
DIR="$(cd "$(dirname "$0")" && pwd)"
CHROME="${CHROME:-$(command -v google-chrome || command -v chromium || command -v chromium-browser || true)}"
[ -z "$CHROME" ] && [ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ] \
  && CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
[ -n "$CHROME" ] || { echo "chrome/chromium não encontrado (defina CHROME=...)" >&2; exit 1; }

HTML="$DIR/sessoes.html"
FLAGS=(--headless=new --disable-gpu --hide-scrollbars --virtual-time-budget=4000)

over=$("$CHROME" "${FLAGS[@]}" --window-size=1400,900 --dump-dom "file://$HTML" 2>/dev/null \
  | grep -o 'data-overflow="[^"]*"' | head -1 | cut -d'"' -f2 || true)
if [ -n "$over" ]; then
  echo "prancha(s) com estouro: $over · abra sessoes.html e procure o contorno vermelho" >&2
  exit 1
fi

mkdir -p "$DIR/img"
for n in $(grep -o 'data-card="[0-9]*"' "$HTML" | cut -d'"' -f2); do
  "$CHROME" "${FLAGS[@]}" --force-device-scale-factor=2 --window-size=1200,675 \
    --screenshot="$DIR/img/card-$n.png" "file://$HTML?solo=$n" >/dev/null 2>&1
  echo "img/card-$n.png"
done
