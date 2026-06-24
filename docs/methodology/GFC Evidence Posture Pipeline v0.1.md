\# GFC Evidence Posture Pipeline v0.1



Artifact: GFC Evidence Posture Pipeline v0.1

Version: 0.1

Status: Draft

Methodology Type: Human-Readable Pipeline Methodology

Date: 2026-06-23



\---



\## 1. Purpose



The GFC Evidence Posture Pipeline defines how Governance Field Computing processes declared evidence references into bounded handling postures and persistent report artifacts.



The pipeline exists to prevent semantic validation from being mistaken for external proof.



It allows GFC to say:



A claim, decomposition, or layer assignment has passed the current structural or semantic rules.



It does not allow GFC to say:



The claim is medically, legally, scientifically, institutionally, or externally proven.



Evidence posture handling creates a boundary between internal validation and external support.



\---



\## 2. What the Pipeline Does



The pipeline performs six local steps:



1\. Validates the evidence reference set.

2\. Validates the evidence handling posture registry.

3\. Resolves evidence references to handling postures.

4\. Generates a persistent evidence posture resolution report.

5\. Validates the generated report against the report schema.

6\. Compares the generated report to the manually authored reference report for core semantic equivalence.



The accepted chain is:



evidence reference set



to:



evidence handling posture registry



to:



posture lookup



to:



generated report



to:



schema validation



to:



manual/generated equivalence check



\---



\## 3. Source Artifacts Consumed



The pipeline consumes the following source artifacts.



\### 3.1 Evidence Reference Set



File:



examples\\evidence-reference-set.oral-hygiene.example.json



Purpose:



Defines a set of evidence references attached to a target claim or decomposition element.



The current example includes:



\- pending evidence

\- cited evidence

\- supported evidence



These evidence states are intentionally plural.



The presence of supported evidence does not erase pending or cited limitations.



\### 3.2 Evidence Handling Posture Registry



File:



examples\\evidence-handling-posture.registry.v0.1.json



Purpose:



Maps evidence statuses to handling postures, runtime responses, and recommended next actions.



For example:



pending



maps to:



signal\_incomplete\_evidence



and recommends:



cite\_sources



cited



maps to:



allow\_citation\_reference\_block\_support\_claim



and recommends:



review\_support



supported



maps to:



allow\_scoped\_support\_claim



and recommends:



continue



\---



\## 4. Executable Scripts Used



\### 4.1 Evidence Reference Set Validator



File:



tests\\test\_evidence\_reference\_set\_oral\_hygiene.ps1



Purpose:



Validates that the oral hygiene evidence reference set exists, can be parsed, and contains required fields.



This proves that the evidence reference set is structurally readable.



It does not prove the truth of the evidence.



\---



\### 4.2 Evidence Handling Posture Registry Validator



File:



tests\\test\_evidence\_handling\_posture\_registry.ps1



Purpose:



Validates that the evidence handling posture registry exists, can be parsed, and contains required evidence postures.



This proves that GFC has a machine-readable posture registry.



It does not prove that the posture decisions are externally authoritative.



\---



\### 4.3 Evidence Reference Set With Posture Lookup



File:



tests\\test\_evidence\_reference\_set\_with\_posture.ps1



Purpose:



Validates that evidence references can resolve to handling postures.



This proves that evidence status can be mapped into bounded next action.



It does not prove that the evidence itself is sufficient.



\---



\### 4.4 Evidence Posture Resolution Report Emitter



File:



tests\\emit\_evidence\_posture\_resolution\_report.ps1



Purpose:



Generates:



artifacts\\evidence-posture-resolution-report.generated.v0.1.json



from:



examples\\evidence-reference-set.oral-hygiene.example.json



and:



examples\\evidence-handling-posture.registry.v0.1.json



This moves GFC from manual posture reporting to generated posture reporting.



\---



\### 4.5 Generated Report Validator



File:



tests\\test\_generated\_evidence\_posture\_resolution\_report.ps1



Purpose:



Validates the generated report against expected report shape and required meaning-preserving fields.



This proves that the emitted artifact conforms to the current GFC evidence posture report expectations.



\---



\### 4.6 Manual/Generated Equivalence Comparator



File:



tests\\compare\_manual\_and\_generated\_evidence\_posture\_reports.ps1



Purpose:



Compares:



artifacts\\evidence-posture-resolution-report.v0.1.json



against:



artifacts\\evidence-posture-resolution-report.generated.v0.1.json



This proves core semantic equivalence between the manually authored report and the generated report.



The comparison is not byte-for-byte equivalence.



It is core meaning preservation.



\---



\### 4.7 Full Pipeline Runner



File:



tests\\run\_gfc\_evidence\_posture\_pipeline.ps1



Purpose:



Runs all current evidence posture pipeline steps in sequence.



This is the first complete local pipeline runner for GFC evidence posture handling.



\---



\## 5. Artifacts Emitted



The pipeline emits:



artifacts\\evidence-posture-resolution-report.generated.v0.1.json



This report records:



\- report identity

\- evidence set identity

\- posture registry identity

\- target reference

\- target text

\- resolved evidence references

\- evidence statuses

\- handling postures

\- recommended next actions

\- runtime responses

\- aggregate actions

\- aggregate runtime responses

\- overall resolution

\- anti-inflation note

\- boundary note



\---



\## 6. Schema Used



The generated report is validated against:



schemas\\evidence-posture-resolution-report.schema.json



The schema defines the accepted machine-readable structure for evidence posture resolution reports.



It constrains allowed values for:



\- evidence status

\- handling posture

\- recommended next action

\- friction level

\- runtime response

\- overall resolution



\---



\## 7. Accepted Output



The accepted current pipeline output is:



PASS: GFC evidence posture pipeline completed successfully.

Pipeline Steps: 6

Passed Steps: 6

Evidence Reference Set: examples\\evidence-reference-set.oral-hygiene.example.json

Posture Registry: examples\\evidence-handling-posture.registry.v0.1.json

Generated Report: artifacts\\evidence-posture-resolution-report.generated.v0.1.json

Report Schema: schemas\\evidence-posture-resolution-report.schema.json



Pipeline Chain:

evidence reference set -> posture registry -> posture lookup -> generated report -> schema validation -> equivalence check



\---



\## 8. Boundary Preserved



The pipeline preserves the distinction between:



\- semantic validation

\- evidence status

\- evidence handling posture

\- evidence support

\- external proof

\- runtime response

\- institutional warrant



The pipeline does not collapse these into one category.



A decomposition may pass semantic validation while still having pending, cited, insufficient, stale, contested, or superseded evidence.



This prevents premature warrant inflation.



\---



\## 9. What the Pipeline Does Not Prove



The current pipeline does not prove:



\- that the oral hygiene claim is medically true

\- that the source evidence is real

\- that the source evidence is authoritative

\- that the source evidence is fresh

\- that a citation supports the claim

\- that a supported claim is universally true

\- that the current rules apply across all domains

\- that a live runtime will enforce the posture

\- that an institution would accept the claim



The pipeline proves only that declared evidence states can be processed into bounded GFC handling postures.



\---



\## 10. Why This Matters



Governance Field Computing needs a disciplined way to handle claims that may be structurally valid but not externally warranted.



Without evidence posture handling, a system could mistake internal coherence for truth.



The evidence posture pipeline creates a middle layer between:



the system can parse this



and:



the world supports this



That middle layer is necessary for intelligent systems that operate near medicine, law, education, science, infrastructure, public health, governance, or institutional decision-making.



\---



\## 11. How to Run Locally



From the repository root:



```powershell

.\\tests\\run\_gfc\_evidence\_posture\_pipeline.ps1


12. Accepted Limitations

The current pipeline is local and file-based.

It does not yet include:

GitHub Actions execution
CI enforcement
automatic commit gating
source citation validation
source authority scoring
source freshness scoring
conflict resolution
domain-specific evidence rules
multi-domain evidence bundles
user interface integration
agent runtime enforcement

These limitations are accepted for v0.1.

13. Future CI and Runtime Integration

Future CI integration may add:

automatic pipeline execution on pull request
failure blocking for malformed evidence artifacts
generated report diffs
schema validation gates
artifact upload
status checks
release packaging

Future runtime integration may add:

evidence posture lookup during agent response
warning generation
claim blocking
support-review routing
citation collection
conflict escalation
stale evidence renewal
superseded evidence retirement
domain-specific posture policy

These future additions must preserve the current anti-inflation boundary.

14. Current Status

Draft.

This methodology is ready for acceptance by decision record after it is saved and verified.