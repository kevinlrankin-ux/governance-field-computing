# Governance Field Computing
# Pressure Layer Taxonomy Adversarial Validator
# Version 0.1

$path = Join-Path $PSScriptRoot "..\examples\pressure-layer-taxonomy.invalid.example.json"

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
    "first_principle",
    "expected_validation_result",
    "failure_reason"
)

foreach ($field in $requiredFields)
{
    if (-not $data.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required field: $field"
    }
}

Write-Host ""
Write-Host "ADVERSARIAL FIXTURE LOADED."
Write-Host "Governance Phrase:" $data.governance_phrase
Write-Host "Driver:" $data.driver
Write-Host "Pressure:" $data.pressure
Write-Host "Prerequisite Truth:" $data.prerequisite_truth
Write-Host "First Principle:" $data.first_principle
Write-Host "Expected Validation Result:" $data.expected_validation_result
Write-Host ""
Write-Host "KNOWN LIMITATION:"
Write-Host "This test currently verifies that the invalid fixture exists and is structurally readable."
Write-Host "It does not yet prove semantic rejection."
Write-Host ""
Write-Host "PASS: Adversarial taxonomy fixture validated as a test fixture."