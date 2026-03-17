# Neoconf.nvim 使用指南

## 简介
neoconf.nvim 允许你在项目根目录创建配置文件来控制该项目的 LSP 行为。

## 配置文件位置
在项目根目录创建以下任一文件：
- `.neoconf.json` (推荐)
- `.neoconf.jsonc` (支持注释)
- `.nvim/settings.json`

## 基本用法

### 1. 创建项目配置
在项目根目录创建 `.neoconf.json`：

```json
{
  "$schema": "https://raw.githubusercontent.com/folke/neoconf.nvim/main/schemas/neoconf.json",
  "lspconfig": {
    "pyright": {
      "enabled": true
    }
  }
}
```

### 2. 启用/禁用 LSP
```json
{
  "lspconfig": {
    "rust_analyzer": {
      "enabled": true
    },
    "clangd": {
      "enabled": false
    }
  }
}
```

### 3. 自定义 LSP 设置
```json
{
  "lspconfig": {
    "lua_ls": {
      "settings": {
        "Lua": {
          "workspace": {
            "library": ["./custom-lib"]
          },
          "diagnostics": {
            "globals": ["vim", "awesome"]
          }
        }
      }
    }
  }
}
```

### 4. 修改 LSP 启动命令
```json
{
  "lspconfig": {
    "clangd": {
      "cmd": ["clangd", "--background-index", "--clang-tidy"]
    }
  }
}
```

## 常用命令
- `:Neoconf` - 打开配置面板
- `:Neoconf show` - 显示当前项目的完整配置
- `:Neoconf lsp` - 显示 LSP 配置

## 配置优先级
1. 项目本地配置 (`.neoconf.json`)
2. 全局配置 (`~/.config/nvim/.neoconf.json`)
3. 插件默认配置

## 常见场景示例

### Python 项目
```json
{
  "lspconfig": {
    "pyright": {
      "enabled": true,
      "settings": {
        "python": {
          "analysis": {
            "typeCheckingMode": "strict",
            "autoSearchPaths": true,
            "useLibraryCodeForTypes": true
          }
        }
      }
    },
    "ruff_lsp": {
      "enabled": true
    }
  }
}
```

### Rust 项目
```json
{
  "lspconfig": {
    "rust_analyzer": {
      "enabled": true,
      "settings": {
        "rust-analyzer": {
          "cargo": {
            "features": "all"
          },
          "checkOnSave": {
            "command": "clippy"
          }
        }
      }
    }
  }
}
```

### C/C++ 项目
```json
{
  "lspconfig": {
    "clangd": {
      "enabled": true,
      "cmd": [
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--completion-style=detailed"
      ]
    }
  }
}
```

### TypeScript 项目
```json
{
  "lspconfig": {
    "ts_ls": {
      "enabled": true,
      "settings": {
        "typescript": {
          "inlayHints": {
            "includeInlayParameterNameHints": "all"
          }
        }
      }
    },
    "eslint": {
      "enabled": true
    }
  }
}
```

## 导入其他编辑器配置
neoconf 可以自动导入其他编辑器的配置：
- VSCode: `.vscode/settings.json`
- Coc.nvim: `coc-settings.json`
- nlsp-settings: `.nlsp-settings/`

## 提示
1. 使用 `$schema` 可以在编辑配置文件时获得自动补全
2. 配置文件可以提交到版本控制，团队共享配置
3. 可以在全局配置中设置默认值，项目配置中覆盖
