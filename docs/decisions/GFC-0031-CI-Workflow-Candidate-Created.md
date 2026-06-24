\# GFC-0031 — CI Workflow Candidate Created



Artifact: GFC-0031 — CI Workflow Candidate Created

Version: 1.0

Status: Accepted

Decision Type: CI Workflow Candidate Record

Date: 2026-06-24



\---



\## 1. Summary



Governance Field Computing records that the first GitHub Actions workflow candidate has been created.



The workflow candidate is intended to invoke the current accepted top-level local validation command:



tests\\run\_gfc\_all\_local\_pipelines.ps1



This milestone records workflow candidate creation only.



It does not claim CI enforcement.



\---



\## 2. Workflow Candidate Created



Workflow candidate:



.github\\workflows\\gfc-local-validation.yml



Workflow name:



GFC Local Validation



Primary command invoked:



.\\tests\\run\_gfc\_all\_local\_pipelines.ps1



\---



\## 3. Relationship to Prior Artifacts



This workflow candidate follows:



docs\\decisions\\GFC-0029-All-Local-Pipelines-Accepted.md



and:



docs\\decisions\\GFC-0030-CI-Enforcement-Readiness-Accepted.md



GFC-0029 accepted the top-level local validation command.



GFC-0030 accepted the readiness boundary for future CI enforcement.



GFC-0031 records that a candidate workflow file now exists.



\---



\## 4. Candidate Workflow Behavior



The workflow candidate is configured to run on:



\- push to main

\- push to master

\- pull request into main

\- pull request into master

\- manual workflow dispatch



The workflow candidate uses:



windows-latest



The workflow candidate checks out the repository and runs:



.\\tests\\run\_gfc\_all\_local\_pipelines.ps1



\---



\## 5. What Was Proven



This milestone proves only that a CI workflow candidate file exists locally.



It proves that:



1\. The .github\\workflows directory exists.

2\. The gfc-local-validation.yml file exists.

3\. The workflow candidate points toward the accepted top-level local validation command.

4\. The workflow candidate is structurally ready to be committed and tested in GitHub Actions.



\---



\## 6. What Was Not Proven



This milestone does not prove:



\- CI enforcement

\- CI workflow execution

\- CI workflow passage

\- pull request gating

\- branch protection

\- release gating

\- runtime consumption

\- runtime enforcement

\- external proof

\- source authority

\- source freshness

\- source relevance

\- medical adequacy

\- legal adequacy

\- scientific consensus

\- institutional legitimacy

\- domain-specific authority integration



The workflow file has been created, but CI enforcement is not achieved until the workflow runs and passes in GitHub Actions and the result is recorded.



\---



\## 7. Boundary Preserved



The accepted boundary is:



Workflow candidate creation is not CI enforcement.



A workflow file is not CI enforcement until it has run and passed.



A passing CI workflow is not runtime enforcement.



CI enforcement is not domain-specific authority.



\---



\## 8. Current GFC Maturity Level



The current GFC maturity level remains:



Level 6 — Combined local suite



This artifact does not move GFC to:



Level 7 — CI-enforced suite



Level 7 remains future work until a CI run has passed and the maturity registry is updated by decision record.



\---



\## 9. Decision



Accepted.



The GitHub Actions workflow candidate is recorded as created.



\---



\## 10. Next Approved Build



Create:



tests\\test\_ci\_workflow\_candidate\_shape.ps1



Purpose:



Validate the local workflow candidate file for expected structural properties before relying on it.



The validator should confirm:



1\. .github\\workflows\\gfc-local-validation.yml exists.

2\. The workflow names GFC Local Validation.

3\. The workflow includes push.

4\. The workflow includes pull\_request.

5\. The workflow includes workflow\_dispatch.

6\. The workflow uses windows-latest.

7\. The workflow invokes tests\\run\_gfc\_all\_local\_pipelines.ps1.

8\. The validator preserves the boundary that workflow shape validation is not CI enforcement.



Then create:



docs\\decisions\\GFC-0032-CI-Workflow-Candidate-Shape-Validated.md



Purpose:



Accept local workflow candidate shape validation while preserving that CI has not yet run.



\---



Decision Status: ACTIVE

