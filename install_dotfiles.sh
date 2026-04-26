#!/bin/bash

this_dir=SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for d in ./*/; do
	stow -d ~/dotfiles -t ~ "$(basename "$d")"
done
