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
  esac
done

if [ -z "$namespace" ]; then
  unmold publish module $1 $2 --system "$system" --path "$path"
else
  unmold publish module $namespace/$1 $2 --system "$system" --path "$path
fi
