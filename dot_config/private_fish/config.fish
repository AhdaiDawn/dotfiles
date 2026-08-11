if not status is-interactive
    return
end

set -g fish_greeting
set -g fish_escape_delay_ms 10

# Fish provides vi editing, autosuggestions, syntax highlighting, and
# substring history search without third-party plugins.
fish_vi_key_bindings

# Load fzf after vi bindings so its Ctrl-R/Ctrl-T/Alt-C bindings win.
if type -q fzf
    fzf --fish | source
end

if type -q zoxide
    zoxide init fish | source
end

if type -q starship
    starship init fish | source
end

if type -q direnv
    direnv hook fish | source
end

# Make commands entered in other running fish sessions visible at each prompt.
function __fish_merge_shared_history --on-event fish_prompt
    builtin history merge
end

alias ..='cd ..'
alias ...='cd ../..'

alias l='eza'
alias la='eza -a'
alias ll='eza -al'

alias cls='clear'

alias lg='lazygit'
alias dotfiles='chezmoi'
alias j='just'
alias claude-auto='claude --enable-auto-mode'

alias zz='zellij'
alias za='zellij attach'
alias zl='zellij list-sessions'
alias zk='zellij kill-all-sessions'
alias zw='zellij attach -c work'

function zn --description 'Attach to a zellij session named after the current directory'
    zellij attach -c (basename "$PWD") $argv
end
