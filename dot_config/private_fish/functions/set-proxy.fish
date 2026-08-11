function set-proxy --description 'Enable the local HTTP and SOCKS proxies'
    set -gx PROXY_SOCKS5 socks5://127.0.0.1:10808
    set -gx ALL_PROXY $PROXY_SOCKS5
    set -gx HTTP_PROXY http://127.0.0.1:10809
    set -gx HTTPS_PROXY $HTTP_PROXY
    set -gx WS_PROXY $HTTP_PROXY
    set -gx WSS_PROXY $HTTPS_PROXY

    set -gx all_proxy $ALL_PROXY
    set -gx http_proxy $HTTP_PROXY
    set -gx https_proxy $HTTPS_PROXY
    set -gx ws_proxy $HTTP_PROXY
    set -gx wss_proxy $HTTPS_PROXY
end
