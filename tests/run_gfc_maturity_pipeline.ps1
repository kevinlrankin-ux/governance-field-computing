# Governance Field Computing
# Validation Maturity Pipeline
# Version 0.1

Write-Host ""
Write-Host "GFC Validation Maturity Pipeline v0.1"
Write-Host "====================================="
Write-Host ""

$requiredArtifacts = @(
    @{
        Name = "Validation Maturity Ladder Methodology"
        Path = ".\docs\methodology\GFC Validation Maturity Ladder v0.1.md"
    },
    @{
        Name = "Validation Maturity Ladder Decision Record"
        Path = ".\docs\decisions\GFC-0026-Validation-Maturity-Ladder-Accepted.md"
    },
    @{
        Name = "Validation Maturity Level Schema"
        Path = ".\schemas\validation-maturity-level.schema.json"
    },
    @{
        Name = "Validation Maturity Levels Registry"
        Path = ".\examples\validation-maturity-levels.registry.v0.1.json"
    },
    @{
        Name = "Validation Maturity Levels Registry Validator"
        Path = ".\tests\test_validation_maturity_levels_registry.ps1"
    },
    @{
        Name = "Validation Maturity Level Registry Decision Record"
        Path = ".\docs\decisions\GFC-0027-Validation-Maturity-Level-Registry-Accepted.md"
    }
)

foreach ($artifact in $requiredArtifacts)
{
    Write-Host "CHECKING:" $artifact.Name
    Write-Host "Path:" $artifact.Path

    if (-not (Test-Path $artifact.Path))
    {
        throw "Required maturity pipeline artifact missing: $($artifact.Path)"
    }

    Write-Host "PRESENT:" $artifact.Name
    Write-Host ""
}

Write-Host "RUNNING: Validation Maturity Levels Registry Validator"
Write-Host "Script: .\tests\test_validation_maturity_levels_registry.ps1"
Write-Host ""

& ".\tests\test_validation_maturity_levels_registry.ps1"

if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0)
{
    throw "Validation maturity levels registry validator returned non-zero exit code: $LASTEXITCODE"
}

Write-Host ""
Write-Host "PASS: GFC validation maturity pipeline completed successfully."
Write-Host "Pipeline Artifacts Checked:" $requiredArtifacts.Count
Write-Host "Methodology: docs\methodology\GFC Validation Maturity Ladder v0.1.md"
Write-Host "Decision Record: docs\decisions\GFC-0026-Validation-Maturity-Ladder-Accepted.md"
Write-Host "Schema: schemas\validation-maturity-level.schema.json"
Write-Host "Registry: examples\validation-maturity-levels.registry.v0.1.json"
Write-Host "Registry Validator: tests\test_validation_maturity_levels_registry.ps1"
Write-Host "Registry Decision Record: docs\decisions\GFC-0027-Validation-Maturity-Level-Registry-Accepted.md"
Write-Host ""
Write-Host "Pipeline Chain:"
Write-Host "maturity methodology -> decision record -> schema -> registry -> registry validation"
Write-Host ""
Write-Host "Current GFC Maturity:"
Write-Host "Level 6 - Combined local suite"
Write-Host ""
Write-Host "Boundary:"
Write-Host "maturity pipeline does not equal CI enforcement, runtime enforcement, external proof, or domain-specific authority integration"