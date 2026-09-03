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

    # Keep Up-arrow session-local while letting Ctrl-R search saved sessions.
    function fzf-history-widget -d "Search command history from all sessions"
        set -l time_prefix_regex '^.*? │ '
        set -l history_args --null --show-time="%F %a %T │ "
        set -l fish_path (status fish-path)
        set -l history_script

        if test -z "$fish_private_mode"
            builtin history save
            set history_script (string join ' ' -- \
                'builtin history merge;' 'builtin history' (string escape -- $history_args))
        end

        set -lx FZF_DEFAULT_OPTS (__fzf_defaults '' \
            "--read0 --print0 --multi --scheme=history $FZF_CTRL_R_OPTS")
        set -lx FZF_DEFAULT_OPTS_FILE
        set -l query (commandline | string collect)
        set -l commands_selected (
            begin
                if test -n "$fish_private_mode"
                    builtin history $history_args
                else
                    $fish_path -c $history_script
                end
            end |
            fzf --query=$query --delimiter=' │ ' --nth=2.. \
                --preview="string replace -r '$time_prefix_regex' '' -- {} | fish_indent --ansi" \
                --preview-window=bottom,3,wrap --with-shell=$fish_path' -c' |
            string split0 |
            string replace -r $time_prefix_regex ''
        )

        if test $status -eq 0
            commandline --replace -- $commands_selected
        end
        commandline -f repaint
    end
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

function o --description 'Open the current directory in the file manager'
    command gio open "$PWD" &>/dev/null
end

abbr --add lg lazygit
abbr --add dotfiles chezmoi
abbr --add j just
abbr --add claude-auto 'claude --enable-auto-mode'

abbr --add zz zellij
abbr --add za 'zellij attach'
abbr --add zl 'zellij list-sessions'
abbr --add zk 'zellij kill-all-sessions'
abbr --add zw 'zellij attach -c work'

function zn --description 'Attach to a zellij session named after the current directory'
    zellij attach -c (basename "$PWD") $argv
end
