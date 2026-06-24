# Governance Field Computing
# CI Readiness Pipeline
# Version 0.1

Write-Host ""
Write-Host "GFC CI Readiness Pipeline v0.1"
Write-Host "================================"
Write-Host ""

$requiredArtifacts = @(
    @{
        Name = "CI Enforcement Readiness Methodology"
        Path = ".\docs\methodology\GFC CI Enforcement Readiness v0.1.md"
    },
    @{
        Name = "CI Enforcement Readiness Decision Record"
        Path = ".\docs\decisions\GFC-0030-CI-Enforcement-Readiness-Accepted.md"
    },
    @{
        Name = "CI Workflow Candidate"
        Path = ".\.github\workflows\gfc-local-validation.yml"
    },
    @{
        Name = "CI Workflow Candidate Creation Decision Record"
        Path = ".\docs\decisions\GFC-0031-CI-Workflow-Candidate-Created.md"
    },
    @{
        Name = "CI Workflow Candidate Shape Validator"
        Path = ".\tests\test_ci_workflow_candidate_shape.ps1"
    },
    @{
        Name = "CI Workflow Candidate Shape Validation Decision Record"
        Path = ".\docs\decisions\GFC-0032-CI-Workflow-Candidate-Shape-Validated.md"
    }
)

foreach ($artifact in $requiredArtifacts)
{
    Write-Host "CHECKING:" $artifact.Name
    Write-Host "Path:" $artifact.Path

    if (-not (Test-Path $artifact.Path))
    {
        throw "Required CI readiness artifact missing: $($artifact.Path)"
    }

    Write-Host "PRESENT:" $artifact.Name
    Write-Host ""
}

Write-Host "RUNNING: CI Workflow Candidate Shape Validator"
Write-Host "Script: .\tests\test_ci_workflow_candidate_shape.ps1"
Write-Host ""

& ".\tests\test_ci_workflow_candidate_shape.ps1"

if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0)
{
    throw "CI workflow candidate shape validator returned non-zero exit code: $LASTEXITCODE"
}

Write-Host ""
Write-Host "PASS: GFC CI readiness pipeline completed successfully."
Write-Host "Pipeline Artifacts Checked:" $requiredArtifacts.Count
Write-Host "Methodology: docs\methodology\GFC CI Enforcement Readiness v0.1.md"
Write-Host "Readiness Decision: docs\decisions\GFC-0030-CI-Enforcement-Readiness-Accepted.md"
Write-Host "Workflow Candidate: .github\workflows\gfc-local-validation.yml"
Write-Host "Workflow Candidate Decision: docs\decisions\GFC-0031-CI-Workflow-Candidate-Created.md"
Write-Host "Shape Validator: tests\test_ci_workflow_candidate_shape.ps1"
Write-Host "Shape Validation Decision: docs\decisions\GFC-0032-CI-Workflow-Candidate-Shape-Validated.md"
Write-Host ""
Write-Host "Pipeline Chain:"
Write-Host "CI readiness methodology -> readiness decision -> workflow candidate -> candidate decision -> shape validation -> shape validation decision"
Write-Host ""
Write-Host "Current CI Status:"
Write-Host "readiness locally validated"
Write-Host ""
Write-Host "Boundary:"
Write-Host "CI readiness pipeline does not equal CI enforcement, CI workflow passage, runtime enforcement, external proof, or domain-specific authority integration"