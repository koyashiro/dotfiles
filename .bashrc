if [[ -z "$PS1" ]]; then
  return
fi

# sh
for f in $XDG_CONFIG_HOME/sh/*.sh; do
  source $f
done
