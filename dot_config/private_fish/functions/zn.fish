function zn --description 'Attach to a zellij session named after the current directory'
    zellij attach -c (basename "$PWD") $argv
end
