# Governance Field Computing
# CI Workflow Candidate Shape Validator
# Version 0.1

$workflowPath = ".\.github\workflows\gfc-local-validation.yml"

if (-not (Test-Path $workflowPath))
{
    throw "CI workflow candidate not found: $workflowPath"
}

$workflowText = Get-Content $workflowPath -Raw

$requiredFragments = @(
    "name: GFC Local Validation",
    "push:",
    "pull_request:",
    "workflow_dispatch:",
    "windows-latest",
    "actions/checkout@v4",
    "shell: pwsh",
    ".\tests\run_gfc_all_local_pipelines.ps1"
)

foreach ($fragment in $requiredFragments)
{
    if ($workflowText -notlike "*$fragment*")
    {
        throw "Workflow candidate missing required fragment: $fragment"
    }
}

if ($workflowText -notlike "*main*")
{
    throw "Workflow candidate must include main branch trigger."
}

if ($workflowText -notlike "*master*")
{
    throw "Workflow candidate must include master branch trigger."
}

if ($workflowText -like "*runtime enforcement*")
{
    throw "Workflow candidate must not claim runtime enforcement."
}

if ($workflowText -like "*domain-specific authority*")
{
    throw "Workflow candidate must not claim domain-specific authority."
}

if ($workflowText -like "*medical adequacy*")
{
    throw "Workflow candidate must not claim medical adequacy."
}

if ($workflowText -like "*legal adequacy*")
{
    throw "Workflow candidate must not claim legal adequacy."
}

if ($workflowText -like "*scientific consensus*")
{
    throw "Workflow candidate must not claim scientific consensus."
}

Write-Host ""
Write-Host "PASS: CI workflow candidate shape conforms to expected local structure."
Write-Host "Workflow:" $workflowPath
Write-Host "Workflow Name: GFC Local Validation"
Write-Host "Includes Push Trigger: yes"
Write-Host "Includes Pull Request Trigger: yes"
Write-Host "Includes Manual Dispatch: yes"
Write-Host "Runner: windows-latest"
Write-Host "Shell: pwsh"
Write-Host "Command: .\tests\run_gfc_all_local_pipelines.ps1"
Write-Host ""
Write-Host "Boundary:"
Write-Host "workflow shape validation does not equal CI enforcement"