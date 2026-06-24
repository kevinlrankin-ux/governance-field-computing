Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$parent = Split-Path -Parent $root
$name = Split-Path -Leaf $root
$zip = Join-Path $parent "$name.zip"

if (Test-Path $zip) {
  Remove-Item $zip -Force
}

Compress-Archive -Path (Join-Path $root "*") -DestinationPath $zip -Force
Write-Host "Packaged repository: $zip"
