# Governance Field Computing
# Evidence Posture Resolution Report Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-posture-resolution-report.schema.json"
$reportPath = Join-Path $PSScriptRoot "..\artifacts\evidence-posture-resolution-report.v0.1.json"

foreach ($path in @($schemaPath, $reportPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$report = Get-Content $reportPath -Raw | ConvertFrom-Json

if ($schema.title -ne "Evidence Posture Resolution Report")
{
    throw "Unexpected schema title: $($schema.title)"
}

$requiredReportFields = @(
    "report_id",
    "version",
    "status",
    "source_evidence_set_id",
    "source_posture_registry_id",
    "target_ref",
    "target_text",
    "resolved_references",
    "aggregate_actions",
    "aggregate_runtime_responses",
    "overall_resolution",
    "overall_summary",
    "anti_inflation_note",
    "boundary_note"
)

foreach ($field in $requiredReportFields)
{
    if (-not $report.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required report field: $field"
    }

    if ($null -eq $report.$field)
    {
        throw "Required report field is null: $field"
    }
}

$allowedStatuses = @(
    "pending",
    "cited",
    "supported",
    "contested",
    "insufficient",
    "missing",
    "stale",
    "superseded"
)

$allowedPostures = @(
    "signal_incomplete_evidence",
    "allow_citation_reference_block_support_claim",
    "allow_scoped_support_claim",
    "require_conflict_review",
    "block_support_claim",
    "surface_gap_and_block_support_claim",
    "require_renewal_review",
    "retire_current_authority_preserve_audit"
)

$allowedActions = @(
    "continue",
    "cite_sources",
    "review_support",
    "resolve_conflict",
    "supply_missing_evidence",
    "renew_stale_evidence",
    "retire_superseded_evidence",
    "block_support_claim",
    "unknown"
)

$allowedRuntimeResponses = @(
    "allow_semantic_validation",
    "allow_citation_presence",
    "allow_scoped_support_claim",
    "block_support_claim",
    "block_universalization",
    "surface_warning",
    "surface_evidence_gap",
    "surface_conflict",
    "require_source_collection",
    "require_support_review",
    "require_claim_to_source_fit_review",
    "require_conflict_review",
    "require_renewal_review",
    "request_updated_evidence",
    "preserve_audit_trail",
    "retire_current_authority",
    "point_to_newer_controlling_evidence",
    "continue_with_limitation"
)

$allowedOverallResolutions = @(
    "clean_continue",
    "mixed_posture",
    "review_required",
    "blocked_support",
    "conflict_review_required",
    "renewal_required",
    "retired_authority",
    "unknown"
)

$allowedFrictionLevels = @(
    "none",
    "low",
    "medium",
    "high",
    "block"
)

if ($report.report_id -ne "EVIDENCE-POSTURE-RESOLUTION-REPORT-v0.1")
{
    throw "Unexpected report_id: $($report.report_id)"
}

if ($report.status -ne "draft")
{
    throw "Expected report status to be draft."
}

if ($report.source_evidence_set_id -ne "EVSET-ORAL-HYGIENE-001")
{
    throw "Unexpected source_evidence_set_id: $($report.source_evidence_set_id)"
}

if ($report.source_posture_registry_id -ne "EVIDENCE-HANDLING-POSTURE-REGISTRY-v0.1")
{
    throw "Unexpected source_posture_registry_id: $($report.source_posture_registry_id)"
}

if (-not ($allowedOverallResolutions -contains $report.overall_resolution))
{
    throw "Invalid overall_resolution: $($report.overall_resolution)"
}

if ($report.overall_resolution -ne "mixed_posture")
{
    throw "Expected overall_resolution to be mixed_posture."
}

if ($report.resolved_references.Count -ne 3)
{
    throw "Expected exactly 3 resolved references."
}

$requiredResolvedFields = @(
    "evidence_id",
    "evidence_status",
    "handling_posture",
    "recommended_next_action",
    "friction_level",
    "runtime_response",
    "resolution_summary",
    "boundary_note"
)

foreach ($resolved in $report.resolved_references)
{
    foreach ($field in $requiredResolvedFields)
    {
        if (-not $resolved.PSObject.Properties.Name.Contains($field))
        {
            throw "Missing required resolved reference field: $field"
        }

        if ($null -eq $resolved.$field)
        {
            throw "Required resolved reference field is null: $field"
        }
    }

    if (-not ($allowedStatuses -contains $resolved.evidence_status))
    {
        throw "Invalid resolved evidence_status: $($resolved.evidence_status)"
    }

    if (-not ($allowedPostures -contains $resolved.handling_posture))
    {
        throw "Invalid resolved handling_posture: $($resolved.handling_posture)"
    }

    if (-not ($allowedActions -contains $resolved.recommended_next_action))
    {
        throw "Invalid resolved recommended_next_action: $($resolved.recommended_next_action)"
    }

    if (-not ($allowedFrictionLevels -contains $resolved.friction_level))
    {
        throw "Invalid friction_level: $($resolved.friction_level)"
    }

    if ($resolved.runtime_response.Count -lt 1)
    {
        throw "Resolved reference must include at least one runtime response: $($resolved.evidence_id)"
    }

    foreach ($runtimeResponse in $resolved.runtime_response)
    {
        if (-not ($allowedRuntimeResponses -contains $runtimeResponse))
        {
            throw "Invalid runtime response: $runtimeResponse"
        }
    }
}

foreach ($action in $report.aggregate_actions)
{
    if (-not ($allowedActions -contains $action))
    {
        throw "Invalid aggregate action: $action"
    }
}

foreach ($runtimeResponse in $report.aggregate_runtime_responses)
{
    if (-not ($allowedRuntimeResponses -contains $runtimeResponse))
    {
        throw "Invalid aggregate runtime response: $runtimeResponse"
    }
}

$resolvedStatuses = @($report.resolved_references | ForEach-Object { $_.evidence_status })

foreach ($expectedStatus in @("pending", "cited", "supported"))
{
    if (-not ($resolvedStatuses -contains $expectedStatus))
    {
        throw "Expected resolved status missing: $expectedStatus"
    }
}

foreach ($expectedAction in @("cite_sources", "review_support", "continue"))
{
    if (-not ($report.aggregate_actions -contains $expectedAction))
    {
        throw "Expected aggregate action missing: $expectedAction"
    }
}

foreach ($expectedResponse in @("block_support_claim", "block_universalization", "preserve_audit_trail"))
{
    if (-not ($report.aggregate_runtime_responses -contains $expectedResponse))
    {
        throw "Expected aggregate runtime response missing: $expectedResponse"
    }
}

$pending = $report.resolved_references | Where-Object { $_.evidence_status -eq "pending" } | Select-Object -First 1
$cited = $report.resolved_references | Where-Object { $_.evidence_status -eq "cited" } | Select-Object -First 1
$supported = $report.resolved_references | Where-Object { $_.evidence_status -eq "supported" } | Select-Object -First 1

if ($pending.recommended_next_action -ne "cite_sources")
{
    throw "Pending resolved reference must recommend cite_sources."
}

if ($cited.recommended_next_action -ne "review_support")
{
    throw "Cited resolved reference must recommend review_support."
}

if ($supported.recommended_next_action -ne "continue")
{
    throw "Supported resolved reference must recommend continue."
}

if ($report.anti_inflation_note -notlike "*does not prove*")
{
    throw "Anti-inflation note must prevent proof inflation."
}

if ($report.boundary_note -notlike "*Supported evidence does not erase pending or cited limitations*")
{
    throw "Boundary note must preserve status plurality."
}

Write-Host ""
Write-Host "PASS: Evidence posture resolution report conforms to expected schema shape."
Write-Host "Report ID:" $report.report_id
Write-Host "Status:" $report.status
Write-Host "Evidence Set:" $report.source_evidence_set_id
Write-Host "Posture Registry:" $report.source_posture_registry_id
Write-Host "Resolved References:" $report.resolved_references.Count
Write-Host "Overall Resolution:" $report.overall_resolution
Write-Host "Aggregate Actions:" ($report.aggregate_actions -join ", ")
Write-Host "Aggregate Runtime Responses:" $report.aggregate_runtime_responses.Count