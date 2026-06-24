# Governance Field Computing
# Compare Manual and Generated Evidence Posture Resolution Reports
# Version 0.1

$manualPath = Join-Path $PSScriptRoot "..\artifacts\evidence-posture-resolution-report.v0.1.json"
$generatedPath = Join-Path $PSScriptRoot "..\artifacts\evidence-posture-resolution-report.generated.v0.1.json"

foreach ($path in @($manualPath, $generatedPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$manual = Get-Content $manualPath -Raw | ConvertFrom-Json
$generated = Get-Content $generatedPath -Raw | ConvertFrom-Json

$coreFields = @(
    "report_id",
    "version",
    "status",
    "source_evidence_set_id",
    "source_posture_registry_id",
    "target_ref",
    "target_text",
    "overall_resolution"
)

foreach ($field in $coreFields)
{
    if ($manual.$field -ne $generated.$field)
    {
        throw "Core field mismatch for ${field}. Manual='$($manual.$field)' Generated='$($generated.$field)'"
    }
}

if ($manual.resolved_references.Count -ne $generated.resolved_references.Count)
{
    throw "Resolved reference count mismatch."
}

$manualByEvidenceId = @{}
$generatedByEvidenceId = @{}

foreach ($item in $manual.resolved_references)
{
    $manualByEvidenceId[$item.evidence_id] = $item
}

foreach ($item in $generated.resolved_references)
{
    $generatedByEvidenceId[$item.evidence_id] = $item
}

foreach ($evidenceId in $manualByEvidenceId.Keys)
{
    if (-not $generatedByEvidenceId.ContainsKey($evidenceId))
    {
        throw "Generated report missing evidence_id: $evidenceId"
    }

    $manualItem = $manualByEvidenceId[$evidenceId]
    $generatedItem = $generatedByEvidenceId[$evidenceId]

    $resolvedFields = @(
        "evidence_status",
        "handling_posture",
        "recommended_next_action",
        "friction_level",
        "resolution_summary",
        "boundary_note"
    )

    foreach ($field in $resolvedFields)
    {
        if ($manualItem.$field -ne $generatedItem.$field)
        {
            throw "Resolved field mismatch for ${evidenceId}.${field}. Manual='$($manualItem.$field)' Generated='$($generatedItem.$field)'"
        }
    }

    $manualRuntime = @($manualItem.runtime_response | Sort-Object)
    $generatedRuntime = @($generatedItem.runtime_response | Sort-Object)

    if (($manualRuntime -join "|") -ne ($generatedRuntime -join "|"))
    {
        throw "Runtime response mismatch for evidence_id: $evidenceId"
    }
}

$manualActions = @($manual.aggregate_actions | Sort-Object)
$generatedActions = @($generated.aggregate_actions | Sort-Object)

if (($manualActions -join "|") -ne ($generatedActions -join "|"))
{
    throw "Aggregate action mismatch."
}

$manualRuntimeResponses = @($manual.aggregate_runtime_responses | Sort-Object)
$generatedRuntimeResponses = @($generated.aggregate_runtime_responses | Sort-Object)

if (($manualRuntimeResponses -join "|") -ne ($generatedRuntimeResponses -join "|"))
{
    throw "Aggregate runtime response mismatch."
}

if ($generated.anti_inflation_note -notlike "*does not prove*")
{
    throw "Generated report anti-inflation note must prevent proof inflation."
}

if ($generated.boundary_note -notlike "*Supported evidence does not erase pending or cited limitations*")
{
    throw "Generated report boundary note must preserve status plurality."
}

Write-Host ""
Write-Host "PASS: Manual and generated evidence posture reports preserve core semantic equivalence."
Write-Host "Manual Report:" $manualPath
Write-Host "Generated Report:" $generatedPath
Write-Host "Report ID:" $generated.report_id
Write-Host "Evidence Set:" $generated.source_evidence_set_id
Write-Host "Posture Registry:" $generated.source_posture_registry_id
Write-Host "Resolved References Compared:" $generated.resolved_references.Count
Write-Host "Aggregate Actions:" ($generated.aggregate_actions -join ", ")
Write-Host "Aggregate Runtime Responses:" $generated.aggregate_runtime_responses.Count
Write-Host "Overall Resolution:" $generated.overall_resolution