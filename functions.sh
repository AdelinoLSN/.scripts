#!/bin/zsh

clean_node_modules() {
  echo "Procurando node_modules..."
  local dirs=("${(@f)$(find . -type d -name 'node_modules')}")

  if (( ${#dirs[@]} == 0 )); then
    echo "Nenhuma pasta node_modules encontrada."
    return 0
  fi

  echo "Serão removidas:"
  printf '%s\n' "${dirs[@]}"

  read "resp?Confirmar remoção? (s/N) "
  if [[ "$resp" != "s" && "$resp" != "S" ]]; then
    echo "Cancelado."
    return 0
  fi

  for d in "${dirs[@]}"; do
    echo "Removendo: $d"
    rm -rf "$d"
  done

  echo "Concluído!"
}
