# plugin
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
set_proxy () {
  # WINDOWS_IP=$(ipconfig.exe | grep -a IPv4 | cut -d: -f2 | awk 'NR==1' | tr -d " \t\n\r")
  LINUX_IP=`ip addr |grep 'inet 192.168' | awk '{print $2}' | awk -F/ '{print $1}'`
  echo "ip=${LINUX_IP}"
  PROXY_SOCKS5="socks5://${LINUX_IP}:10808"
  export http_proxy=${PROXY_SOCKS5}
  export https_proxy=${PROXY_SOCKS5}
  git config --global http.https://github.com.proxy ${PROXY_SOCKS5}
}
unset_proxy () {
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
