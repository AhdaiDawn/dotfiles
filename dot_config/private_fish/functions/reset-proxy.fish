function reset-proxy --description 'Disable the local HTTP and SOCKS proxies'
    for entry in (__proxy_env)
        set -l pair (string split -m 1 = -- $entry)
        set -eg $pair[1]
    end
end
