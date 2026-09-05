function set-proxy --description 'Enable the local HTTP and SOCKS proxies'
    for entry in (__proxy_env)
        set -l pair (string split -m 1 = -- $entry)
        set -gx $pair[1] $pair[2]
    end
end
