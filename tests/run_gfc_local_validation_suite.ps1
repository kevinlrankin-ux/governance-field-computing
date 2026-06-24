# Governance Field Computing
# Combined Local Validation Suite
# Version 0.1

$suiteSteps = @(
    @{
        Name = "Evidence Posture Pipeline"
        Script = ".\tests\run_gfc_evidence_posture_pipeline.ps1"
    },
    @{
        Name = "Boundary Principles Pipeline"
        Script = ".\tests\run_gfc_boundary_pipeline.ps1"
    }
)

$results = @()

Write-Host ""
Write-Host "GFC Combined Local Validation Suite v0.1"
Write-Host "========================================"
Write-Host ""

foreach ($step in $suiteSteps)
{
    Write-Host "CHECKING:" $step.Name
    Write-Host "Script:" $step.Script

    if (-not (Test-Path $step.Script))
    {
        throw "Required local validation suite script missing: $($step.Script)"
    }

    Write-Host "RUNNING:" $step.Name
    Write-Host ""

    & $step.Script

    if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0)
    {
        throw "Local validation suite step returned non-zero exit code: $($step.Name) / $LASTEXITCODE"
    }

    $results += [PSCustomObject]@{
        step = $step.Name
        script = $step.Script
        result = "pass"
    }

    Write-Host ""
    Write-Host "STEP PASS:" $step.Name
    Write-Host ""
}

$requiredArtifacts = @(
    ".\docs\decisions\GFC-0019-Local-Evidence-Posture-Pipeline-Accepted.md",
    ".\docs\decisions\GFC-0023-Local-Boundary-Principles-Pipeline-Accepted.md",
    ".\docs\methodology\GFC Local Pipeline Map v0.1.md",
    ".\docs\decisions\GFC-0024-Local-Pipeline-Map-Accepted.md"
)

foreach ($artifact in $requiredArtifacts)
{
    if (-not (Test-Path $artifact))
    {
        throw "Required suite artifact missing after run: $artifact"
    }
}

Write-Host ""
Write-Host "PASS: GFC combined local validation suite completed successfully."
Write-Host "Suite Steps:" $suiteSteps.Count
Write-Host "Passed Steps:" ($results | Where-Object { $_.result -eq "pass" }).Count
Write-Host "Evidence Posture Pipeline: pass"
Write-Host "Boundary Principles Pipeline: pass"
Write-Host "Pipeline Map: docs\methodology\GFC Local Pipeline Map v0.1.md"
Write-Host ""
Write-Host "Combined Suite Chain:"
Write-Host "evidence posture pipeline -> boundary principles pipeline"
Write-Host ""
Write-Host "Boundary:"
Write-Host "local validation suite does not equal CI enforcement, runtime enforcement, external proof, or institutional authority"