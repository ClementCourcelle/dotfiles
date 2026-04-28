#!/usr/bin/env bash
set -euo pipefail

this_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

for d in "$this_dir"/*/; do
  stow -d "$this_dir" -t "$HOME" "$(basename "$d")"
done

# stow skips .gitignore by default — deploy it manually
ln -sf "$this_dir/git/.gitignore" "$HOME/.gitignore"
