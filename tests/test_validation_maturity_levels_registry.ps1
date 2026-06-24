# Governance Field Computing
# Validation Maturity Levels Registry Validator
# Version 0.1

$schemaPath = ".\schemas\validation-maturity-level.schema.json"
$registryPath = ".\examples\validation-maturity-levels.registry.v0.1.json"

if (-not (Test-Path $schemaPath))
{
    throw "Schema not found: $schemaPath"
}

if (-not (Test-Path $registryPath))
{
    throw "Registry not found: $registryPath"
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$registry = Get-Content $registryPath -Raw | ConvertFrom-Json

$requiredTopLevelFields = @(
    "registry_id",
    "version",
    "status",
    "current_gfc_maturity_level",
    "levels",
    "required_level_names",
    "anti_inflation_note",
    "boundary_note",
    "current_capability_note",
    "not_yet_achieved_note"
)

foreach ($field in $requiredTopLevelFields)
{
    if (-not ($registry.PSObject.Properties.Name -contains $field))
    {
        throw "Registry missing required top-level field: $field"
    }
}

if ($registry.registry_id -ne "VALIDATION-MATURITY-LEVELS-REGISTRY-v0.1")
{
    throw "Unexpected registry_id: $($registry.registry_id)"
}

if ($registry.status -ne "draft")
{
    throw "Registry status should be draft for v0.1."
}

if ($registry.current_gfc_maturity_level -ne 6)
{
    throw "Current GFC maturity level should be 6."
}

if ($registry.levels.Count -ne 10)
{
    throw "Expected exactly 10 validation maturity levels."
}

if ($registry.required_level_names.Count -ne 10)
{
    throw "Expected exactly 10 required level names."
}

$expectedNames = @(
    "Prose-only methodology",
    "Structured artifact",
    "Schema-defined artifact",
    "Local validator",
    "Local pipeline",
    "Combined local suite",
    "CI-enforced suite",
    "Runtime-consumed registry",
    "Runtime boundary enforcement",
    "Domain-specific authority integration"
)

foreach ($name in $expectedNames)
{
    if (-not ($registry.required_level_names -contains $name))
    {
        throw "Required level name missing: $name"
    }

    $matchingLevel = $registry.levels | Where-Object { $_.name -eq $name }

    if (-not $matchingLevel)
    {
        throw "Registry levels missing level: $name"
    }
}

$expectedLevelNumbers = 1..10

foreach ($levelNumber in $expectedLevelNumbers)
{
    $matchingLevel = $registry.levels | Where-Object { $_.level_number -eq $levelNumber }

    if (-not $matchingLevel)
    {
        throw "Registry missing level number: $levelNumber"
    }
}

$duplicateLevelNumbers = $registry.levels |
    Group-Object level_number |
    Where-Object { $_.Count -gt 1 }

if ($duplicateLevelNumbers.Count -gt 0)
{
    throw "Duplicate maturity level numbers found: $($duplicateLevelNumbers.Name -join ', ')"
}

$duplicateLevelNames = $registry.levels |
    Group-Object name |
    Where-Object { $_.Count -gt 1 }

if ($duplicateLevelNames.Count -gt 0)
{
    throw "Duplicate maturity level names found: $($duplicateLevelNames.Name -join ', ')"
}

$currentLevel = $registry.levels | Where-Object { $_.level_number -eq 6 }

if ($currentLevel.current_status -ne "current")
{
    throw "Level 6 must be marked current."
}

$futureLevels = $registry.levels | Where-Object { $_.level_number -ge 7 }

foreach ($futureLevel in $futureLevels)
{
    if ($futureLevel.current_status -ne "not_yet_achieved")
    {
        throw "Future level must be marked not_yet_achieved: $($futureLevel.level_number) $($futureLevel.name)"
    }
}

$achievedLevels = $registry.levels | Where-Object { $_.level_number -le 5 }

foreach ($achievedLevel in $achievedLevels)
{
    if ($achievedLevel.current_status -ne "achieved")
    {
        throw "Levels 1 through 5 must be marked achieved: $($achievedLevel.level_number) $($achievedLevel.name)"
    }
}

if ($registry.anti_inflation_note -notlike "*must not be inflated*")
{
    throw "Registry anti-inflation note must prevent maturity inflation."
}

if ($registry.boundary_note -notlike "*lower maturity level must not claim*")
{
    throw "Registry boundary note must preserve lower/higher maturity distinction."
}

if ($registry.current_capability_note -notlike "*Level 6*")
{
    throw "Registry current capability note must identify Level 6."
}

if ($registry.not_yet_achieved_note -notlike "*not yet achieved*")
{
    throw "Registry not-yet-achieved note must preserve future-level limitation."
}

$level7 = $registry.levels | Where-Object { $_.level_number -eq 7 }
$level8 = $registry.levels | Where-Object { $_.level_number -eq 8 }
$level9 = $registry.levels | Where-Object { $_.level_number -eq 9 }
$level10 = $registry.levels | Where-Object { $_.level_number -eq 10 }

if ($level7.boundary_rule -notlike "*not runtime enforcement*")
{
    throw "Level 7 boundary must distinguish CI enforcement from runtime enforcement."
}

if ($level8.boundary_rule -notlike "*not runtime enforcement*")
{
    throw "Level 8 boundary must distinguish runtime consumption from runtime enforcement."
}

if ($level9.boundary_rule -notlike "*not domain-specific authority integration*")
{
    throw "Level 9 boundary must distinguish runtime enforcement from domain authority."
}

if ($level10.boundary_rule -notlike "*scoped, not universal*")
{
    throw "Level 10 boundary must preserve scoped authority."
}

Write-Host ""
Write-Host "PASS: Validation maturity levels registry conforms to expected schema shape."
Write-Host "Schema:" $schemaPath
Write-Host "Registry:" $registryPath
Write-Host "Registry ID:" $registry.registry_id
Write-Host "Version:" $registry.version
Write-Host "Status:" $registry.status
Write-Host "Current GFC Maturity Level:" $registry.current_gfc_maturity_level
Write-Host "Levels Validated:" $registry.levels.Count
Write-Host "Required Level Names:" $registry.required_level_names.Count
Write-Host "Current Level:" $currentLevel.name
Write-Host "Future Levels Not Yet Achieved:" $futureLevels.Count
Write-Host "Anti-Inflation Boundary: present"
Write-Host "Lower/Higher Boundary: present"