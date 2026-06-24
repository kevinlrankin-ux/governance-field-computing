# Governance Field Computing
# Emit Evidence Posture Resolution Report
# Version 0.1

$setPath = Join-Path $PSScriptRoot "..\examples\evidence-reference-set.oral-hygiene.example.json"
$posturePath = Join-Path $PSScriptRoot "..\examples\evidence-handling-posture.registry.v0.1.json"
$outputPath = Join-Path $PSScriptRoot "..\artifacts\evidence-posture-resolution-report.generated.v0.1.json"

foreach ($path in @($setPath, $posturePath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$set = Get-Content $setPath -Raw | ConvertFrom-Json
$registry = Get-Content $posturePath -Raw | ConvertFrom-Json

$postureByStatus = @{}

foreach ($posture in $registry.postures)
{
    if ($postureByStatus.ContainsKey($posture.evidence_status))
    {
        throw "Duplicate posture found for evidence status: $($posture.evidence_status)"
    }

    $postureByStatus[$posture.evidence_status] = $posture
}

$resolvedReferences = @()

foreach ($reference in $set.evidence_references)
{
    $status = $reference.evidence_status

    if (-not $postureByStatus.ContainsKey($status))
    {
        throw "No handling posture found for evidence status: $status"
    }

    $posture = $postureByStatus[$status]

    $resolutionSummary = ""

    if ($status -eq "pending")
    {
        $resolutionSummary = "Pending evidence may allow semantic validation to stand, but blocks support claims and requires source collection."
    }
    elseif ($status -eq "cited")
    {
        $resolutionSummary = "Cited evidence records citation presence, but does not yet establish support."
    }
    elseif ($status -eq "supported")
    {
        $resolutionSummary = "Supported evidence allows a scoped support claim under the declared domain, phrase, rule set, and review scope."
    }
    elseif ($status -eq "contested")
    {
        $resolutionSummary = "Contested evidence requires conflict review before a clean support claim can be made."
    }
    elseif ($status -eq "insufficient")
    {
        $resolutionSummary = "Insufficient evidence exists but cannot support the claim as stated."
    }
    elseif ($status -eq "missing")
    {
        $resolutionSummary = "Missing evidence creates an evidence gap and blocks support claims."
    }
    elseif ($status -eq "stale")
    {
        $resolutionSummary = "Stale evidence requires renewal review before it can govern a current support claim."
    }
    elseif ($status -eq "superseded")
    {
        $resolutionSummary = "Superseded evidence must be retired from current authority while preserving audit history."
    }
    else
    {
        $resolutionSummary = "Evidence status resolved to a handling posture."
    }

    $resolvedReferences += [PSCustomObject]@{
        evidence_id = $reference.evidence_id
        evidence_status = $status
        handling_posture = $posture.handling_posture
        recommended_next_action = $posture.recommended_next_action
        friction_level = $posture.friction_level
        runtime_response = @($posture.runtime_response)
        resolution_summary = $resolutionSummary
        boundary_note = $posture.boundary_note
    }
}

$aggregateActions = @(
    $resolvedReferences |
        ForEach-Object { $_.recommended_next_action } |
        Sort-Object -Unique
)

$aggregateRuntimeResponses = @(
    $resolvedReferences |
        ForEach-Object { $_.runtime_response } |
        Sort-Object -Unique
)

$overallResolution = "mixed_posture"

$uniqueActions = @($aggregateActions)

if ($uniqueActions.Count -eq 1 -and $uniqueActions[0] -eq "continue")
{
    $overallResolution = "clean_continue"
}
elseif ($uniqueActions -contains "resolve_conflict")
{
    $overallResolution = "conflict_review_required"
}
elseif ($uniqueActions -contains "renew_stale_evidence")
{
    $overallResolution = "renewal_required"
}
elseif ($uniqueActions -contains "retire_superseded_evidence")
{
    $overallResolution = "retired_authority"
}
elseif ($uniqueActions -contains "review_support")
{
    $overallResolution = "mixed_posture"
}
elseif ($uniqueActions -contains "supply_missing_evidence")
{
    $overallResolution = "blocked_support"
}

$report = [PSCustomObject]@{
    report_id = "EVIDENCE-POSTURE-RESOLUTION-REPORT-v0.1"
    version = "0.1"
    status = "draft"
    source_evidence_set_id = $set.evidence_set_id
    source_posture_registry_id = $registry.posture_registry_id
    target_ref = $set.target_ref
    target_text = $set.target_text
    resolved_references = @($resolvedReferences)
    aggregate_actions = @($aggregateActions)
    aggregate_runtime_responses = @($aggregateRuntimeResponses)
    overall_resolution = $overallResolution
    overall_summary = "The evidence bundle resolves to multiple handling postures. Pending evidence requires source collection, cited evidence requires support review, and supported evidence allows only scoped continuation."
    anti_inflation_note = "This report does not prove the oral hygiene claim externally. It records how the evidence bundle resolves into bounded handling postures."
    boundary_note = "The report preserves status plurality. Supported evidence does not erase pending or cited limitations."
}

$outputDirectory = Split-Path $outputPath -Parent

if (-not (Test-Path $outputDirectory))
{
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

$report |
    ConvertTo-Json -Depth 20 |
    Set-Content $outputPath -Encoding UTF8

Write-Host ""
Write-Host "PASS: Evidence posture resolution report generated."
Write-Host "Output:" $outputPath
Write-Host "Report ID:" $report.report_id
Write-Host "Evidence Set:" $report.source_evidence_set_id
Write-Host "Posture Registry:" $report.source_posture_registry_id
Write-Host "Resolved References:" $report.resolved_references.Count
Write-Host "Overall Resolution:" $report.overall_resolution
Write-Host "Aggregate Actions:" ($report.aggregate_actions -join ", ")
Write-Host "Aggregate Runtime Responses:" $report.aggregate_runtime_responses.Count