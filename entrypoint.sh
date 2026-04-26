#!/bin/sh
set -eu

# initialize variables so referencing them doesn't fail with 'set -u'
namespace=""
system=""
path=""

for arg in "$@"; do
  case $arg in
    --namespace=*)
      namespace="${arg#--namespace=}"
      ;;
    --system=*)
      system="${arg#--system=}"
      ;;
    --module-path=*)
      path="${arg#--module-path=}"
      ;;
  esac
done

if [ -z "$namespace" ]; then
  unmold module publish "$1" "$2" -y --system "$system" --path "$path"
else
  unmold module publish "$namespace/$1" "$2" -y --system "$system" --path "$path"
fi
