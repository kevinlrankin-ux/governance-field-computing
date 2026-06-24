# Governance Field Computing
# Evidence Posture Pipeline Runner
# Version 0.1

$pipelineSteps = @(
    @{
        Name = "Evidence Reference Set Validator"
        Path = ".\tests\test_evidence_reference_set_oral_hygiene.ps1"
    },
    @{
        Name = "Evidence Handling Posture Registry Validator"
        Path = ".\tests\test_evidence_handling_posture_registry.ps1"
    },
    @{
        Name = "Evidence Reference Set With Posture Lookup"
        Path = ".\tests\test_evidence_reference_set_with_posture.ps1"
    },
    @{
        Name = "Emit Evidence Posture Resolution Report"
        Path = ".\tests\emit_evidence_posture_resolution_report.ps1"
    },
    @{
        Name = "Generated Evidence Posture Resolution Report Validator"
        Path = ".\tests\test_generated_evidence_posture_resolution_report.ps1"
    },
    @{
        Name = "Manual Generated Evidence Report Equivalence Comparator"
        Path = ".\tests\compare_manual_and_generated_evidence_posture_reports.ps1"
    }
)

$results = @()

Write-Host ""
Write-Host "GFC Evidence Posture Pipeline v0.1"
Write-Host "================================="
Write-Host ""

foreach ($step in $pipelineSteps)
{
    $stepName = $step.Name
    $stepPath = $step.Path

    Write-Host "RUNNING:" $stepName
    Write-Host "Script:" $stepPath

    if (-not (Test-Path $stepPath))
    {
        throw "Pipeline step missing: $stepPath"
    }

    try
    {
        & $stepPath

        if ($LASTEXITCODE -ne $null -and $LASTEXITCODE -ne 0)
        {
            throw "Script returned non-zero exit code: $LASTEXITCODE"
        }

        $results += [PSCustomObject]@{
            step = $stepName
            script = $stepPath
            result = "pass"
        }

        Write-Host "STEP PASS:" $stepName
        Write-Host ""
    }
    catch
    {
        $results += [PSCustomObject]@{
            step = $stepName
            script = $stepPath
            result = "fail"
            error = $_.Exception.Message
        }

        Write-Host "STEP FAIL:" $stepName
        Write-Host "Error:" $_.Exception.Message
        throw
    }
}

$failedSteps = @($results | Where-Object { $_.result -ne "pass" })

if ($failedSteps.Count -gt 0)
{
    throw "Evidence posture pipeline failed."
}

$requiredArtifacts = @(
    ".\examples\evidence-reference-set.oral-hygiene.example.json",
    ".\examples\evidence-handling-posture.registry.v0.1.json",
    ".\artifacts\evidence-posture-resolution-report.generated.v0.1.json",
    ".\schemas\evidence-posture-resolution-report.schema.json"
)

foreach ($artifact in $requiredArtifacts)
{
    if (-not (Test-Path $artifact))
    {
        throw "Required pipeline artifact missing after run: $artifact"
    }
}

Write-Host ""
Write-Host "PASS: GFC evidence posture pipeline completed successfully."
Write-Host "Pipeline Steps:" $results.Count
Write-Host "Passed Steps:" (@($results | Where-Object { $_.result -eq "pass" }).Count)
Write-Host "Evidence Reference Set: examples\evidence-reference-set.oral-hygiene.example.json"
Write-Host "Posture Registry: examples\evidence-handling-posture.registry.v0.1.json"
Write-Host "Generated Report: artifacts\evidence-posture-resolution-report.generated.v0.1.json"
Write-Host "Report Schema: schemas\evidence-posture-resolution-report.schema.json"
Write-Host ""
Write-Host "Pipeline Chain:"
Write-Host "evidence reference set -> posture registry -> posture lookup -> generated report -> schema validation -> equivalence check"