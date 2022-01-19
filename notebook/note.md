# note

## 常用命令
- vim `<C-z>`把前台任务放在后台
- jobs 查看后台任务 - fg %n 将后台任务移到前台 kill
- <C-x><C-e> 将命令行命令放在vim中编辑
- jq 格式化json
- htop 系统状态
- ncdu 显示磁盘占用
- neofetch 优雅的打印系统信息
- axel 多线程下载器
- extract zsh解压插件
- cloc 分析统计代码工具

## tmux 命令
使用zsh tmux插件<https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/tmux>

| Alias	| Command Description |
| -----	|  ------------------- |
| ta	| tmux attach -t Attach  named tmux session|
| tad	| tmux attach -d -t Detach named tmux session |
| ts	| tmux new-session -s Create a new named tmux session |
| tl	| tmux list-sessions Displays a list of running tmux sessions |
| tksv	| tmux kill-server Terminate all running tmux sessions |
| tkss	| tmux kill-session -t Terminate named running tmux session |
| tmux	| `_zsh_tmux_plugin_run`Start a new tmux session |

使用.tmux<https://github.com/gpakosz/.tmux>

tmux-resurrect
- prefix + Ctrl-s - save
- prefix + Ctrl-r - restore
