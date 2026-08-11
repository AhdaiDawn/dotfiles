function reset-proxy --description 'Disable the local HTTP and SOCKS proxies'
    set -eg PROXY_SOCKS5 ALL_PROXY HTTP_PROXY HTTPS_PROXY WS_PROXY WSS_PROXY
    set -eg all_proxy http_proxy https_proxy ws_proxy wss_proxy
end
