if [[ -z "$PS1" ]]; then
  return
fi

# sh
for f in $XDG_CONFIG_HOME/sh/*.sh; do
  source $f
done

# bash
for f in $XDG_CONFIG_HOME/bash/*.bash; do
  source $f
done
