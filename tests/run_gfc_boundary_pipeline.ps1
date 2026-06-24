# Governance Field Computing
# Boundary Principles Pipeline Runner
# Version 0.1

$pipelineArtifacts = @(
    @{
        Name = "Boundary Principles Methodology"
        Path = ".\docs\methodology\GFC Evidence Boundary Principles v0.1.md"
    },
    @{
        Name = "Boundary Principles Decision Record"
        Path = ".\docs\decisions\GFC-0021-Evidence-Boundary-Principles-Accepted.md"
    },
    @{
        Name = "Boundary Principles Schema"
        Path = ".\schemas\evidence-boundary-principles.schema.json"
    },
    @{
        Name = "Boundary Principles Registry"
        Path = ".\examples\evidence-boundary-principles.registry.v0.1.json"
    },
    @{
        Name = "Boundary Principles Registry Validator"
        Path = ".\tests\test_evidence_boundary_principles_registry.ps1"
    }
)

$results = @()

Write-Host ""
Write-Host "GFC Boundary Principles Pipeline v0.1"
Write-Host "===================================="
Write-Host ""

foreach ($artifact in $pipelineArtifacts)
{
    Write-Host "CHECKING:" $artifact.Name
    Write-Host "Path:" $artifact.Path

    if (-not (Test-Path $artifact.Path))
    {
        throw "Required boundary pipeline artifact missing: $($artifact.Path)"
    }

    $results += [PSCustomObject]@{
        step = $artifact.Name
        path = $artifact.Path
        result = "present"
    }

    Write-Host "PRESENT:" $artifact.Name
    Write-Host ""
}

Write-Host "RUNNING: Boundary Principles Registry Validator"
Write-Host "Script: .\tests\test_evidence_boundary_principles_registry.ps1"

.\tests\test_evidence_boundary_principles_registry.ps1

if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0)
{
    throw "Boundary principles registry validator returned non-zero exit code: $LASTEXITCODE"
}

$registryPath = ".\examples\evidence-boundary-principles.registry.v0.1.json"
$registry = Get-Content $registryPath -Raw | ConvertFrom-Json

if ($registry.principles.Count -ne 15)
{
    throw "Boundary pipeline expected 15 principles."
}

if ($registry.anti_inflation_note -notlike "*inflated into proof*")
{
    throw "Boundary pipeline requires anti-inflation note."
}

if ($registry.vendor_boundary_note -notlike "*vendor scan does not equal adoption*")
{
    throw "Boundary pipeline requires vendor no-import boundary."
}

Write-Host ""
Write-Host "PASS: GFC boundary principles pipeline completed successfully."
Write-Host "Pipeline Artifacts Checked:" $results.Count
Write-Host "Boundary Principles Validated:" $registry.principles.Count
Write-Host "Methodology: docs\methodology\GFC Evidence Boundary Principles v0.1.md"
Write-Host "Decision Record: docs\decisions\GFC-0021-Evidence-Boundary-Principles-Accepted.md"
Write-Host "Schema: schemas\evidence-boundary-principles.schema.json"
Write-Host "Registry: examples\evidence-boundary-principles.registry.v0.1.json"
Write-Host "Validator: tests\test_evidence_boundary_principles_registry.ps1"
Write-Host ""
Write-Host "Pipeline Chain:"
Write-Host "boundary methodology -> decision record -> schema -> registry -> registry validation"