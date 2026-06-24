# Governance Field Computing
# Evidence Boundary Principles Registry Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\evidence-boundary-principles.schema.json"
$registryPath = Join-Path $PSScriptRoot "..\examples\evidence-boundary-principles.registry.v0.1.json"

foreach ($path in @($schemaPath, $registryPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$registry = Get-Content $registryPath -Raw | ConvertFrom-Json

if ($schema.title -ne "Evidence Boundary Principles Registry")
{
    throw "Unexpected schema title: $($schema.title)"
}

$requiredRegistryFields = @(
    "registry_id",
    "version",
    "status",
    "principles",
    "required_principle_names",
    "anti_inflation_note",
    "boundary_note",
    "vendor_boundary_note"
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

if ($registry.registry_id -ne "EVIDENCE-BOUNDARY-PRINCIPLES-REGISTRY-v0.1")
{
    throw "Unexpected registry_id: $($registry.registry_id)"
}

if ($registry.version -ne "0.1")
{
    throw "Unexpected registry version: $($registry.version)"
}

if ($registry.status -ne "draft")
{
    throw "Expected registry status to be draft."
}

if ($registry.principles.Count -ne 15)
{
    throw "Expected exactly 15 evidence boundary principles."
}

if ($registry.required_principle_names.Count -ne 15)
{
    throw "Expected exactly 15 required principle names."
}

$requiredPrincipleFields = @(
    "principle_id",
    "principle_number",
    "name",
    "statement",
    "boundary_rule",
    "anti_collapse_rule",
    "applies_to",
    "methodology_ref",
    "decision_ref"
)

foreach ($principle in $registry.principles)
{
    foreach ($field in $requiredPrincipleFields)
    {
        if (-not $principle.PSObject.Properties.Name.Contains($field))
        {
            throw "Missing required principle field: $field"
        }

        if ($null -eq $principle.$field)
        {
            throw "Required principle field is null: $field"
        }
    }

    if ($principle.principle_id -notmatch "^EBP-\d{3}$")
    {
        throw "Invalid principle_id format: $($principle.principle_id)"
    }

    if ($principle.principle_number -lt 1)
    {
        throw "Invalid principle_number: $($principle.principle_number)"
    }

    if ($principle.applies_to.Count -lt 1)
    {
        throw "Principle must apply to at least one category: $($principle.name)"
    }

    if ($principle.methodology_ref -ne "docs/methodology/GFC Evidence Boundary Principles v0.1.md")
    {
        throw "Unexpected methodology_ref for principle: $($principle.name)"
    }

    if ($principle.decision_ref -ne "docs/decisions/GFC-0021-Evidence-Boundary-Principles-Accepted.md")
    {
        throw "Unexpected decision_ref for principle: $($principle.name)"
    }
}

$principleIds = @($registry.principles | ForEach-Object { $_.principle_id })
$duplicateIds = $principleIds |
    Group-Object |
    Where-Object { $_.Count -gt 1 }

if ($duplicateIds.Count -gt 0)
{
    throw "Duplicate principle IDs found: $($duplicateIds.Name -join ', ')"
}

$principleNumbers = @($registry.principles | ForEach-Object { $_.principle_number })
$duplicateNumbers = $principleNumbers |
    Group-Object |
    Where-Object { $_.Count -gt 1 }

if ($duplicateNumbers.Count -gt 0)
{
    throw "Duplicate principle numbers found: $($duplicateNumbers.Name -join ', ')"
}

foreach ($expectedNumber in 1..15)
{
    if (-not ($principleNumbers -contains $expectedNumber))
    {
        throw "Missing principle number: $expectedNumber"
    }
}

$principleNames = @($registry.principles | ForEach-Object { $_.name })

foreach ($requiredName in $registry.required_principle_names)
{
    if (-not ($principleNames -contains $requiredName))
    {
        throw "Registry missing required principle: $requiredName"
    }
}

$requiredNames = @(
    "Semantic Validation Is Not Proof",
    "Citation Presence Is Not Support",
    "Support Is Scope-Bound",
    "Stronger Evidence Does Not Erase Weaker Evidence Records",
    "Missing Evidence Is Not Disproof",
    "Stale Evidence Is Not Erased Evidence",
    "Superseded Evidence Remains Auditable",
    "Runtime Posture Is Not Institutional Authority",
    "Domain Rules Must Be Declared Before Domain Claims Are Expanded",
    "Anti-Inflation Language Must Travel With Generated Artifacts",
    "Evidence Status Is Not Evidence Quality",
    "Evidence Handling Must Preserve Review Pathways",
    "Local Validation Is Not Live Enforcement",
    "Placeholder Sources Must Remain Marked",
    "Evidence Boundary Failures Must Be Visible"
)

foreach ($requiredName in $requiredNames)
{
    if (-not ($principleNames -contains $requiredName))
    {
        throw "Missing accepted boundary principle: $requiredName"
    }
}

$semanticPrinciple = $registry.principles |
    Where-Object { $_.name -eq "Semantic Validation Is Not Proof" } |
    Select-Object -First 1

if ($semanticPrinciple.boundary_rule -notlike "*not be inflated into proof*")
{
    throw "Semantic validation principle must preserve anti-proof inflation boundary."
}

$citationPrinciple = $registry.principles |
    Where-Object { $_.name -eq "Citation Presence Is Not Support" } |
    Select-Object -First 1

if ($citationPrinciple.anti_collapse_rule -notlike "*citation presence into source support*")
{
    throw "Citation principle must preserve citation/support distinction."
}

$scopePrinciple = $registry.principles |
    Where-Object { $_.name -eq "Support Is Scope-Bound" } |
    Select-Object -First 1

if ($scopePrinciple.boundary_rule -notlike "*Support must travel with scope*")
{
    throw "Scope-bound support principle must preserve scope boundary."
}

$runtimePrinciple = $registry.principles |
    Where-Object { $_.name -eq "Runtime Posture Is Not Institutional Authority" } |
    Select-Object -First 1

if ($runtimePrinciple.boundary_rule -notlike "*not external legitimacy*")
{
    throw "Runtime posture principle must preserve institutional-authority boundary."
}

$vendorNote = $registry.vendor_boundary_note

if ($vendorNote -notlike "*vendor scan does not equal adoption*")
{
    throw "Vendor boundary note must preserve no-import rule."
}

if ($registry.anti_inflation_note -notlike "*inflated into proof*")
{
    throw "Registry anti-inflation note must prevent proof inflation."
}

if ($registry.boundary_note -notlike "*semantic validation*")
{
    throw "Registry boundary note must mention semantic validation."
}

if ($registry.boundary_note -notlike "*institutional authority*")
{
    throw "Registry boundary note must mention institutional authority."
}

Write-Host ""
Write-Host "PASS: Evidence boundary principles registry conforms to expected schema shape."
Write-Host "Registry ID:" $registry.registry_id
Write-Host "Version:" $registry.version
Write-Host "Status:" $registry.status
Write-Host "Principles Validated:" $registry.principles.Count
Write-Host "Required Principle Names:" $registry.required_principle_names.Count
Write-Host "First Principle:" $registry.principles[0].name
Write-Host "Final Principle:" $registry.principles[-1].name
Write-Host "Anti-Inflation Boundary: present"
Write-Host "Vendor Boundary: present"