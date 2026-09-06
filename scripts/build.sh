#!/usr/bin/env bash
# Локальная сборка PDF.
#
#   scripts/build.sh          собрать build/hako-yamasaki-first-live.pdf
#   scripts/build.sh watch    пересобирать при каждом изменении исходников
#   scripts/build.sh png      дополнительно отрендерить страницы в build/png/
#   scripts/build.sh open     собрать и открыть PDF в программе по умолчанию
#
# Typst ищется в PATH, затем в ~/.local/bin. Скачать: https://github.com/typst/typst/releases

set -euo pipefail

root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"

typst_bin="$(command -v typst || true)"
if [[ -z "$typst_bin" && -x "$HOME/.local/bin/typst" ]]; then
  typst_bin="$HOME/.local/bin/typst"
fi
if [[ -z "$typst_bin" ]]; then
  echo "typst не найден: установи его из https://github.com/typst/typst/releases" >&2
  exit 1
fi

out="build/hako-yamasaki-first-live.pdf"
mkdir -p build
version="$(git describe --tags --always --dirty 2>/dev/null || echo dev)"
common=(--root . --font-path fonts --input "version=$version" src/main.typ)

case "${1:-build}" in
  build)
    "$typst_bin" compile "${common[@]}" "$out"
    echo "Собрано: $out (версия $version)"
    ;;
  watch)
    exec "$typst_bin" watch "${common[@]}" "$out"
    ;;
  png)
    "$typst_bin" compile "${common[@]}" "$out"
    mkdir -p build/png
    rm -f build/png/*.png
    "$typst_bin" compile "${common[@]}" --format png --ppi 110 'build/png/p{p}.png'
    echo "Собрано: $out и build/png/"
    ;;
  open)
    "$typst_bin" compile "${common[@]}" "$out"
    xdg-open "$out" >/dev/null 2>&1 &
    ;;
  *)
    echo "Использование: $0 [build|watch|png|open]" >&2
    exit 2
    ;;
esac
