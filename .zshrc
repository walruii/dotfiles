export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="walruii"

unsetopt beep

plugins=(
    git
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# History Configuration
HISTSIZE=50000
SAVEHIST=50000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_EXPIRE_DUPS_FIRST # Erase duplicates first when rewriting hist file
setopt HIST_IGNORE_DUPS       # Ignore consecutive duplicates
setopt HIST_FIND_NO_DUPS      # Do not display a line previously found.

# Change cursor shape for different vi modes
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] || [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q' # Block cursor for Normal Mode
  elif [[ ${KEYMAP} == main ]] || [[ ${KEYMAP} == viins ]] || [[ ${KEYMAP} == "" ]] || [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q' # Beam cursor for Insert Mode
  fi
}
zle -N zle-keymap-select


# aliases

# alias "cd"="z"
alias "ta"="tmux a -t"
alias "td"="tmux detach"
alias "t"="tmux"

alias nd="npm run dev"
alias nb="npm run build"

# setup zoxide
eval "$(zoxide init zsh --cmd cd)"

# using nvim for man pages
export MANPAGER='nvim +Man!'

# using fzf for fuzzy finding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add ~/.local/bin to PATH
if [ -d "${HOME}/.local/bin" ] && [[ ":${PATH}:" != *":${HOME}/.local/bin:"* ]]; then
    PATH="${HOME}/.local/bin:${PATH}"
fi
