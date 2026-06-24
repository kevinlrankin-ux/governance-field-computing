# Governance Field Computing
# All Local Pipelines Runner
# Version 0.2

Write-Host ""
Write-Host "GFC All Local Pipelines Runner v0.2"
Write-Host "==================================="
Write-Host ""

$pipelineSteps = @(
    @{
        Name = "Combined Local Validation Suite"
        Script = ".\tests\run_gfc_local_validation_suite.ps1"
    },
    @{
        Name = "Validation Maturity Pipeline"
        Script = ".\tests\run_gfc_maturity_pipeline.ps1"
    },
    @{
        Name = "CI Readiness Pipeline"
        Script = ".\tests\run_gfc_ci_readiness_pipeline.ps1"
    }
)

$results = @()

foreach ($step in $pipelineSteps)
{
    Write-Host "CHECKING:" $step.Name
    Write-Host "Script:" $step.Script

    if (-not (Test-Path $step.Script))
    {
        throw "Required top-level local pipeline missing: $($step.Script)"
    }

    Write-Host "RUNNING:" $step.Name
    Write-Host ""

    & $step.Script

    if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0)
    {
        throw "Top-level local pipeline returned non-zero exit code: $($step.Name) / $LASTEXITCODE"
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
    ".\docs\decisions\GFC-0025-Combined-Local-Validation-Suite-Accepted.md",
    ".\docs\decisions\GFC-0028-Validation-Maturity-Pipeline-Accepted.md",
    ".\docs\decisions\GFC-0033-CI-Readiness-Pipeline-Accepted.md"
)

foreach ($artifact in $requiredArtifacts)
{
    if (-not (Test-Path $artifact))
    {
        throw "Required umbrella pipeline artifact missing after run: $artifact"
    }
}

Write-Host ""
Write-Host "PASS: GFC all local pipelines completed successfully."
Write-Host "Top-Level Pipelines:" $pipelineSteps.Count
Write-Host "Passed Pipelines:" ($results | Where-Object { $_.result -eq "pass" }).Count
Write-Host "Combined Local Validation Suite: pass"
Write-Host "Validation Maturity Pipeline: pass"
Write-Host "CI Readiness Pipeline: pass"
Write-Host ""
Write-Host "Umbrella Chain:"
Write-Host "combined local validation suite -> validation maturity pipeline -> CI readiness pipeline"
Write-Host ""
Write-Host "Current Top-Level Local Command:"
Write-Host "tests\run_gfc_all_local_pipelines.ps1"
Write-Host ""
Write-Host "Current CI Status:"
Write-Host "readiness locally validated"
Write-Host ""
Write-Host "Boundary:"
Write-Host "all local pipelines does not equal CI enforcement, CI workflow passage, runtime enforcement, external proof, or domain-specific authority integration"