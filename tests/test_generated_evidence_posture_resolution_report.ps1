# Governance Field Computing
# Generated Evidence Posture Resolution Report Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-posture-resolution-report.schema.json"
$reportPath = Join-Path $PSScriptRoot "..\artifacts\evidence-posture-resolution-report.generated.v0.1.json"

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

if ($report.report_id -ne "EVIDENCE-POSTURE-RESOLUTION-REPORT-v0.1")
{
    throw "Unexpected report_id: $($report.report_id)"
}

if ($report.status -ne "draft")
{
    throw "Expected generated report status to be draft."
}

if ($report.source_evidence_set_id -ne "EVSET-ORAL-HYGIENE-001")
{
    throw "Unexpected source_evidence_set_id: $($report.source_evidence_set_id)"
}

if ($report.source_posture_registry_id -ne "EVIDENCE-HANDLING-POSTURE-REGISTRY-v0.1")
{
    throw "Unexpected source_posture_registry_id: $($report.source_posture_registry_id)"
}

if ($report.overall_resolution -ne "mixed_posture")
{
    throw "Expected generated report overall_resolution to be mixed_posture."
}

if ($report.resolved_references.Count -ne 3)
{
    throw "Expected exactly 3 resolved references in generated report."
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

    if ($resolved.runtime_response.Count -lt 1)
    {
        throw "Resolved reference must include at least one runtime response: $($resolved.evidence_id)"
    }
}

$pending = $report.resolved_references | Where-Object { $_.evidence_status -eq "pending" } | Select-Object -First 1
$cited = $report.resolved_references | Where-Object { $_.evidence_status -eq "cited" } | Select-Object -First 1
$supported = $report.resolved_references | Where-Object { $_.evidence_status -eq "supported" } | Select-Object -First 1

if ($null -eq $pending)
{
    throw "Generated report missing pending resolved reference."
}

if ($null -eq $cited)
{
    throw "Generated report missing cited resolved reference."
}

if ($null -eq $supported)
{
    throw "Generated report missing supported resolved reference."
}

if ($pending.handling_posture -ne "signal_incomplete_evidence")
{
    throw "Pending generated reference has incorrect handling posture."
}

if ($cited.handling_posture -ne "allow_citation_reference_block_support_claim")
{
    throw "Cited generated reference has incorrect handling posture."
}

if ($supported.handling_posture -ne "allow_scoped_support_claim")
{
    throw "Supported generated reference has incorrect handling posture."
}

if ($pending.recommended_next_action -ne "cite_sources")
{
    throw "Pending generated reference must recommend cite_sources."
}

if ($cited.recommended_next_action -ne "review_support")
{
    throw "Cited generated reference must recommend review_support."
}

if ($supported.recommended_next_action -ne "continue")
{
    throw "Supported generated reference must recommend continue."
}

foreach ($expectedAction in @("cite_sources", "continue", "review_support"))
{
    if (-not ($report.aggregate_actions -contains $expectedAction))
    {
        throw "Generated report missing aggregate action: $expectedAction"
    }
}

foreach ($expectedRuntimeResponse in @("block_support_claim", "block_universalization", "preserve_audit_trail"))
{
    if (-not ($report.aggregate_runtime_responses -contains $expectedRuntimeResponse))
    {
        throw "Generated report missing aggregate runtime response: $expectedRuntimeResponse"
    }
}

if ($report.anti_inflation_note -notlike "*does not prove*")
{
    throw "Generated report anti-inflation note must prevent proof inflation."
}

if ($report.boundary_note -notlike "*Supported evidence does not erase pending or cited limitations*")
{
    throw "Generated report boundary note must preserve status plurality."
}

Write-Host ""
Write-Host "PASS: Generated evidence posture resolution report conforms to expected schema shape."
Write-Host "Report ID:" $report.report_id
Write-Host "Status:" $report.status
Write-Host "Evidence Set:" $report.source_evidence_set_id
Write-Host "Posture Registry:" $report.source_posture_registry_id
Write-Host "Resolved References:" $report.resolved_references.Count
Write-Host "Overall Resolution:" $report.overall_resolution
Write-Host "Aggregate Actions:" ($report.aggregate_actions -join ", ")
Write-Host "Aggregate Runtime Responses:" $report.aggregate_runtime_responses.Count