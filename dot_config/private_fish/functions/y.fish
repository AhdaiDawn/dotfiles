function y --description 'Run yazi and change to its final directory'
    set -l tmp (mktemp -t yazi-cwd.XXXXXX)
    or return 1

    command yazi $argv --cwd-file="$tmp"
    set -l yazi_status $status

    if set -l cwd (command cat -- "$tmp")
        if test -n "$cwd" && test "$cwd" != "$PWD" && test -d "$cwd"
            builtin cd -- "$cwd"
        end
    end

    command rm -f -- "$tmp"
    return $yazi_status
end
