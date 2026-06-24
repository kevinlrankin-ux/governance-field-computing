# Governance Field Computing
# Pressure Layer Semantic Rules Validator
# Version 0.2

$rulesPath = Join-Path $PSScriptRoot "..\schemas\pressure-layer-semantic-rules.v0.1.json"
$validPath = Join-Path $PSScriptRoot "..\examples\pressure-layer-taxonomy.example.json"
$invalidPath = Join-Path $PSScriptRoot "..\examples\pressure-layer-taxonomy.invalid.example.json"
$outputPath = Join-Path $PSScriptRoot "..\artifacts\semantic-validation-results.v0.1.json"

foreach ($path in @($rulesPath, $validPath, $invalidPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$outputDirectory = Split-Path $outputPath -Parent

if (-not (Test-Path $outputDirectory))
{
    New-Item -ItemType Directory -Path $outputDirectory | Out-Null
}

$rules = Get-Content $rulesPath -Raw | ConvertFrom-Json
$validExample = Get-Content $validPath -Raw | ConvertFrom-Json
$invalidExample = Get-Content $invalidPath -Raw | ConvertFrom-Json

function New-SemanticResult {
    param (
        [string]$ResultLevel,
        [string]$Layer,
        [string]$AssignedValue,
        [string]$Reason,
        [string]$RecommendedNextAction,
        [object]$Rules
    )

    return [PSCustomObject]@{
        result_level = $ResultLevel
        domain = $Rules.domain
        source_phrase = $Rules.source_phrase
        rule_set_id = $Rules.rule_set_id
        layer = $Layer
        assigned_value = $AssignedValue
        reason = $Reason
        scope_note = $Rules.scope_note
        warrant_note = $Rules.warrant_note
        evidence_status = "pending"
        recommended_next_action = $RecommendedNextAction
    }
}

function Test-LayerAssignment {
    param (
        [object]$Example,
        [object]$Rules,
        [string]$Layer
    )

    $assignedValue = $Example.$Layer
    $validValues = $Rules.valid_assignments.$Layer
    $invalidValues = $Rules.invalid_assignments.$Layer

    if ($validValues -contains $assignedValue)
    {
        return New-SemanticResult `
            -ResultLevel "pass" `
            -Layer $Layer `
            -AssignedValue $assignedValue `
            -Reason "Assignment matches the current domain-bound valid assignment list." `
            -RecommendedNextAction "accept_for_current_rule_set" `
            -Rules $Rules
    }

    if ($invalidValues -contains $assignedValue)
    {
        return New-SemanticResult `
            -ResultLevel "invalid_within_current_taxonomy" `
            -Layer $Layer `
            -AssignedValue $assignedValue `
            -Reason "Assignment appears in the current invalid assignment list for this domain-bound rule set." `
            -RecommendedNextAction "reject_for_current_rule_set" `
            -Rules $Rules
    }

    return New-SemanticResult `
        -ResultLevel "unsupported" `
        -Layer $Layer `
        -AssignedValue $assignedValue `
        -Reason "Assignment is not listed as valid or invalid in the current domain-bound rule set." `
        -RecommendedNextAction "collect_evidence" `
        -Rules $Rules
}

function Test-Example {
    param (
        [object]$Example,
        [object]$Rules,
        [string]$Label
    )

    $layers = @(
        "driver",
        "pressure",
        "prerequisite_truth",
        "first_principle"
    )

    $results = @()

    foreach ($layer in $layers)
    {
        $results += Test-LayerAssignment -Example $Example -Rules $Rules -Layer $layer
    }

    $overallResult = if (($results | Where-Object { $_.result_level -ne "pass" }).Count -eq 0) { "pass" } else { "fail" }

    return [PSCustomObject]@{
        label = $Label
        overall_result = $overallResult
        results = $results
    }
}

$validRun = Test-Example -Example $validExample -Rules $rules -Label "valid oral hygiene example"
$invalidRun = Test-Example -Example $invalidExample -Rules $rules -Label "adversarial oral hygiene example"

$allRuns = @($validRun, $invalidRun)

$allRuns | ConvertTo-Json -Depth 10 | Set-Content $outputPath -Encoding UTF8

Write-Host ""
Write-Host "Semantic Validation:" $validRun.label
Write-Host "Overall Result:" $validRun.overall_result

Write-Host ""
Write-Host "Semantic Validation:" $invalidRun.label
Write-Host "Overall Result:" $invalidRun.overall_result

foreach ($result in $invalidRun.results)
{
    if ($result.result_level -ne "pass")
    {
        Write-Host "- " $result.result_level ":" $result.layer "=" $result.assigned_value
    }
}

if ($validRun.overall_result -ne "pass")
{
    throw "Valid example failed semantic validation."
}

if ($invalidRun.overall_result -ne "fail")
{
    throw "Adversarial example did not fail semantic validation."
}

Write-Host ""
Write-Host "PASS: Structured semantic validation results emitted."
Write-Host "Output:" $outputPath