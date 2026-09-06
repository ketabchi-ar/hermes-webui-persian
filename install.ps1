# ==============================================================================
# Hermes WebUI Persian & RTL Support - Windows PowerShell Installer
# ==============================================================================

$ErrorActionPreference = "Stop"

Write-Host "====================================================" -ForegroundColor Cyan
Write-Host "    Hermes WebUI Persian & RTL Installer 🇮🇷         " -ForegroundColor Cyan
Write-Host "====================================================" -ForegroundColor Cyan

$StateDir = if ($env:HERMES_WEBUI_STATE_DIR) { $env:HERMES_WEBUI_STATE_DIR } else { Join-Path $HOME ".hermes\webui" }
$TargetDir = Join-Path $StateDir "extensions\vazir-persian-rtl"
$ManifestFile = Join-Path $StateDir "extension-install-manifest.json"

New-Item -ItemType Directory -Force -Path $TargetDir | Out-Null

$ZipUrl = "https://github.com/m4tinbeigi-official/hermes-webui-persian/archive/refs/heads/main.zip"
$TempZip = Join-Path $env:TEMP "hermes-persian.zip"
$TempExtract = Join-Path $env:TEMP "hermes-persian-extract"

Write-Host "Downloading Persian extension package..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $ZipUrl -OutFile $TempZip

if (Test-Path $TempExtract) { Remove-Item -Recurse -Force $TempExtract }
Expand-Archive -Path $TempZip -DestinationPath $TempExtract

$ExtSource = Join-Path $TempExtract "hermes-webui-persian-main\vazir-persian-rtl"
Copy-Item -Path "$ExtSource\*" -Destination $TargetDir -Recurse -Force

Remove-Item -Force $TempZip
Remove-Item -Recurse -Force $TempExtract

# Update manifest
$ManifestData = @{ version = 1; installed = @{} }
if (Test-Path $ManifestFile) {
    try {
        $Raw = Get-Content -Raw -Path $ManifestFile | ConvertFrom-Json
        if ($Raw.installed) { $ManifestData.installed = $Raw.installed }
    } catch {}
}

$ManifestData.installed["vazir-persian-rtl"] = @{
    version = "1.0.0"
    files = @(
        "manifest.json",
        "vazir-rtl.css",
        "vazir-rtl.js",
        "fonts/Vazirmatn-Regular.woff2",
        "fonts/Vazirmatn-Medium.woff2",
        "fonts/Vazirmatn-SemiBold.woff2",
        "fonts/Vazirmatn-Bold.woff2"
    )
    installed_at = (Get-Date).ToUniversalTime().ToString("yyyy-MM-ddTHH:mm:ssZ")
}

$ManifestData | ConvertTo-Json -Depth 5 | Set-Content -Path $ManifestFile -Encoding UTF8

Write-Host "`n✓ Persian & Vazirmatn RTL support installed successfully!" -ForegroundColor Green
Write-Host "✓ Persistent across Hermes WebUI updates & restarts." -ForegroundColor Green
Write-Host "Please refresh your Hermes WebUI browser tab to apply.`n" -ForegroundColor Cyan
