function with-proxy --description 'Run one command through the local proxies'
    if test (count $argv) -eq 0
        echo 'Usage: with-proxy COMMAND [ARG ...]' >&2
        return 2
    end

    command env (__proxy_env) $argv
end
