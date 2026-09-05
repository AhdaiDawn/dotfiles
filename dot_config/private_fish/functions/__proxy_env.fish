function __proxy_env --description 'Print the shared local proxy environment'
    set -l socks socks5://127.0.0.1:10808
    set -l http http://127.0.0.1:10809

    for name in PROXY_SOCKS5 ALL_PROXY all_proxy
        printf '%s=%s\n' $name $socks
    end
    for name in HTTP_PROXY HTTPS_PROXY WS_PROXY WSS_PROXY http_proxy https_proxy ws_proxy wss_proxy
        printf '%s=%s\n' $name $http
    end
end
