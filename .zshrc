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

# 启用彩色提示符
autoload -U colors && colors
# 每次刷新提示符
setopt prompt_subst
# 设置提示符
PROMPT='%{$fg[green]%}%n%{$reset_color%}|%{$fg[yellow]%}%1~%{$reset_color%}%{$fg[blue]%}$(git branch --show-current 2&> /dev/null | xargs -I branch echo "(branch)")%{$reset_color%}❱ '

alias ~='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'

alias ll='ls -alhF'
alias la='ls -A'
alias l='ls -CF'

alias cls='clear'

alias vim='nvim'
alias vi='nvim'

alias ra=ranger

alias lg='lazygit'
alias dotfiles="/usr/bin/env git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lgd="lazygit --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

# wsl 配置代理 注意打开代理软件可被外部访问
set-proxy () {
  IP=$(ipconfig.exe | grep -a IPv4 | cut -d: -f2 | awk 'NR==1' | tr -d " \t\n\r")
  # IP=`ip addr |grep 'inet 192.168' | awk '{print $2}' | awk -F/ '{print $1}'`
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


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/ahdai/.miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/ahdai/.miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/ahdai/.miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/ahdai/.miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

export GOBIN="$HOME/go/bin"
export PATH="$PATH:$GOBIN"
