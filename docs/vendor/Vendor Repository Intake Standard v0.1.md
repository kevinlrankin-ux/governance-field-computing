\# Vendor Repository Intake Standard v0.1



Artifact: Vendor Repository Intake Standard

Version: 0.1

Status: Active

Purpose: Define how external or adjacent repositories may inform Governance Field Computing without causing uncontrolled import, drift, or accidental modification.

Depends On: GFC-0001 — First Validated Artifact

Required By: Future vendor review, concept extraction, schema comparison, and repository integration decisions.

Evidence Level: Repository governance rule

Date: 2026-06-23



\---



\## 1. Core Rule



All non-GFC repositories are treated as vendor repositories unless explicitly reclassified by a Governance Field Computing decision record.



Vendor repositories may be studied, indexed, cited, and compared.



Vendor repositories must not be modified as part of Governance Field Computing work.



\---



\## 2. Current Vendor Repositories



The following repositories are currently classified as vendor repositories:



1\. kevinlrankin-ux/Context-Collapsed-Key-Management-CCKM

2\. kevinlrankin-ux/ccbp-governance-adapter

3\. kevinlrankin-ux/constitutional-language-protocol

4\. kevinlrankin-ux/consciousness-capability-boundary-project

5\. kevinlrankin-ux/-legitimacy-and-warrant-sandbox



\---



\## 3. Vendor Boundary



Governance Field Computing may extract:



\- Definitions

\- Patterns

\- Protocol ideas

\- Schema designs

\- Test strategies

\- Constitutional language concepts

\- Governance adapter concepts

\- Warrant / legitimacy models

\- Drift-control methods



Governance Field Computing must not automatically inherit:



\- File structure

\- Terminology

\- Claims

\- Authority

\- Assumptions

\- Runtime behavior

\- Licensing meaning

\- Constitutional commitments

\- Decision records



Everything imported from a vendor repo must pass through GFC review.



\---



\## 4. Intake Workflow



Vendor material must follow this sequence:



1\. Identify source repository.

2\. Identify source file.

3\. Extract candidate concept.

4\. Classify candidate concept.

5\. Mark evidence level.

6\. Compare against existing GFC definitions.

7\. Record conflicts or overlaps.

8\. Decide whether to:

&#x20;  - reject

&#x20;  - defer

&#x20;  - reference only

&#x20;  - adapt

&#x20;  - promote into GFC



No vendor concept becomes part of Governance Field Computing until accepted by a decision record.



\---



\## 5. Intake Classifications



Each candidate concept must be classified as one of:



\- Reference Only

\- Concept Candidate

\- Schema Candidate

\- Test Candidate

\- Methodology Candidate

\- Terminology Candidate

\- Conflict Candidate

\- Integration Candidate



\---



\## 6. Evidence Levels



Each vendor-derived concept must be marked as:



\- observed

\- supported

\- tested

\- validated

\- accepted

\- rejected

\- deferred



\---



\## 7. Drift Protection



Vendor repositories may contain useful material, but they may also contain unresolved experiments, older language, abandoned paths, or project-specific assumptions.



Governance Field Computing must preserve its own definitions unless a later GFC decision record explicitly supersedes them.



\---



\## 8. Modification Rule



Governance Field Computing work must not modify vendor repositories.



Permitted actions:



\- inspect

\- read

\- summarize

\- compare

\- extract candidate concepts

\- create local notes inside the GFC repository



Prohibited actions:



\- editing vendor files

\- committing to vendor repositories

\- rewriting vendor history

\- treating vendor repo content as automatically authoritative

\- merging vendor repo content without decision review



\---



\## 9. Local Import Rule



If vendor material is brought into the GFC repository, it must be placed under:



docs/vendor/



or another explicitly approved GFC path.



The original vendor source must be recorded.



\---



\## 10. Decision Requirement



Any vendor-derived material that changes GFC definitions, schemas, tests, or methodology requires a decision record under:



docs/decisions/



\---



\## 11. Current Status



This standard is active immediately.



All listed repositories remain vendor repositories until reclassified by a future Governance Field Computing decision record.

