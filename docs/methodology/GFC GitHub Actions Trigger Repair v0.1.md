\# GFC GitHub Actions Trigger Repair v0.1



Artifact: GFC GitHub Actions Trigger Repair v0.1

Version: 0.1

Status: Draft

Artifact Type: Methodology

Date: 2026-06-24



\---



\## 1. Purpose



This document defines how Governance Field Computing repairs or triggers the GitHub Actions workflow after a no-run-observed state.



The purpose is to distinguish:



\- no run observed

\- workflow recognition repair

\- workflow trigger repair

\- workflow file modification

\- workflow dispatch

\- new commit trigger

\- GitHub Actions run creation

\- GitHub Actions passage

\- CI enforcement

\- Level 7 maturity



This procedure prevents trigger repair from being collapsed into workflow passage, CI passage, CI enforcement, or Level 7 maturity.



\---



\## 2. Current Starting Point



The current observation state is:



no\_run\_observed



The accepted observation record is:



docs\\decisions\\GFC-0043-GitHub-Actions-No-Run-Observed.md



The current branch is:



main



The workflow candidate is:



.github\\workflows\\gfc-local-validation.yml



\---



\## 3. Boundary



No run observed does not equal workflow failure.



Trigger repair does not equal workflow passage.



Workflow file modification does not equal workflow execution.



Workflow execution does not equal workflow passage.



Workflow passage does not equal CI enforcement.



CI enforcement does not equal Level 7 maturity unless separately accepted.



\---



\## 4. Repair Objectives



The repair process should determine whether GitHub Actions did not run because of:



1\. workflow file location

2\. workflow YAML syntax

3\. workflow trigger configuration

4\. repository Actions settings

5\. branch event mismatch

6\. manual dispatch absence

7\. permissions or repository configuration

8\. observation timing

9\. GitHub Actions delay

10\. unsupported workflow structure



\---



\## 5. Workflow File Review



The workflow file should be reviewed at:



.github\\workflows\\gfc-local-validation.yml



The workflow should include at minimum:



\- name

\- trigger block

\- job block

\- runner

\- checkout step

\- PowerShell step

\- local validation command



The local validation command should remain:



.\\tests\\run\_gfc\_all\_local\_pipelines.ps1



\---



\## 6. Recommended Trigger Repair



The recommended first repair is to ensure the workflow supports manual dispatch.



The workflow should include:



```yaml

workflow\_dispatch:

The workflow should also preserve push and pull request triggers if they already exist.

A repaired trigger block may include:

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

This does not prove that the workflow ran.

It only creates a clearer trigger surface.

7. Recommended Workflow Shape

A minimal acceptable workflow shape is:

name: GFC Local Validation

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main
  workflow_dispatch:

jobs:
  gfc-local-validation:
    name: Run GFC all local pipelines
    runs-on: windows-latest

    steps:
      - name: Checkout repository
        uses: actions/checkout@v4

      - name: Show PowerShell version
        shell: pwsh
        run: |
          $PSVersionTable

      - name: Run GFC all local pipelines
        shell: pwsh
        run: |
          .\tests\run_gfc_all_local_pipelines.ps1
8. Repair Procedure

The accepted repair sequence is:

Review the current workflow file.
Add or confirm workflow_dispatch.
Confirm push trigger targets main.
Confirm pull_request trigger targets main.
Confirm the job uses windows-latest.
Confirm the shell is pwsh.
Confirm the validation command remains local-suite based.
Commit the workflow repair if changes are made.
Push the repair commit.
Observe whether GitHub Actions creates a run.
Record the observation separately.
9. Manual Dispatch Procedure

If the workflow becomes visible in GitHub Actions, it may be manually triggered from the Actions tab.

Manual dispatch may prove that GitHub recognizes the workflow and can create a run.

Manual dispatch does not prove push-trigger operation.

Manual dispatch does not prove CI enforcement.

Manual dispatch does not prove Level 7 maturity.

10. What Trigger Repair Can Prove

Trigger repair can prove:

workflow file was reviewed
trigger block was updated
manual dispatch was enabled
push trigger was preserved or corrected
pull request trigger was preserved or corrected
repair commit was created
repair commit was pushed
11. What Trigger Repair Does Not Prove

Trigger repair does not prove:

GitHub Actions execution
GitHub Actions passage
CI enforcement
Level 7 maturity
branch protection
pull request gating
release gating
runtime consumption
runtime enforcement
external proof
source authority
source freshness
source relevance
medical adequacy
legal adequacy
scientific consensus
institutional legitimacy
domain-specific authority integration
12. Next Observation Requirement

After trigger repair, GitHub Actions must be observed again using:

docs\methodology\GFC GitHub Actions Observation Procedure v0.1.md

Any observed result must be recorded in a separate decision record.

13. Current Status

Draft.

This procedure is ready for acceptance by decision record after it is saved and verified.