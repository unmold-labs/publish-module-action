#!/bin/sh
set -eu

# initialize variables so referencing them doesn't fail with 'set -u'
system=""
path=""
overwrite="false"

for arg in "$@"; do
  case $arg in
    --system=*)
      system="${arg#--system=}"
      ;;
    --module-path=*)
      path="${arg#--module-path=}"
      ;;
    --overwrite=*)
      overwrite="${arg#--overwrite=}"
      ;;
  esac
done

if [ "$overwrite" = "true" ]; then
  unmold module publish "$1" "$2" --confirm --system "$system" --path "$path" --overwrite
else
  unmold module publish "$1" "$2" --confirm --system "$system" --path "$path"
fi
