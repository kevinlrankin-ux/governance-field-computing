# Governance Field Computing
# Evidence Reference Set Oral Hygiene Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-reference-set.schema.json"
$setPath = Join-Path $PSScriptRoot "..\examples\evidence-reference-set.oral-hygiene.example.json"

foreach ($path in @($schemaPath, $setPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$set = Get-Content $setPath -Raw | ConvertFrom-Json

if ($schema.title -ne "Evidence Reference Set")
{
    throw "Unexpected schema title: $($schema.title)"
}

$requiredSetFields = @(
    "evidence_set_id",
    "evidence_set_type",
    "target_ref",
    "target_text",
    "evidence_status_summary",
    "evidence_references",
    "boundary_note"
)

foreach ($field in $requiredSetFields)
{
    if (-not $set.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required evidence set field: $field"
    }

    if ($null -eq $set.$field)
    {
        throw "Required evidence set field is null: $field"
    }
}

$allowedSetTypes = @(
    "claim",
    "layer_assignment",
    "rule_set",
    "semantic_validation_run",
    "review_report",
    "decision_record",
    "unknown"
)

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

$allowedRecommendedActions = @(
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

if (-not ($allowedSetTypes -contains $set.evidence_set_type))
{
    throw "Invalid evidence_set_type: $($set.evidence_set_type)"
}

if ($set.evidence_set_type -ne "layer_assignment")
{
    throw "Expected evidence_set_type to be layer_assignment."
}

if ($set.evidence_references.Count -lt 1)
{
    throw "Evidence reference set must contain at least one evidence reference."
}

if ($set.evidence_references.Count -ne 3)
{
    throw "Expected exactly 3 evidence references for the oral hygiene example."
}

if ($set.PSObject.Properties.Name.Contains("recommended_next_action"))
{
    if (-not ($allowedRecommendedActions -contains $set.recommended_next_action))
    {
        throw "Invalid recommended_next_action: $($set.recommended_next_action)"
    }
}

$requiredReferenceFields = @(
    "evidence_id",
    "evidence_status",
    "claim_ref",
    "claim_text",
    "evidence_summary",
    "evidence_source",
    "source_type",
    "evidence_scope",
    "evidence_family",
    "evidence_role",
    "supports_claim",
    "limits_claim",
    "boundary_note"
)

foreach ($reference in $set.evidence_references)
{
    foreach ($field in $requiredReferenceFields)
    {
        if (-not $reference.PSObject.Properties.Name.Contains($field))
        {
            throw "Missing required evidence reference field: $field"
        }

        if ([string]::IsNullOrWhiteSpace([string]$reference.$field))
        {
            throw "Required evidence reference field is empty: $field in $($reference.evidence_id)"
        }
    }

    if (-not ($allowedStatuses -contains $reference.evidence_status))
    {
        throw "Invalid evidence_status in set: $($reference.evidence_status)"
    }

    if ($reference.claim_ref -ne $set.target_ref)
    {
        throw "Evidence reference claim_ref does not match set target_ref for $($reference.evidence_id)"
    }
}

$statusCounts = @{}

foreach ($status in $allowedStatuses)
{
    $statusCounts[$status] = 0
}

foreach ($reference in $set.evidence_references)
{
    $statusCounts[$reference.evidence_status] = $statusCounts[$reference.evidence_status] + 1
}

foreach ($status in $allowedStatuses)
{
    $declaredCount = [int]$set.evidence_status_summary.$status
    $actualCount = [int]$statusCounts[$status]

    if ($declaredCount -ne $actualCount)
    {
        throw "Evidence status summary mismatch for $status. Declared $declaredCount but found $actualCount."
    }
}

$referenceIds = @($set.evidence_references | ForEach-Object { $_.evidence_id })

$duplicateIds = $referenceIds |
    Group-Object |
    Where-Object { $_.Count -gt 1 }

if ($duplicateIds.Count -gt 0)
{
    throw "Duplicate evidence IDs found: $($duplicateIds.Name -join ', ')"
}

$statusesPresent = @($set.evidence_references | ForEach-Object { $_.evidence_status })

foreach ($expectedStatus in @("pending", "cited", "supported"))
{
    if (-not ($statusesPresent -contains $expectedStatus))
    {
        throw "Expected evidence reference set to include status: $expectedStatus"
    }
}

$pendingReference = $set.evidence_references | Where-Object { $_.evidence_status -eq "pending" } | Select-Object -First 1
$citedReference = $set.evidence_references | Where-Object { $_.evidence_status -eq "cited" } | Select-Object -First 1
$supportedReference = $set.evidence_references | Where-Object { $_.evidence_status -eq "supported" } | Select-Object -First 1

if ($pendingReference.evidence_source -ne "not yet assigned")
{
    throw "Pending reference must preserve unassigned evidence source."
}

if ($citedReference.supports_claim -ne "not yet determined")
{
    throw "Cited reference must not claim support."
}

if ($citedReference.boundary_note -notlike "*does not mean the claim is supported*")
{
    throw "Cited reference must preserve cited-not-supported boundary."
}

if ($supportedReference.boundary_note -notlike "*scope-bound*")
{
    throw "Supported reference must preserve scope-bound boundary."
}

if ($supportedReference.limits_claim -notlike "*does not establish*")
{
    throw "Supported reference must prevent universalization."
}

if ($set.boundary_note -notlike "*strongest record does not erase*")
{
    throw "Set boundary note must preserve weaker-record visibility."
}

if ($set.boundary_note -notlike "*supported evidence remains scope-bound*")
{
    throw "Set boundary note must preserve supported-is-scope-bound rule."
}

Write-Host ""
Write-Host "PASS: Evidence reference set conforms to expected schema shape."
Write-Host "Evidence Set ID:" $set.evidence_set_id
Write-Host "Set Type:" $set.evidence_set_type
Write-Host "Target Ref:" $set.target_ref
Write-Host "References:" $set.evidence_references.Count
Write-Host "Pending:" $set.evidence_status_summary.pending
Write-Host "Cited:" $set.evidence_status_summary.cited
Write-Host "Supported:" $set.evidence_status_summary.supported
Write-Host "Recommended Next Action:" $set.recommended_next_action