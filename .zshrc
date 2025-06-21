# 补全大小写不敏感
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# 持久化zsh history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# plugin
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source <(fzf --zsh)

# 启用彩色提示符
autoload -U colors && colors
# 每次刷新提示符
setopt prompt_subst
# 设置提示符
PROMPT='%{$fg[yellow]%}%1~ ➤ '

# 默认编辑器
export EDITOR=nvim

# ------------------------------------------------------------------------------
# alias
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias l='ls'
alias la='ls -a'
alias ll='ls -al'

alias cls='clear'

alias vim='nvim'

alias ra='ranger'

alias j='just'

alias lg='lazygit'
alias dotfiles="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lgd="lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias tm='tmux attach || tmux new'

# --------------------------------------------------------------------------
# wsl 配置代理 注意打开代理软件可被外部访问选项
set-proxy () {
  IP=$(ip --json route show default | jq -re '.[].gateway')
  # IP=$(ipconfig.exe | grep -a 192.168 | cut -d: -f2 | awk 'NR==1' | tr -d " \t\n\r")
  echo "ip=${IP}"
  PROXY_SOCKS5="socks5://${IP}:10808"
  export http_proxy=${PROXY_SOCKS5}
  export https_proxy=${PROXY_SOCKS5}
  git config --global http.https://github.com.proxy ${PROXY_SOCKS5}
}
reset-proxy () {
  unset http_proxy
  unset https_proxy
  git config --global --unset http.https://github.com.proxy
}

