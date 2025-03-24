#!/bin/sh
echo -ne '\033c\033]0;mais um teste\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Next Station.x86_64" "$@"
