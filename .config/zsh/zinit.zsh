declare -A ZINIT
ZINIT=(BIN_DIR "$XDG_CACHE_HOME/zinit/bin" HOME_DIR "$XDG_CACHE_HOME/zinit" COMPINIT_OPTS "$XDG_DATA_HOME/zsh/compdump")

source $XDG_CACHE_HOME/zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-syntax-highlighting
