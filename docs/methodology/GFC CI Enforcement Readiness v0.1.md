\# GFC CI Enforcement Readiness v0.1



Artifact: GFC CI Enforcement Readiness v0.1

Version: 0.1

Status: Draft

Methodology Type: CI Readiness Boundary

Date: 2026-06-24



\---



\## 1. Purpose



This methodology defines what must exist before Governance Field Computing may claim:



Level 7 — CI-enforced suite



The current GFC maturity level is:



Level 6 — Combined local suite



This document preserves the boundary between a local validation command and a CI-enforced validation suite.



\---



\## 2. Current Accepted State



GFC currently has an accepted top-level local validation command:



tests\\run\_gfc\_all\_local\_pipelines.ps1



This command runs:



1\. Combined Local Validation Suite

2\. Validation Maturity Pipeline



The command has passed locally.



This means GFC has a repeatable local validation suite.



It does not mean GFC has CI enforcement.



\---



\## 3. Current Maturity Level



Current maturity level:



Level 6 — Combined local suite



Accepted maturity registry:



examples\\validation-maturity-levels.registry.v0.1.json



Accepted maturity decision:



docs\\decisions\\GFC-0027-Validation-Maturity-Level-Registry-Accepted.md



Accepted maturity pipeline:



tests\\run\_gfc\_maturity\_pipeline.ps1



Accepted top-level local command:



tests\\run\_gfc\_all\_local\_pipelines.ps1



\---



\## 4. Target Future Maturity Level



Target future level:



Level 7 — CI-enforced suite



Level 7 means the accepted local validation command runs automatically in continuous integration.



A CI-enforced suite requires more than a passing local command.



\---



\## 5. Required Conditions Before Claiming Level 7



GFC may not claim Level 7 until all of the following exist:



1\. A CI workflow file exists.

2\. The CI workflow invokes the accepted top-level local command.

3\. The CI workflow runs on pull request or push.

4\. The CI workflow fails when the local pipeline fails.

5\. The CI workflow passes when the local pipeline passes.

6\. CI output is visible in repository workflow history.

7\. The CI workflow path is documented.

8\. The CI result is captured or referenced in a decision record.

9\. The maturity registry is updated to identify Level 7 as current only after CI has actually passed.

10\. A decision record accepts the Level 7 transition.



\---



\## 6. Minimum CI Artifact Set



The minimum artifact set for Level 7 should include:



1\. .github\\workflows\\gfc-local-validation.yml

2\. tests\\run\_gfc\_all\_local\_pipelines.ps1

3\. docs\\decisions\\GFC-0029-All-Local-Pipelines-Accepted.md

4\. examples\\validation-maturity-levels.registry.v0.1.json

5\. docs\\decisions\\GFC-0030-CI-Enforcement-Readiness-Accepted.md

6\. future decision record accepting CI enforcement after CI has passed



\---



\## 7. Required CI Workflow Behavior



The CI workflow should:



1\. Check out the repository.

2\. Use an available PowerShell runtime.

3\. Run:



&#x20;  .\\tests\\run\_gfc\_all\_local\_pipelines.ps1



4\. Treat any thrown error as failure.

5\. Treat any non-zero exit code as failure.

6\. Emit clear console output.

7\. Avoid modifying repository files during CI.

8\. Preserve local/CI boundary language.



\---



\## 8. CI Enforcement Boundary



CI enforcement means:



The repository automatically runs the accepted validation command during a configured repository event.



CI enforcement does not mean:



\- runtime enforcement

\- agent behavior enforcement

\- domain-specific authority integration

\- external proof

\- medical adequacy

\- legal adequacy

\- scientific consensus

\- institutional legitimacy



\---



\## 9. Current Gap



The current gap between Level 6 and Level 7 is:



GFC has a passing local command, but the command is not yet bound to a repository CI workflow.



Until a CI workflow exists and passes, GFC remains Level 6.



\---



\## 10. Anti-Inflation Rule



A local pass must not be described as CI enforcement.



A saved CI readiness document must not be described as CI enforcement.



A workflow draft must not be described as CI enforcement.



A CI workflow file must not be described as CI enforcement until it has run and passed.



A single CI pass must not be described as runtime enforcement.



CI enforcement must not be described as domain authority.



\---



\## 11. Transition Rule



GFC may transition from Level 6 to Level 7 only after:



1\. The CI workflow file exists.

2\. The workflow invokes the accepted top-level local command.

3\. The workflow has run.

4\. The workflow has passed.

5\. The result is recorded.

6\. The maturity registry is updated.

7\. A decision record accepts the transition.



\---



\## 12. Relationship to GFC-0029



GFC-0029 accepted the current top-level local validation command:



tests\\run\_gfc\_all\_local\_pipelines.ps1



This document defines the next boundary:



that command must become CI-invoked before Level 7 can be claimed.



GFC-0029 proves local repeatability.



This document defines CI readiness.



Neither document by itself proves CI enforcement.



\---



\## 13. Future CI Workflow Candidate



A future CI workflow may be:



.github\\workflows\\gfc-local-validation.yml



It may run:



pwsh -File ./tests/run\_gfc\_all\_local\_pipelines.ps1



This workflow should be accepted only after it is created, run, and verified.



\---



\## 14. Future Decision Records



Future CI-related decision records should distinguish:



\- CI readiness

\- CI workflow created

\- CI workflow passed

\- CI enforcement accepted

\- maturity registry updated

\- Level 7 accepted



This avoids collapsing readiness into achievement.



\---



\## 15. Current Status



Draft.



This methodology is ready for acceptance by decision record after it is saved and verified.



\---



Decision Status: DRAFT

