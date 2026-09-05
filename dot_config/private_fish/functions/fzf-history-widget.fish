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
