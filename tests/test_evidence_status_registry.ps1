# Governance Field Computing
# Evidence Status Registry Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-status.schema.json"
$registryPath = Join-Path $PSScriptRoot "..\schemas\evidence-status-registry.v0.1.json"

foreach ($path in @($schemaPath, $registryPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$registry = Get-Content $registryPath -Raw | ConvertFrom-Json

if ($schema.title -ne "Evidence Status")
{
    throw "Unexpected schema title: $($schema.title)"
}

if ($null -eq $registry)
{
    throw "Evidence status registry did not parse."
}

if ($registry.Count -lt 1)
{
    throw "Evidence status registry is empty."
}

$requiredFields = @(
    "evidence_status",
    "definition",
    "use_when",
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

foreach ($entry in $registry)
{
    foreach ($field in $requiredFields)
    {
        if (-not $entry.PSObject.Properties.Name.Contains($field))
        {
            throw "Missing required field for evidence status entry: $field"
        }
    }

    if (-not ($allowedStatuses -contains $entry.evidence_status))
    {
        throw "Invalid evidence_status: $($entry.evidence_status)"
    }

    if ([string]::IsNullOrWhiteSpace($entry.definition))
    {
        throw "Empty definition for evidence_status: $($entry.evidence_status)"
    }

    if ($null -eq $entry.use_when)
    {
        throw "Missing use_when list for evidence_status: $($entry.evidence_status)"
    }

    if ($entry.use_when.Count -lt 1)
    {
        throw "use_when must contain at least one item for evidence_status: $($entry.evidence_status)"
    }

    if ([string]::IsNullOrWhiteSpace($entry.boundary_note))
    {
        throw "Empty boundary_note for evidence_status: $($entry.evidence_status)"
    }

    if ($entry.PSObject.Properties.Name.Contains("evidence_family"))
    {
        if (-not ($allowedFamilies -contains $entry.evidence_family))
        {
            throw "Invalid evidence_family for $($entry.evidence_status): $($entry.evidence_family)"
        }
    }

    if ($entry.PSObject.Properties.Name.Contains("evidence_role"))
    {
        if (-not ($allowedRoles -contains $entry.evidence_role))
        {
            throw "Invalid evidence_role for $($entry.evidence_status): $($entry.evidence_role)"
        }
    }
}

$registryStatuses = @($registry | ForEach-Object { $_.evidence_status })

foreach ($status in $allowedStatuses)
{
    if (-not ($registryStatuses -contains $status))
    {
        throw "Registry is missing required evidence status: $status"
    }
}

$duplicateStatuses = $registryStatuses |
    Group-Object |
    Where-Object { $_.Count -gt 1 }

if ($duplicateStatuses.Count -gt 0)
{
    throw "Duplicate evidence statuses found: $($duplicateStatuses.Name -join ', ')"
}

Write-Host ""
Write-Host "PASS: Evidence status registry conforms to expected schema shape."
Write-Host "Schema:" $schemaPath
Write-Host "Registry:" $registryPath
Write-Host "Statuses validated:" $registry.Count
Write-Host "Statuses:" ($registryStatuses -join ", ")