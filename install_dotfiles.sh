#!/bin/bash

this_dir=SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

for d in ./*; do
	if [[ "$(basename "$d")" != ".git" ]]; then
		stow -d "$this_dir" -t ~ "$d" 
	fi
done
