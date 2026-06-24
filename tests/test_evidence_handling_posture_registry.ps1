# Governance Field Computing
# Evidence Handling Posture Registry Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-handling-posture.schema.json"
$registryPath = Join-Path $PSScriptRoot "..\examples\evidence-handling-posture.registry.v0.1.json"

foreach ($path in @($schemaPath, $registryPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$registry = Get-Content $registryPath -Raw | ConvertFrom-Json

if ($schema.title -ne "Evidence Handling Posture")
{
    throw "Unexpected schema title: $($schema.title)"
}

$requiredRegistryFields = @(
    "posture_registry_id",
    "version",
    "status",
    "postures",
    "boundary_note"
)

foreach ($field in $requiredRegistryFields)
{
    if (-not $registry.PSObject.Properties.Name.Contains($field))
    {
        throw "Missing required registry field: $field"
    }

    if ($null -eq $registry.$field)
    {
        throw "Required registry field is null: $field"
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

$allowedHandlingPostures = @(
    "signal_incomplete_evidence",
    "allow_citation_reference_block_support_claim",
    "allow_scoped_support_claim",
    "require_conflict_review",
    "block_support_claim",
    "surface_gap_and_block_support_claim",
    "require_renewal_review",
    "retire_current_authority_preserve_audit"
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

$requiredPostureFields = @(
    "evidence_status",
    "handling_posture",
    "runtime_response",
    "allowed_claim_behavior",
    "blocked_claim_behavior",
    "recommended_next_action",
    "boundary_note"
)

if ($registry.status -ne "draft")
{
    throw "Expected registry status to be draft."
}

if ($registry.postures.Count -ne 8)
{
    throw "Expected exactly 8 evidence handling postures."
}

foreach ($posture in $registry.postures)
{
    foreach ($field in $requiredPostureFields)
    {
        if (-not $posture.PSObject.Properties.Name.Contains($field))
        {
            throw "Missing required posture field: $field"
        }

        if ($null -eq $posture.$field)
        {
            throw "Required posture field is null: $field"
        }
    }

    if (-not ($allowedStatuses -contains $posture.evidence_status))
    {
        throw "Invalid evidence_status: $($posture.evidence_status)"
    }

    if (-not ($allowedHandlingPostures -contains $posture.handling_posture))
    {
        throw "Invalid handling_posture: $($posture.handling_posture)"
    }

    if (-not ($allowedRecommendedActions -contains $posture.recommended_next_action))
    {
        throw "Invalid recommended_next_action: $($posture.recommended_next_action)"
    }

    if ($posture.runtime_response.Count -lt 1)
    {
        throw "runtime_response must contain at least one response for $($posture.evidence_status)"
    }

    if ($posture.allowed_claim_behavior.Count -lt 1)
    {
        throw "allowed_claim_behavior must contain at least one example for $($posture.evidence_status)"
    }

    if ($posture.blocked_claim_behavior.Count -lt 1)
    {
        throw "blocked_claim_behavior must contain at least one example for $($posture.evidence_status)"
    }
}

$postureStatuses = @($registry.postures | ForEach-Object { $_.evidence_status })

foreach ($status in $allowedStatuses)
{
    if (-not ($postureStatuses -contains $status))
    {
        throw "Registry missing posture for evidence status: $status"
    }
}

$duplicateStatuses = $postureStatuses |
    Group-Object |
    Where-Object { $_.Count -gt 1 }

if ($duplicateStatuses.Count -gt 0)
{
    throw "Duplicate evidence status postures found: $($duplicateStatuses.Name -join ', ')"
}

$pending = $registry.postures | Where-Object { $_.evidence_status -eq "pending" } | Select-Object -First 1
$cited = $registry.postures | Where-Object { $_.evidence_status -eq "cited" } | Select-Object -First 1
$supported = $registry.postures | Where-Object { $_.evidence_status -eq "supported" } | Select-Object -First 1
$contested = $registry.postures | Where-Object { $_.evidence_status -eq "contested" } | Select-Object -First 1
$stale = $registry.postures | Where-Object { $_.evidence_status -eq "stale" } | Select-Object -First 1
$superseded = $registry.postures | Where-Object { $_.evidence_status -eq "superseded" } | Select-Object -First 1

if (-not ($pending.runtime_response -contains "block_support_claim"))
{
    throw "Pending posture must block support claim."
}

if (-not ($cited.runtime_response -contains "block_support_claim"))
{
    throw "Cited posture must block support claim."
}

if (-not ($supported.runtime_response -contains "block_universalization"))
{
    throw "Supported posture must block universalization."
}

if (-not ($contested.runtime_response -contains "require_conflict_review"))
{
    throw "Contested posture must require conflict review."
}

if (-not ($stale.runtime_response -contains "require_renewal_review"))
{
    throw "Stale posture must require renewal review."
}

if (-not ($superseded.runtime_response -contains "retire_current_authority"))
{
    throw "Superseded posture must retire current authority."
}

$requiredAntiCollapseRules = @(
    "pending does not equal failed",
    "cited does not equal supported",
    "supported does not equal universal",
    "contested does not equal rejected",
    "insufficient does not equal useless",
    "missing does not equal disproven",
    "stale does not equal deleted",
    "superseded does not equal erased"
)

foreach ($rule in $requiredAntiCollapseRules)
{
    if (-not ($registry.anti_collapse_rules -contains $rule))
    {
        throw "Missing anti-collapse rule: $rule"
    }
}

if ($registry.boundary_note -notlike "*without collapsing uncertainty into binary pass or fail*")
{
    throw "Registry boundary note must preserve anti-collapse rule."
}

Write-Host ""
Write-Host "PASS: Evidence handling posture registry conforms to expected schema shape."
Write-Host "Registry ID:" $registry.posture_registry_id
Write-Host "Status:" $registry.status
Write-Host "Postures:" $registry.postures.Count
Write-Host "Anti-Collapse Rules:" $registry.anti_collapse_rules.Count
Write-Host "Pending Action:" $pending.recommended_next_action
Write-Host "Cited Action:" $cited.recommended_next_action
Write-Host "Supported Action:" $supported.recommended_next_action
Write-Host "Contested Action:" $contested.recommended_next_action
Write-Host "Stale Action:" $stale.recommended_next_action
Write-Host "Superseded Action:" $superseded.recommended_next_action