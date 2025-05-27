_supctl() {
  local i head
  mapfile -t COMPREPLY < <(export COMP_LINE && export COMP_POINT && export COMP_WORDBREAKS && /home/millrt9/.local/bin/supctl)
  while [ ${#COMPREPLY[@]} -ge 1 ]; do
    head="${COMPREPLY[0]}"
    COMPREPLY=("${COMPREPLY[@]:1}")
    if [ "$head" = "__DIR__" ]; then
      compopt -o dirnames
    elif [ "$head" = "__FILES__" ]; then
      compopt -o default
    elif [ "$head" = "__NOSPACE__" ]; then
      compopt -o nospace
    elif [ "$head" = "__FILENAMES__" ]; then
      compopt -o filenames
    elif [ "$head" = "__UNPREDICTABLE__" ]; then
      COMPREPLY+=('')
    elif [ "$head" = "__WORDS__" ]; then
      break
    fi
  done
  return 0
}

complete -o nosort -o noquote -F _supctl supctl

