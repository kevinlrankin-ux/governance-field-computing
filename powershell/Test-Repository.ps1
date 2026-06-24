Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$root = Split-Path -Parent $PSScriptRoot
$required = @(
  "README.md",
  "LICENSE.md",
  "CONTRIBUTING.md",
  "CODE_OF_CONDUCT.md",
  "CHANGELOG.md",
  "docs/artifacts/FOUNDATIONAL_ARTIFACTS.md",
  "schemas/pressure-driver-bisection.schema.json",
  "examples/bacteria-driver-bisection.example.json"
)

foreach ($path in $required) {
  $full = Join-Path $root $path
  if (-not (Test-Path $full)) {
    throw "Missing required file: $path"
  }
}

Get-Content (Join-Path $root "schemas/pressure-driver-bisection.schema.json") -Raw | ConvertFrom-Json | Out-Null
Get-Content (Join-Path $root "examples/bacteria-driver-bisection.example.json") -Raw | ConvertFrom-Json | Out-Null

Write-Host "Repository checks passed."
