# Governance Field Computing
# GitHub Commit Readiness Validator
# Version 0.1

Write-Host ""
Write-Host "GFC GitHub Commit Readiness Validator v0.1"
Write-Host "=========================================="
Write-Host ""

$requiredArtifacts = @(
    @{
        Name = "CI Workflow Candidate"
        Path = ".\.github\workflows\gfc-local-validation.yml"
    },
    @{
        Name = "CI Workflow Candidate Shape Validator"
        Path = ".\tests\test_ci_workflow_candidate_shape.ps1"
    },
    @{
        Name = "CI Readiness Pipeline"
        Path = ".\tests\run_gfc_ci_readiness_pipeline.ps1"
    },
    @{
        Name = "Expanded All Local Pipelines Runner"
        Path = ".\tests\run_gfc_all_local_pipelines.ps1"
    },
    @{
        Name = "CI Enforcement Readiness Methodology"
        Path = ".\docs\methodology\GFC CI Enforcement Readiness v0.1.md"
    },
    @{
        Name = "GitHub Commit Readiness Methodology"
        Path = ".\docs\methodology\GFC GitHub Commit Readiness v0.1.md"
    },
    @{
        Name = "GFC-0030 CI Enforcement Readiness Decision"
        Path = ".\docs\decisions\GFC-0030-CI-Enforcement-Readiness-Accepted.md"
    },
    @{
        Name = "GFC-0031 CI Workflow Candidate Decision"
        Path = ".\docs\decisions\GFC-0031-CI-Workflow-Candidate-Created.md"
    },
    @{
        Name = "GFC-0032 CI Workflow Candidate Shape Decision"
        Path = ".\docs\decisions\GFC-0032-CI-Workflow-Candidate-Shape-Validated.md"
    },
    @{
        Name = "GFC-0033 CI Readiness Pipeline Decision"
        Path = ".\docs\decisions\GFC-0033-CI-Readiness-Pipeline-Accepted.md"
    },
    @{
        Name = "GFC-0034 All Local Pipelines With CI Readiness Decision"
        Path = ".\docs\decisions\GFC-0034-All-Local-Pipelines-With-CI-Readiness-Accepted.md"
    },
    @{
        Name = "GFC-0035 GitHub Commit Readiness Decision"
        Path = ".\docs\decisions\GFC-0035-GitHub-Commit-Readiness-Accepted.md"
    }
)

foreach ($artifact in $requiredArtifacts)
{
    Write-Host "CHECKING:" $artifact.Name
    Write-Host "Path:" $artifact.Path

    if (-not (Test-Path $artifact.Path))
    {
        throw "Required commit-readiness artifact missing: $($artifact.Path)"
    }

    Write-Host "PRESENT:" $artifact.Name
    Write-Host ""
}

$commitReadinessMethodology = Get-Content ".\docs\methodology\GFC GitHub Commit Readiness v0.1.md" -Raw
$commitReadinessDecision = Get-Content ".\docs\decisions\GFC-0035-GitHub-Commit-Readiness-Accepted.md" -Raw

$boundaryChecks = @(
    @{
        Name = "commit readiness not commit"
        MethodologyAny = @(
            "A commit-readiness methodology is not a commit",
            "A commit-readiness decision record is not a commit",
            "Commit readiness means"
        )
        DecisionAny = @(
            "Commit readiness is not a commit",
            "commit-ready",
            "It does not mean:"
        )
    },
    @{
        Name = "commit not push"
        MethodologyAny = @(
            "A commit is not a push"
        )
        DecisionAny = @(
            "A commit is not a push"
        )
    },
    @{
        Name = "pushed branch not CI pass"
        MethodologyAny = @(
            "A pushed branch is not a CI pass"
        )
        DecisionAny = @(
            "A pushed branch is not a CI pass"
        )
    },
    @{
        Name = "CI pass not runtime enforcement"
        MethodologyAny = @(
            "A CI pass is not runtime enforcement"
        )
        DecisionAny = @(
            "A CI pass is not runtime enforcement"
        )
    },
    @{
        Name = "CI enforcement not domain authority"
        MethodologyAny = @(
            "CI enforcement is not domain-specific authority"
        )
        DecisionAny = @(
            "CI enforcement is not domain-specific authority"
        )
    },
    @{
        Name = "Level 7 not achieved"
        MethodologyAny = @(
            "Level 7 requires actual GitHub Actions execution and passage",
            "Level 7 requires actual GitHub Actions execution"
        )
        DecisionAny = @(
            "Level 7 has not yet been achieved",
            "This artifact does not move GFC to:",
            "Level 7 requires actual GitHub Actions execution and passage"
        )
    },
    @{
        Name = "commit readiness not CI execution"
        MethodologyAny = @(
            "Commit readiness does not mean:",
            "GitHub Actions has run",
            "GitHub Actions has passed"
        )
        DecisionAny = @(
            "It does not claim that CI has run",
            "It does not claim CI enforcement",
            "It does not mean:"
        )
    }
)

foreach ($check in $boundaryChecks)
{
    $methodologyFound = $false

    foreach ($fragment in $check.MethodologyAny)
    {
        if ($commitReadinessMethodology -like "*$fragment*")
        {
            $methodologyFound = $true
        }
    }

    if (-not $methodologyFound)
    {
        throw "Commit readiness methodology missing boundary check: $($check.Name)"
    }

    $decisionFound = $false

    foreach ($fragment in $check.DecisionAny)
    {
        if ($commitReadinessDecision -like "*$fragment*")
        {
            $decisionFound = $true
        }
    }

    if (-not $decisionFound)
    {
        throw "Commit readiness decision missing boundary check: $($check.Name)"
    }
}

$requiredDecisionBoundaryFragments = @(
    "This milestone accepts commit readiness only.",
    "It does not claim that a commit has occurred.",
    "It does not claim that CI has run.",
    "It does not claim CI enforcement.",
    "Level 7 has not yet been achieved."
)

foreach ($fragment in $requiredDecisionBoundaryFragments)
{
    if ($commitReadinessDecision -notlike "*$fragment*")
    {
        throw "Commit readiness decision missing required boundary fragment: $fragment"
    }
}

Write-Host "PASS: GitHub commit readiness artifact set conforms to expected local structure."
Write-Host "Artifacts Checked:" $requiredArtifacts.Count
Write-Host "CI Workflow Candidate: present"
Write-Host "CI Workflow Candidate Shape Validator: present"
Write-Host "CI Readiness Pipeline: present"
Write-Host "Expanded All Local Pipelines Runner: present"
Write-Host "CI Enforcement Readiness Methodology: present"
Write-Host "GitHub Commit Readiness Methodology: present"
Write-Host "Decision Records GFC-0030 through GFC-0035: present"
Write-Host "Boundary Checks Validated:" $boundaryChecks.Count
Write-Host "Required Decision Boundary Fragments:" $requiredDecisionBoundaryFragments.Count
Write-Host ""
Write-Host "Current Commit Status:"
Write-Host "commit-ready locally validated"
Write-Host ""
Write-Host "Boundary:"
Write-Host "commit readiness validation does not equal commit, push, CI pass, CI enforcement, runtime enforcement, or domain-specific authority integration"