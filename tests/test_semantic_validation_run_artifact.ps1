# Governance Field Computing
# Semantic Validation Run Artifact Validator
# Version 0.1

$schemaPath = Join-Path $PSScriptRoot "..\schemas\semantic-validation-run.schema.json"
$artifactPath = Join-Path $PSScriptRoot "..\artifacts\semantic-validation-results.v0.1.json"

foreach ($path in @($schemaPath, $artifactPath))
{
    if (-not (Test-Path $path))
    {
        throw "File not found: $path"
    }
}

$schema = Get-Content $schemaPath -Raw | ConvertFrom-Json
$runs = Get-Content $artifactPath -Raw | ConvertFrom-Json

if ($schema.title -ne "Semantic Validation Run")
{
    throw "Unexpected schema title: $($schema.title)"
}

if ($schema.type -ne "array")
{
    throw "Schema must define an array root."
}

if ($null -eq $runs)
{
    throw "Semantic validation artifact did not parse."
}

if ($runs.Count -lt 2)
{
    throw "Expected at least two semantic validation runs."
}

$requiredRunFields = @(
    "label",
    "overall_result",
    "results"
)

$requiredResultFields = @(
    "result_level",
    "domain",
    "source_phrase",
    "rule_set_id",
    "layer",
    "assigned_value",
    "reason",
    "scope_note",
    "warrant_note",
    "evidence_status",
    "recommended_next_action"
)

$allowedOverallResults = @(
    "pass",
    "fail"
)

$allowedResultLevels = @(
    "pass",
    "fail",
    "needs_evidence",
    "needs_domain_review",
    "unsupported",
    "invalid_within_current_taxonomy",
    "out_of_scope",
    "ambiguous",
    "superseded"
)

$allowedLayers = @(
    "governance_phrase",
    "driver",
    "pressure",
    "prerequisite_truth",
    "first_principle",
    "failure_visibility"
)

$allowedEvidenceStatuses = @(
    "not_checked",
    "pending",
    "cited",
    "supported",
    "contested",
    "insufficient"
)

$allowedNextActions = @(
    "accept_for_current_rule_set",
    "reject_for_current_rule_set",
    "collect_evidence",
    "perform_domain_review",
    "revise_taxonomy",
    "revise_rule_set",
    "clarify_assignment",
    "defer",
    "retire_assignment"
)

foreach ($run in $runs)
{
    foreach ($field in $requiredRunFields)
    {
        if (-not $run.PSObject.Properties.Name.Contains($field))
        {
            throw "Missing run field: $field"
        }
    }

    if (-not ($allowedOverallResults -contains $run.overall_result))
    {
        throw "Invalid overall_result: $($run.overall_result)"
    }

    if ($null -eq $run.results)
    {
        throw "Run has no results: $($run.label)"
    }

    if ($run.results.Count -lt 1)
    {
        throw "Run has empty results: $($run.label)"
    }

    foreach ($result in $run.results)
    {
        foreach ($field in $requiredResultFields)
        {
            if (-not $result.PSObject.Properties.Name.Contains($field))
            {
                throw "Missing result field in $($run.label): $field"
            }
        }

        if (-not ($allowedResultLevels -contains $result.result_level))
        {
            throw "Invalid result_level: $($result.result_level)"
        }

        if (-not ($allowedLayers -contains $result.layer))
        {
            throw "Invalid layer: $($result.layer)"
        }

        if (-not ($allowedEvidenceStatuses -contains $result.evidence_status))
        {
            throw "Invalid evidence_status: $($result.evidence_status)"
        }

        if (-not ($allowedNextActions -contains $result.recommended_next_action))
        {
            throw "Invalid recommended_next_action: $($result.recommended_next_action)"
        }
    }
}

$validRun = $runs | Where-Object { $_.label -eq "valid oral hygiene example" }
$invalidRun = $runs | Where-Object { $_.label -eq "adversarial oral hygiene example" }

if ($null -eq $validRun)
{
    throw "Missing valid oral hygiene example run."
}

if ($null -eq $invalidRun)
{
    throw "Missing adversarial oral hygiene example run."
}

if ($validRun.overall_result -ne "pass")
{
    throw "Valid example should pass."
}

if ($invalidRun.overall_result -ne "fail")
{
    throw "Adversarial example should fail."
}

$invalidResults = $invalidRun.results | Where-Object { $_.result_level -eq "invalid_within_current_taxonomy" }

if ($invalidResults.Count -lt 4)
{
    throw "Expected at least four invalid_within_current_taxonomy results for adversarial example."
}

Write-Host ""
Write-Host "PASS: Semantic validation run artifact conforms to expected schema shape."
Write-Host "Schema:" $schemaPath
Write-Host "Artifact:" $artifactPath
Write-Host "Runs validated:" $runs.Count
Write-Host "Adversarial invalid layer results:" $invalidResults.Count