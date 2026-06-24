# Governance Field Computing
# Pressure Layer Taxonomy Validator
# Version 0.2

$path = Join-Path $PSScriptRoot "..\examples\pressure-layer-taxonomy.example.json"

if (-not (Test-Path $path))
{
    throw "File not found: $path"
}

$data = Get-Content $path -Raw | ConvertFrom-Json

$requiredFields = @(
    "governance_phrase",
    "driver",
    "pressure",
    "prerequisite_truth",
    "first_principle"
)

foreach ($field in $requiredFields)
{
    if (-not $data.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required field: $field"
    }
}

Write-Host ""
Write-Host "PASS: Pressure Layer Taxonomy validated."
Write-Host "Driver:" $data.driver
Write-Host "Pressure:" $data.pressure
Write-Host "Prerequisite Truth:" $data.prerequisite_truth
Write-Host "First Principle:" $data.first_principle

if ($data.PSObject.Properties.Name.Contains("failure_visibility"))
{
    Write-Host "Failure Visibility: present"

    if ($data.failure_visibility.PSObject.Properties.Name.Contains("descriptors"))
    {
        Write-Host "Failure Visibility Descriptors:" ($data.failure_visibility.descriptors -join ", ")
    }

    if ($data.failure_visibility.PSObject.Properties.Name.Contains("description"))
    {
        Write-Host "Failure Visibility Description:" $data.failure_visibility.description
    }
}
else
{
    Write-Host "Failure Visibility: not present"
}