Import-Module PSReadLine

Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -PredictionSource History # 设置预测文本来源为历史记录
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true
Set-PSReadlineKeyHandler -Key Tab -Function Complete # 设置 Tab 键补全
# Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete # 设置 Ctrl+d 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward # 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward # 设置向下键为前向搜索历史纪录

# 设置提示符
function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "$p> "
}

#navigation macros
function .{ Set-Location . }
function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }
function ..... { Set-Location ..\..\..\.. }
function ~ { Set-Location $env:USERPROFILE }

# 设置代理
function Set-Proxy {
  #   [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy('http://127.0.0.1:41091', $true) # for powershell5
  [System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy('http://127.0.0.1:41091', $true) # for powershell7
  git config --global http.https://github.com.proxy "socks5://127.0.0.1:10808"
  $env:ALL_PROXY = "socks5://127.0.0.1:10808"
  # $env:HTTPS_PROXY="https://127.0.0.1:10808"
  # $env:HTTP_PROXY="http://127.0.0.1:10808"
}

# 取消代理
function Reset-Proxy {
  git config --global --unset http.https://github.com.proxy
  $env:ALL_PROXY = ""
  # $env:HTTPS_PROXY=""
  # $env:HTTP_PROXY=""
  # [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($null) # for powershell5
  [System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy($null) # for powershell7
}

Set-Alias -Name lg -Value lazygit
