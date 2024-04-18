# install zinit
if [[ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}"/zinit ]]; then
  mkdir -m 700 "${XDG_DATA_HOME:-$HOME/.local/share}"/zinit
  git clone https://github.com/zdharma-continuum/zinit.git "${XDG_DATA_HOME:-$HOME/.local/share}"/zinit/bin
fi

declare -A ZINIT
ZINIT=(
  BIN_DIR "${XDG_DATA_HOME:-$HOME/.local/share}"/zinit/bin
  HOME_DIR "${XDG_DATA_HOME:-$HOME/.local/share}"/zinit
  COMPINIT_OPTS "${XDG_DATA_HOME:-$HOME/.local/share}"/zsh/compdump
)

source "${XDG_DATA_HOME:-$HOME/.local/share}"/zinit/bin/zinit.zsh
autoload -Uz _zinit
[[ -n "${_comps}" ]] && _comps[zinit]=_zinit

zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions
zinit light zdharma-continuum/fast-syntax-highlighting
zinit light ascii-soup/zsh-url-highlighter
zinit light mollifier/cd-gitroot
zinit ice depth=1
zinit light romkatv/powerlevel10k
