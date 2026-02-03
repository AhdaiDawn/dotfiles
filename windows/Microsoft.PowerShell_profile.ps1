Import-Module PSReadLine

Set-PSReadlineOption -EditMode vi
Set-PSReadLineOption -PredictionSource History # 设置预测文本来源为历史记录
Set-PSReadLineOption -HistorySearchCursorMovesToEnd:$true
Set-PSReadlineKeyHandler -Key Tab -Function Complete # 设置 Tab 键补全
# Set-PSReadLineKeyHandler -Key "Ctrl+d" -Function MenuComplete # 设置 Ctrl+d 为菜单补全和 Intellisense
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward # 设置向上键为后向搜索历史记录
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward # 设置向下键为前向搜索历史纪录
Set-PSReadLineKeyHandler -Chord Ctrl-a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Chord Ctrl-e -Function EndOfLine
Set-PSReadLineKeyHandler -Chord Ctrl-f -Function ForwardChar
Set-PSReadLineKeyHandler -Chord Ctrl-b -Function BackwardChar

# 设置提示符
function prompt {
  $p = Split-Path -leaf -path (Get-Location)
  "$p> "
}

Invoke-Expression (& { (zoxide init powershell | Out-String) })

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
  scoop config proxy 127.0.0.1:10808
}

# need: Install-Module VSSetup -Scope CurrentUser
function Set-VsDev{
  Import-Module VSSetup
  Import-Module ((Get-VSSetupInstance)[0].InstallationPath + "\Common7\Tools\Microsoft.VisualStudio.DevShell.dll")
  Enter-VsDevShell -SkipAutomaticLocation -InstanceId (Get-VSSetupInstance)[0].InstanceId
}

# 取消代理
function Reset-Proxy {
  git config --global --unset http.https://github.com.proxy
  $env:ALL_PROXY = ""
  # $env:HTTPS_PROXY=""
  # $env:HTTP_PROXY=""
  # [System.Net.HttpWebRequest]::DefaultWebProxy = New-Object System.Net.WebProxy($null) # for powershell5
  [System.Net.Http.HttpClient]::DefaultProxy = New-Object System.Net.WebProxy($null) # for powershell7
  scoop config rm proxy
}

Set-Alias -Name lg -Value lazygit
function l { eza --icons }
function la { eza -a --icons }
function ll { eza -al --icons }
Set-Alias -Name j -Value just

