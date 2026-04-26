#!/bin/sh
set -eu

# initialize variables so referencing them doesn't fail with 'set -u'
system=""
path=""

for arg in "$@"; do
  case $arg in
    --system=*)
      system="${arg#--system=}"
      ;;
    --module-path=*)
      path="${arg#--module-path=}"
      ;;
  esac
done

unmold module publish "$1" "$2" -y --system "$system" --path "$path"
