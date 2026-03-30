function ToAbsolutePath {
    param (
        [string]$RelativePath
    )

    $scriptRoot = if ($PSScriptRoot) { $PSScriptRoot } else { Split-Path -Parent $MyInvocation.MyCommand.Path }
    $configPath = Join-Path $scriptRoot $RelativePath
    $resolvedPath = Resolve-Path $configPath -ErrorAction SilentlyContinue

    if ($resolvedPath) {
        return $resolvedPath.Path
    } else {
        Write-Error "路径不存在: $configPath"
        return $null
    }
}

# powershell profile
New-Item -Force -ItemType SymbolicLink -Path $PROFILE -Target (ToAbsolutePath "Microsoft.PowerShell_profile.ps1")

# vsvimrc
New-Item -Force -ItemType SymbolicLink -Path "~\_vsvimrc" -Target (ToAbsolutePath "_vsvimrc")
