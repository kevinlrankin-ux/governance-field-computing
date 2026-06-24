# Governance Field Computing
# Evidence Reference Set With Posture Validator
# Version 0.1

$setPath = Join-Path $PSScriptRoot "..\examples\evidence-reference-set.oral-hygiene.example.json"
$posturePath = Join-Path $PSScriptRoot "..\examples\evidence-handling-posture.registry.v0.1.json"

foreach ($path in @($setPath, $posturePath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$set = Get-Content $setPath -Raw | ConvertFrom-Json
$registry = Get-Content $posturePath -Raw | ConvertFrom-Json

if ($set.evidence_set_id -ne "EVSET-ORAL-HYGIENE-001")
{
    throw "Unexpected evidence set id: $($set.evidence_set_id)"
}

if ($registry.posture_registry_id -ne "EVIDENCE-HANDLING-POSTURE-REGISTRY-v0.1")
{
    throw "Unexpected posture registry id: $($registry.posture_registry_id)"
}

if ($set.evidence_references.Count -lt 1)
{
    throw "Evidence reference set must contain at least one reference."
}

if ($registry.postures.Count -lt 1)
{
    throw "Posture registry must contain at least one posture."
}

$postureByStatus = @{}

foreach ($posture in $registry.postures)
{
    if ($postureByStatus.ContainsKey($posture.evidence_status))
    {
        throw "Duplicate posture found for evidence status: $($posture.evidence_status)"
    }

    $postureByStatus[$posture.evidence_status] = $posture
}

$resolved = @()

foreach ($reference in $set.evidence_references)
{
    $status = $reference.evidence_status

    if (-not $postureByStatus.ContainsKey($status))
    {
        throw "No handling posture found for evidence status: $status"
    }

    $posture = $postureByStatus[$status]

    $resolved += [PSCustomObject]@{
        evidence_id = $reference.evidence_id
        evidence_status = $status
        handling_posture = $posture.handling_posture
        recommended_next_action = $posture.recommended_next_action
        friction_level = $posture.friction_level
        boundary_note = $posture.boundary_note
    }
}

$pendingResolved = $resolved | Where-Object { $_.evidence_status -eq "pending" } | Select-Object -First 1
$citedResolved = $resolved | Where-Object { $_.evidence_status -eq "cited" } | Select-Object -First 1
$supportedResolved = $resolved | Where-Object { $_.evidence_status -eq "supported" } | Select-Object -First 1

if ($null -eq $pendingResolved)
{
    throw "Pending evidence reference did not resolve to a posture."
}

if ($null -eq $citedResolved)
{
    throw "Cited evidence reference did not resolve to a posture."
}

if ($null -eq $supportedResolved)
{
    throw "Supported evidence reference did not resolve to a posture."
}

if ($pendingResolved.recommended_next_action -ne "cite_sources")
{
    throw "Pending evidence should recommend cite_sources."
}

if ($citedResolved.recommended_next_action -ne "review_support")
{
    throw "Cited evidence should recommend review_support."
}

if ($supportedResolved.recommended_next_action -ne "continue")
{
    throw "Supported evidence should recommend continue."
}

if ($pendingResolved.handling_posture -ne "signal_incomplete_evidence")
{
    throw "Pending evidence should resolve to signal_incomplete_evidence."
}

if ($citedResolved.handling_posture -ne "allow_citation_reference_block_support_claim")
{
    throw "Cited evidence should resolve to allow_citation_reference_block_support_claim."
}

if ($supportedResolved.handling_posture -ne "allow_scoped_support_claim")
{
    throw "Supported evidence should resolve to allow_scoped_support_claim."
}

if ($supportedResolved.boundary_note -notlike "*scope-bound*")
{
    throw "Supported posture boundary must preserve scope-bound support."
}

if ($citedResolved.boundary_note -notlike "*does not equal supported*")
{
    throw "Cited posture boundary must preserve cited-not-supported distinction."
}

if ($pendingResolved.boundary_note -notlike "*blocks support claims*")
{
    throw "Pending posture boundary must block support claims."
}

$setStatusCount = $set.evidence_references.Count
$resolvedCount = $resolved.Count

if ($setStatusCount -ne $resolvedCount)
{
    throw "Resolved posture count does not match evidence reference count."
}

$aggregateActions = @($resolved | ForEach-Object { $_.recommended_next_action } | Sort-Object -Unique)

if (-not ($aggregateActions -contains "cite_sources"))
{
    throw "Aggregate actions must include cite_sources."
}

if (-not ($aggregateActions -contains "review_support"))
{
    throw "Aggregate actions must include review_support."
}

if (-not ($aggregateActions -contains "continue"))
{
    throw "Aggregate actions must include continue."
}

if ($set.boundary_note -notlike "*strongest record does not erase*")
{
    throw "Evidence set must preserve weaker-record visibility."
}

if ($registry.boundary_note -notlike "*without collapsing uncertainty into binary pass or fail*")
{
    throw "Posture registry must preserve anti-collapse runtime boundary."
}

Write-Host ""
Write-Host "PASS: Evidence reference set resolves to handling postures."
Write-Host "Evidence Set ID:" $set.evidence_set_id
Write-Host "Posture Registry ID:" $registry.posture_registry_id
Write-Host "References Resolved:" $resolved.Count
Write-Host ""
Write-Host "Resolved Postures:"
foreach ($item in $resolved)
{
    Write-Host "- $($item.evidence_status) -> $($item.handling_posture) -> $($item.recommended_next_action)"
}
Write-Host ""
Write-Host "Aggregate Actions:" ($aggregateActions -join ", ")