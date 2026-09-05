if not status is-interactive
    return
end

# Keep command-line programs in English without changing the desktop session.
set -gx LC_ALL en_US.UTF-8
set -gx LANG en_US.UTF-8
set -gx LANGUAGE en_US:en

set -g fish_greeting
set -g fish_escape_delay_ms 10

# Fish provides vi editing, autosuggestions, syntax highlighting, and
# substring history search without third-party plugins.
fish_vi_key_bindings

# Load fzf after vi bindings so its Ctrl-R/Ctrl-T/Alt-C bindings win.
if type -q fzf
    fzf --fish | source

    source (status dirname)/functions/fzf-history-widget.fish
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

abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'

abbr --add l eza
abbr --add la 'eza -a'
abbr --add ll 'eza -al'

abbr --add cls clear

abbr --add lg lazygit
abbr --add j just
abbr --add claude-auto 'claude --enable-auto-mode'

abbr --add zz zellij
abbr --add za 'zellij attach'
abbr --add zl 'zellij list-sessions'
abbr --add zk 'zellij kill-all-sessions'
abbr --add zw 'zellij attach -c work'
