# install zinit
if [[ ! -d "$XDG_DATA_HOME"/zinit ]]; then
  mkdir -m 700 "$XDG_DATA_HOME"/zinit
  git clone https://github.com/zdharma/zinit.git "$XDG_DATA_HOME"/zinit/bin
fi

declare -A ZINIT
ZINIT=(BIN_DIR "$XDG_DATA_HOME"/zinit/bin HOME_DIR "$XDG_DATA_HOME"/zinit COMPINIT_OPTS "$XDG_DATA_HOME"/zsh/compdump)

source "$XDG_DATA_HOME"/zinit/bin/zinit.zsh
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma/fast-syntax-highlighting
zinit light ascii-soup/zsh-url-highlighter
zinit light b4b4r07/zsh-vimode-visual
zinit light mollifier/cd-gitroot
zinit ice depth=1; zinit light romkatv/powerlevel10k
