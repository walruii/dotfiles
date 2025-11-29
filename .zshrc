export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="daivasmara"
#daivasmara

unsetopt beep

plugins=(
    git
    vi-mode
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

bindkey '^[[Z' autosuggest-accept  # shift + tab  | autosuggest

# aliases

alias "cd"="z"
alias "ta"="tmux a -t"
alias "td"="tmux detach"
alias "t"="tmux"

alias nd="npm run dev"
alias nb="npm run build"

alias caid="~/Documents/repos/scripts/create_aivideo_dir.sh"

# setup zoxide
eval "$(zoxide init zsh)"

# export for ruby
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/lib/ruby/gems/3.3.0/bin:$PATH"

# Java (using Homebrew temurin17)
export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"

# using nvim for man pages
export MANPAGER='nvim +Man!'

# using fzf for fuzzy finding
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
