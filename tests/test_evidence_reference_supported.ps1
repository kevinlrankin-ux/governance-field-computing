# Governance Field Computing
# Supported Evidence Reference Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-reference.schema.json"
$examplePath = Join-Path $PSScriptRoot "..\examples\evidence-reference.supported.example.json"

foreach ($path in @($schemaPath, $examplePath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$example = Get-Content $examplePath -Raw | ConvertFrom-Json

if ($schema.title -ne "Evidence Reference")
{
    throw "Unexpected schema title: $($schema.title)"
}

$requiredFields = @(
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

$allowedSourceTypes = @(
    "not_assigned",
    "scientific_source",
    "medical_source",
    "legal_source",
    "public_health_source",
    "policy_source",
    "institutional_source",
    "technical_source",
    "human_report",
    "model_output",
    "internal_artifact",
    "unknown"
)

$allowedFamilies = @(
    "observational",
    "historical",
    "comparative",
    "model_derived",
    "human_reported",
    "policy_or_rule",
    "provenance",
    "negative_or_missing",
    "structural",
    "not_assigned"
)

$allowedRoles = @(
    "support",
    "limitation",
    "conflict",
    "renewal",
    "boundary",
    "stewardship",
    "audit",
    "not_assigned"
)

foreach ($field in $requiredFields)
{
    if (-not $example.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required field: $field"
    }

    if ([string]::IsNullOrWhiteSpace([string]$example.$field))
    {
        throw "Required field is empty: $field"
    }
}

if (-not ($allowedStatuses -contains $example.evidence_status))
{
    throw "Invalid evidence_status: $($example.evidence_status)"
}

if (-not ($allowedSourceTypes -contains $example.source_type))
{
    throw "Invalid source_type: $($example.source_type)"
}

if (-not ($allowedFamilies -contains $example.evidence_family))
{
    throw "Invalid evidence_family: $($example.evidence_family)"
}

if (-not ($allowedRoles -contains $example.evidence_role))
{
    throw "Invalid evidence_role: $($example.evidence_role)"
}

if ($example.evidence_status -ne "supported")
{
    throw "Expected supported evidence reference."
}

if ($example.evidence_source -eq "not yet assigned")
{
    throw "Supported evidence must identify an attached and reviewed source or reviewed source placeholder."
}

if ($example.supports_claim -like "*universally*" -or $example.supports_claim -like "*universal truth*")
{
    throw "Supported evidence must not claim universal support."
}

if ($example.evidence_scope -notlike "*only*")
{
    throw "Evidence scope must explicitly preserve limitation."
}

if ($example.limits_claim -notlike "*does not establish*")
{
    throw "limits_claim must explicitly prevent universalization."
}

if ($example.boundary_note -notlike "*scope-bound*")
{
    throw "Boundary note must preserve scope-bound support."
}

if ($example.boundary_note -like "*universal truth*" -and $example.boundary_note -notlike "*does not mean universal truth*")
{
    throw "Boundary note must reject, not imply, universal truth."
}

if ($example.evidence_status -eq "supported" -and $example.freshness_note -like "*not yet independently reviewed*")
{
    Write-Host "NOTICE: Supported example uses placeholder support; freshness remains not independently reviewed."
}

Write-Host ""
Write-Host "PASS: Supported evidence reference conforms to expected schema shape."
Write-Host "Evidence ID:" $example.evidence_id
Write-Host "Evidence Status:" $example.evidence_status
Write-Host "Claim Ref:" $example.claim_ref
Write-Host "Scope:" $example.evidence_scope
Write-Host "Boundary:" $example.boundary_note