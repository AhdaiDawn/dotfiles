# Shared environment for interactive and non-interactive fish shells.
set -gx EDITOR nvim

set -gx RUSTUP_UPDATE_ROOT https://mirrors.tuna.tsinghua.edu.cn/rustup/rustup
set -gx RUSTUP_DIST_SERVER https://mirrors.tuna.tsinghua.edu.cn/rustup

# Add in reverse precedence order because each call prepends its path.
fish_add_path --path --move --prepend "$HOME/.opencode/bin"
fish_add_path --path --move --prepend "$HOME/.local/bin"
