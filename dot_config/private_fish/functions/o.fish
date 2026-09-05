function o --description 'Open the current directory in the file manager'
    command gio open "$PWD" &>/dev/null
end
