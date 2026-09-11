[CmdletBinding()]
param(
    [string]$VaultPath,
    [string]$PackagePath,
    [switch]$Enable,
    [switch]$AllVaults,
    [ValidateSet('claude-oauth','copilot','codex-oauth','')][string]$InitialProvider = '',
    [string]$InitialModel = '',
    [string]$ObsidianConfig = (Join-Path $env:APPDATA 'obsidian\obsidian.json')
)
$ErrorActionPreference = 'Stop'
function Get-PackageHash([string]$Path) {
    $hasher = [Security.Cryptography.SHA256]::Create()
    try { [BitConverter]::ToString($hasher.ComputeHash([IO.File]::ReadAllBytes($Path))) }
    finally { $hasher.Dispose() }
}
function Test-RedirectedPath([string]$Path) {
    if (!(Test-Path -LiteralPath $Path)) { return $false }
    if (!((Get-Item -LiteralPath $Path -Force).Attributes -band [IO.FileAttributes]::ReparsePoint)) { return $false }
    # OneDrive Cloud Files tags mark hydration placeholders, not path redirects.
    # Permit only that tag family; junctions, symlinks and unknown tags fail closed.
    $details = (& fsutil.exe reparsepoint query $Path 2>&1 | Out-String)
    if ($LASTEXITCODE -ne 0) { return $true }
    $tag = [regex]::Match($details, '0x([0-9a-fA-F]{8})')
    if (!$tag.Success) { return $true }
    $value = [Convert]::ToUInt32($tag.Groups[1].Value,16)
    return (($value -band [Convert]::ToUInt32('FFFF0FFF',16)) -ne [Convert]::ToUInt32('9000001A',16))
}

try {
    if (!$PackagePath) { $PackagePath = Split-Path -Parent $MyInvocation.MyCommand.Path }
    $packageRoot = (Resolve-Path -LiteralPath $PackagePath).Path
    $manifest = Get-Content -Raw -LiteralPath (Join-Path $packageRoot 'manifest.json') | ConvertFrom-Json
    if ($manifest.id -ne 'pericode') { throw 'This is not a PeriCode Inside package.' }
    $files = @('main.js', 'manifest.json', 'styles.css')
    foreach ($file in $files) {
        $source = Join-Path $packageRoot $file
        if (!(Test-Path -LiteralPath $source -PathType Leaf) -or (Get-Item -LiteralPath $source).Length -eq 0) {
            throw "Incomplete package: $file is missing or empty. Extract the full release ZIP first."
        }
    }

    Write-Host "PeriCode Inside $($manifest.version) installer"
    if ($AllVaults) {
        if ($VaultPath) { throw 'Use either -AllVaults or -VaultPath.' }
        $registered = Get-Content -Raw -LiteralPath $ObsidianConfig | ConvertFrom-Json
        $paths = @($registered.vaults.PSObject.Properties.Value.path | Sort-Object -Unique)
        if (!$paths.Count) { throw 'No registered vaults were found.' }
        $failed = @()
        foreach ($path in $paths) {
            $arguments = @('-NoProfile','-File',$PSCommandPath,'-VaultPath',$path,'-PackagePath',$packageRoot)
            if ($Enable) { $arguments += '-Enable' }
            if ($InitialProvider) { $arguments += @('-InitialProvider',$InitialProvider,'-InitialModel',$InitialModel) }
            & powershell.exe @arguments
            if ($LASTEXITCODE -ne 0) { $failed += $path }
        }
        if ($failed.Count) { throw ('Could not install in: ' + ($failed -join ', ')) }
        Write-Host "Installed in all $($paths.Count) registered vaults." -ForegroundColor Green
        exit 0
    }
    if (!$VaultPath) {
        $vaults = @()
        if (Test-Path -LiteralPath $ObsidianConfig) {
            $config = Get-Content -Raw -LiteralPath $ObsidianConfig | ConvertFrom-Json
            $vaults = @($config.vaults.PSObject.Properties.Value |
                Where-Object { Test-Path -LiteralPath (Join-Path $_.path '.obsidian') -PathType Container } |
                Sort-Object -Property @{Expression='open';Descending=$true}, @{Expression='ts';Descending=$true})
        }
        if ($vaults.Count -eq 1) { $VaultPath = $vaults[0].path }
        elseif ($vaults.Count -gt 1) {
            for ($i=0; $i -lt $vaults.Count; $i++) {
                $suffix = if ($vaults[$i].open) { ' (open)' } else { '' }
                Write-Host "  $($i+1). $($vaults[$i].path)$suffix"
            }
            $choice = Read-Host 'Choose a vault number, or enter its full folder path'
            $index = 0
            if ([int]::TryParse($choice, [ref]$index)) {
                if ($index -lt 1 -or $index -gt $vaults.Count) { throw 'Invalid vault number. Nothing installed.' }
                $VaultPath = $vaults[$index-1].path
            } else { $VaultPath = $choice }
        } else { $VaultPath = Read-Host 'Enter your Obsidian vault folder path' }
    }
    if ([string]::IsNullOrWhiteSpace($VaultPath)) { throw 'No vault selected. Nothing installed.' }
    $vaultRoot = (Resolve-Path -LiteralPath $VaultPath.Trim('"')).Path
    $configRoot = Join-Path $vaultRoot '.obsidian'
    if (!(Test-Path -LiteralPath $configRoot -PathType Container)) { throw 'The selected folder is not an existing Obsidian vault.' }
    $pluginsRoot = Join-Path $configRoot 'plugins'
    $target = Join-Path $pluginsRoot 'pericode'
    # Refuse redirected configuration paths so copies cannot escape the chosen vault.
    foreach ($dir in @($configRoot, $pluginsRoot, $target, (Join-Path $configRoot 'pericode-backups'))) {
        if (Test-RedirectedPath $dir) {
            throw "Linked configuration folder is not supported by this installer: $dir"
        }
    }
    foreach ($file in @($files) + @('data.json')) {
        $dest = Join-Path $target $file
        if (Test-RedirectedPath $dest) {
            throw "Linked plugin file is not supported: $dest"
        }
    }
    $backup = $null
    $existing = @($files | Where-Object { Test-Path -LiteralPath (Join-Path $target $_) })
    if ($existing.Count -gt 0) {
        $backup = Join-Path $configRoot ('pericode-backups\' + [DateTime]::UtcNow.ToString('yyyyMMdd-HHmmss') + '-' + [Guid]::NewGuid().ToString('N'))
        New-Item -ItemType Directory -Path $backup -Force | Out-Null
        foreach ($file in $existing) { Copy-Item -LiteralPath (Join-Path $target $file) -Destination (Join-Path $backup $file) }
    }
    New-Item -ItemType Directory -Path $target -Force | Out-Null
    try {
        foreach ($file in $files) {
            $source = Join-Path $packageRoot $file
            $dest = Join-Path $target $file
            Copy-Item -LiteralPath $source -Destination $dest -Force
            if ((Get-PackageHash $source) -ne (Get-PackageHash $dest)) { throw "Copy verification failed: $file" }
        }
    } catch {
        if ($backup) {
            foreach ($file in $existing) { Copy-Item -LiteralPath (Join-Path $backup $file) -Destination (Join-Path $target $file) -Force }
        }
        throw
    }
    Write-Host "Installed and verified in $target" -ForegroundColor Green
    # Seed only subscription selection in a fresh installation. Never copy
    # credentials, chats, licenses, MCP configuration, or vault permissions.
    $settingsFile = Join-Path $target 'data.json'
    if ($InitialProvider -and !(Test-Path -LiteralPath $settingsFile)) {
        $initial = @{ provider=$InitialProvider; model=$InitialModel } | ConvertTo-Json
        [IO.File]::WriteAllText($settingsFile, $initial, (New-Object Text.UTF8Encoding($false)))
    }
    if ($Enable) {
        $enabledFile = Join-Path $configRoot 'community-plugins.json'
        $enabledIds = @()
        if (Test-Path -LiteralPath $enabledFile) {
            if (Test-RedirectedPath $enabledFile) { throw 'Linked enabled-plugin configuration is not supported.' }
            $rawEnabled = [IO.File]::ReadAllText($enabledFile)
            if (!$rawEnabled.TrimStart().StartsWith('[')) { throw 'Enabled-plugin configuration must be a JSON array.' }
            $parsedEnabled = ConvertFrom-Json -InputObject $rawEnabled
            $enabledIds = @($parsedEnabled)
            if (@($enabledIds | Where-Object { $_ -isnot [string] }).Count) { throw 'Enabled-plugin configuration contains invalid entries.' }
        }
        if ($enabledIds -notcontains 'pericode') {
            if (!$backup) {
                $backup = Join-Path $configRoot ('pericode-backups\' + [Guid]::NewGuid().ToString('N'))
                New-Item -ItemType Directory -Path $backup -Force | Out-Null
            }
            if (Test-Path -LiteralPath $enabledFile) { Copy-Item -LiteralPath $enabledFile -Destination (Join-Path $backup 'community-plugins.json') }
            $json = ConvertTo-Json -InputObject @($enabledIds + 'pericode')
            [IO.File]::WriteAllText($enabledFile, $json, (New-Object Text.UTF8Encoding($false)))
        }
        Write-Host 'PeriCode is enabled for this vault on its next open.'
    }
    Write-Host 'Existing settings, credentials, conversations and notes were preserved.'
    if ($backup) { Write-Host "Previous plugin files: $backup" }
    $activated = $false
    $cli = Get-Command 'Obsidian.com' -ErrorAction SilentlyContinue
    if ($Enable -and $cli -and (Get-Process -Name Obsidian -ErrorAction SilentlyContinue)) {
        # Confirm the named vault resolves to exactly the selected folder before activation.
        $vaultArg = 'vault=' + (Split-Path -Leaf $vaultRoot)
        $resolvedVault = (& $cli.Source vault $vaultArg 'info=path' 2>&1 | Out-String).Trim()
        if ($resolvedVault -eq $vaultRoot) {
            # Refresh discovery after copying a new plugin into a running app.
            & $cli.Source eval $vaultArg 'code=app.plugins.loadManifests()' | Out-Null
            $activation = (& $cli.Source plugin:enable $vaultArg 'id=pericode' 'filter=community' 2>&1 | Out-String).Trim()
            Write-Host $activation
            $enabled = @(& $cli.Source plugins:enabled $vaultArg 'filter=community' 2>&1)
            $activated = @($enabled | Where-Object { $_.ToString().Trim() -eq 'pericode' }).Count -gt 0
            if ($activated) {
                & $cli.Source plugin:reload $vaultArg 'id=pericode'
                Write-Host 'PeriCode Inside is enabled in Obsidian.' -ForegroundColor Green
            }
        }
    }
    if (!$activated -and $Enable) {
        Write-Host 'Open this vault in Obsidian to use the PeriCode ribbon button.'
    } elseif (!$activated) {
        Write-Host 'Files are installed. Enable PeriCode Inside in Obsidian Settings > Community plugins.'
        Write-Host 'If already enabled, reload the plugin or restart Obsidian.'
    }
    Write-Host 'Then choose your model provider in Settings > PeriCode.'
} catch {
    Write-Host "Installation failed: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
