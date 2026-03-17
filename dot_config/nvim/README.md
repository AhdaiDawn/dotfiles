# Neovim 配置

基于 lazy.nvim 的现代化 Neovim 配置。

## 特性

- 📦 使用 [lazy.nvim](https://github.com/folke/lazy.nvim) 管理插件
- 🔧 使用 [mason.nvim](https://github.com/mason-org/mason.nvim) 管理 LSP 服务器
- ⚙️ 使用 [neoconf.nvim](https://github.com/folke/neoconf.nvim) 支持项目级配置
- 🎨 Gruvbox 配色主题
- 🔍 FZF 模糊查找
- 💡 Blink.cmp 智能补全
- 🤖 Supermaven AI 代码补全
- 🌳 Treesitter 语法高亮

## 已配置的 LSP

- Lua (lua_ls)
- C/C++ (clangd)
- Zig (zls)

## 项目结构

```
.
├── init.lua              # 入口文件
├── lua/
│   ├── config/          # 核心配置
│   │   ├── options.lua  # Vim 选项
│   │   ├── keymaps.lua  # 快捷键映射
│   │   └── autocmds.lua # 自动命令
│   └── plugins/         # 插件配置
│       ├── editor.lua   # 编辑器增强插件
│       ├── lsp.lua      # LSP 配置
│       └── ui.lua       # UI 插件
├── .neoconf.json        # 项目级 LSP 配置
├── .luarc.json          # Lua LSP 配置
└── NEOCONF_GUIDE.md     # Neoconf 使用指南

## 快捷键

### Leader 键
空格键 (Space)

### 文件操作
- `<leader>fs` - 保存文件
- `<leader>fn` - 新建文件

### 窗口管理
- `<leader>\\` - 垂直分割
- `<leader>-` - 水平分割
- `<C-h/j/k/l>` - 窗口间导航

### Buffer 管理
- `H` - 上一个 buffer
- `L` - 下一个 buffer
- `<leader>x` - 关闭 buffer
- `<leader>1-9` - 跳转到指定 buffer

### 查找
- `<leader>o` - 查找文件
- `<leader>f` - 全局搜索
- `<leader>b` - 查找 buffer
- `<leader>r` - 最近文件
- `<leader>/` - 当前文件搜索

### LSP
- `gd` - 跳转到定义
- `gr` - 查找引用
- `gi` - 跳转到实现
- `K` - 显示文档
- `<leader>rn` - 重命名
- `<leader>ca` - 代码操作
- `<leader>fm` - 格式化代码

### Git
- `<leader>lg` - 打开 LazyGit
- `<A-e>` - 切换文件树

### 编辑
- `<C-space>` - 扩展选择（Treesitter）
- `<bs>` - 缩小选择
- `s` - Leap 跳转
- `<A-j/k>` - 移动行（Visual 模式）

## 安装

1. 备份现有配置
2. 克隆此配置到 `~/.config/nvim`
3. 启动 Neovim，lazy.nvim 会自动安装插件
4. 运行 `:checkhealth` 检查配置

## 项目级配置

在任何项目根目录创建 `.neoconf.json` 来自定义该项目的 LSP 配置。

详见 [NEOCONF_GUIDE.md](./NEOCONF_GUIDE.md)

## 依赖

- Neovim >= 0.10
- Git
- [Nerd Font](https://www.nerdfonts.com/)
- ripgrep (用于搜索)
- fd (可选，用于文件查找)
- lazygit (可选，用于 Git 管理)
