function ToAbsolutePath {
    param (
        [string]$RelativePath
    )

    $configPath = Join-Path $PWD $RelativePath
    $resolvedPath = Resolve-Path $configPath -ErrorAction SilentlyContinue

    if ($resolvedPath) {
        return $resolvedPath.Path
    } else {
        Write-Error "路径不存在: $configPath"
        return $null
    }
}

# powershell profile
New-Item -Force -ItemType SymbolicLink -Path $PROFILE -Target (ToAbsolutePath "windows\Microsoft.PowerShell_profile.ps1")

# vsvimrc
New-Item -Force -ItemType SymbolicLink -Path "~\_vsvimrc" -Target (ToAbsolutePath "windows\_vsvimrc")
