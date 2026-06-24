# Governance Field Computing
# Pressure Driver Bisection Validation
# Version: 0.3

$path = Join-Path $PSScriptRoot "..\examples\bacteria-driver-bisection.example.json"

if (-not (Test-Path $path))
{
    throw "File not found: $path"
}

$data = Get-Content $path -Raw | ConvertFrom-Json

$requiredFields = @(
    "driver",
    "source_phrase",
    "interrogatives",
    "prerequisite_truths",
    "evidence_status",
    "exploration_value"
)

foreach ($field in $requiredFields)
{
    if (-not $data.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required field: $field"
    }
}

Write-Host ""
Write-Host "PASS: Pressure Driver Bisection validated."
Write-Host "Driver:" $data.driver
Write-Host "Evidence Status:" $data.evidence_status