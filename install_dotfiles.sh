#!/bin/bash

this_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
for d in "$this_dir"/*/; do
	stow -d "$this_dir" -t $HOME "$(basename "$d")"
done

# .gitignore is in stow ignore list
ln -fs "$(realpath --relative-to="$HOME" "$this_dir/git/.gitignore")"
