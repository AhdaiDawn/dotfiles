# 前言
使用lua配置nvim.
配置路径(使用目录链接)：
    -管理员模式下windows powershell : `New-Item -Path C:\Users\17579\AppData\Local\nvim -ItemType SymbolicLink -Value C:\Users\17579\dotfiles\.config\nvim`

插件管理器使用packer.`https://github.com/wbthomason/packer.nvim#quickstart`

配置好后使用：`:checkhealth`,按照output补齐需要的依赖配置。

# tips
fugitive:
    :Gdiffsplit =>
            dp (:diffput)
            :diffget
            [c jump to previous hunk
            ]c jump to previous hunk
    :Git add %	:Gwrite	Stage the current file to the index
    :Git checkout %	:Gread	Revert current file to last checked in version
    :Git rm %	:Gremove	Delete the current file and the corresponding Vim buffer
    :Git mv %	:Gmove	Rename the current file and the corresponding Vim buffer
    :Gclog load all previous revisions of the current file into the quickfix list

change work dir: `cd %:h`

orgmode:
- Open agenda prompt: <Leader>oa
- Open capture prompt: <Leader>oc
- In any orgmode buffer press g? for help

# vim易忘技巧
- `<C-z>`把前台任务放在后台 jobs查看后台任务 - fg %n 将后台任务移到前台 kill
- 搜索时可以用 `CTRL-R CTRL-W` 插入光标下的单词，命令模式也能这么用
- `CTRL-R "` 将复制的内容粘贴到命令模式
