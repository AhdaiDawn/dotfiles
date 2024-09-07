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

# nvim config
New-Item -Force -ItemType SymbolicLink -Path "~\AppData\Local\nvim" -Target (ToAbsolutePath ".config\nvim")

# lazygit config
New-Item -Force -ItemType SymbolicLink -Path "~\AppData\Local\lazygit" -Target (ToAbsolutePath ".config\lazygit")

# powershell profile
New-Item -Force -ItemType SymbolicLink -Path "~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target (ToAbsolutePath "windows\Microsoft.PowerShell_profile.ps1")

# vsvimrc
New-Item -Force -ItemType SymbolicLink -Path "~\_vsvimrc" -Target (ToAbsolutePath "windows\_vsvimrc")