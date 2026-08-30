function with-proxy --description 'Run one command through the local proxies'
    if test (count $argv) -eq 0
        echo 'Usage: with-proxy COMMAND [ARG ...]' >&2
        return 2
    end

    set -lx PROXY_SOCKS5 socks5://127.0.0.1:10808
    set -lx ALL_PROXY $PROXY_SOCKS5
    set -lx HTTP_PROXY http://127.0.0.1:10809
    set -lx HTTPS_PROXY $HTTP_PROXY
    set -lx WS_PROXY $HTTP_PROXY
    set -lx WSS_PROXY $HTTPS_PROXY

    set -lx all_proxy $ALL_PROXY
    set -lx http_proxy $HTTP_PROXY
    set -lx https_proxy $HTTPS_PROXY
    set -lx ws_proxy $HTTP_PROXY
    set -lx wss_proxy $HTTPS_PROXY

    command $argv
end
