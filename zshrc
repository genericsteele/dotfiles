##### BINDINGS
bindkey -v # vi mode
# bindkey "^R" history-incremental-search-backward
# bindkey "\e[A" history-beginning-search-backward
# bindkey "\e[B" history-beginning-search-forward
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

[[ -n "${key[Up]}"   ]] && bindkey -- "${key[Up]}"   up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Pyenv
eval "$(pyenv init -)"

# Jump
eval "$(jump shell)"

# c/c++ packages installed by brew are not found by clang by default, the below fixes it
export C_INCLUDE_PATH=$(brew --prefix)/include
export LIBRARY_PATH=$(brew --prefix)/lib

autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
. $HOME/.zillow-bootstrap/files/init

# Go
export GOPATH=$HOME/go
path+=($GOPATH/bin)

# Initialize nvm
__init_nvm
autoload -U add-zsh-hook
load-nvmrc() {
local node_version="$(nvm version)"
local nvmrc_path="$(nvm_find_nvmrc)"

if [ -n "$nvmrc_path" ]; then
  local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

  if [ "$nvmrc_node_version" = "N/A" ]; then
    nvm install
  elif [ "$nvmrc_node_version" != "$node_version" ]; then
    nvm use
  fi
elif [ "$node_version" != "$(nvm version default)" ]; then
  echo "Reverting to nvm default version"
  nvm use default
fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Enable zsh prompt expansion
setopt PROMPT_SUBST
