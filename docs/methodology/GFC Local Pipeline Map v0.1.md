\# GFC Local Pipeline Map v0.1



Artifact: GFC Local Pipeline Map v0.1

Version: 0.1

Status: Draft

Methodology Type: Local Pipeline Architecture Map

Date: 2026-06-23



\---



\## 1. Purpose



The GFC Local Pipeline Map documents the current executable validation architecture of Governance Field Computing.



It maps the two accepted local validation chains:



1\. Evidence Posture Pipeline

2\. Boundary Principles Pipeline



The purpose of this map is to show how the pipelines relate, where they overlap, what each one proves, and what neither one proves.



\---



\## 2. Current Local Pipeline Architecture



GFC currently has two accepted local validation chains.



The first chain processes evidence posture.



The second chain preserves boundary discipline.



Together they create the first local architecture for bounded evidence handling.



\---



\## 3. Pipeline 1 — Evidence Posture Pipeline



Accepted by:



docs\\decisions\\GFC-0019-Local-Evidence-Posture-Pipeline-Accepted.md



Methodology:



docs\\methodology\\GFC Evidence Posture Pipeline v0.1.md



Pipeline runner:



tests\\run\_gfc\_evidence\_posture\_pipeline.ps1



Accepted chain:



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



\## 4. Evidence Posture Pipeline Files



The Evidence Posture Pipeline uses:



tests\\run\_gfc\_evidence\_posture\_pipeline.ps1



tests\\test\_evidence\_reference\_set\_oral\_hygiene.ps1



tests\\test\_evidence\_handling\_posture\_registry.ps1



tests\\test\_evidence\_reference\_set\_with\_posture.ps1



tests\\emit\_evidence\_posture\_resolution\_report.ps1



tests\\test\_generated\_evidence\_posture\_resolution\_report.ps1



tests\\compare\_manual\_and\_generated\_evidence\_posture\_reports.ps1



examples\\evidence-reference-set.oral-hygiene.example.json



examples\\evidence-handling-posture.registry.v0.1.json



artifacts\\evidence-posture-resolution-report.generated.v0.1.json



schemas\\evidence-posture-resolution-report.schema.json



\---



\## 5. What the Evidence Posture Pipeline Proves



The Evidence Posture Pipeline proves that GFC can:



1\. Validate an evidence reference set.

2\. Validate an evidence handling posture registry.

3\. Resolve declared evidence references to handling postures.

4\. Generate a persistent evidence posture resolution report.

5\. Validate the generated report against a schema.

6\. Compare generated output with a manually authored reference report.

7\. Preserve evidence status plurality.

8\. Preserve aggregate recommended actions.

9\. Preserve aggregate runtime responses.

10\. Preserve the distinction between semantic validation and external proof.



\---



\## 6. Pipeline 2 — Boundary Principles Pipeline



Accepted by:



docs\\decisions\\GFC-0023-Local-Boundary-Principles-Pipeline-Accepted.md



Methodology:



docs\\methodology\\GFC Evidence Boundary Principles v0.1.md



Pipeline runner:



tests\\run\_gfc\_boundary\_pipeline.ps1



Accepted chain:



boundary methodology



to:



decision record



to:



schema



to:



registry



to:



registry validation



\---



\## 7. Boundary Principles Pipeline Files



The Boundary Principles Pipeline uses:



tests\\run\_gfc\_boundary\_pipeline.ps1



tests\\test\_evidence\_boundary\_principles\_registry.ps1



docs\\methodology\\GFC Evidence Boundary Principles v0.1.md



docs\\decisions\\GFC-0021-Evidence-Boundary-Principles-Accepted.md



schemas\\evidence-boundary-principles.schema.json



examples\\evidence-boundary-principles.registry.v0.1.json



docs\\decisions\\GFC-0022-Evidence-Boundary-Principles-Registry-Accepted.md



\---



\## 8. What the Boundary Principles Pipeline Proves



The Boundary Principles Pipeline proves that GFC can:



1\. Confirm the evidence boundary methodology exists.

2\. Confirm the accepting decision record exists.

3\. Confirm the boundary-principles schema exists.

4\. Confirm the boundary-principles registry exists.

5\. Confirm the registry validator exists.

6\. Validate that 15 accepted boundary principles are present.

7\. Validate required principle names.

8\. Validate anti-inflation language.

9\. Validate the vendor no-import boundary.

10\. Preserve boundary principles in machine-readable form.



\---



\## 9. How the Two Pipelines Relate



The Evidence Posture Pipeline answers:



Can GFC process evidence states into bounded handling postures and generated reports?



The Boundary Principles Pipeline answers:



Can GFC preserve the principles that prevent those evidence states from being inflated into proof?



The first pipeline performs evidence posture work.



The second pipeline governs the boundary discipline around that work.



\---



\## 10. Overlap Between the Pipelines



Both pipelines preserve anti-inflation boundaries.



Both pipelines depend on methodology documents.



Both pipelines rely on decision records.



Both pipelines use schemas.



Both pipelines use machine-readable examples or registries.



Both pipelines have validators.



Both pipelines are local, file-based, and repeatable.



Both pipelines prepare future CI and runtime behavior without claiming live enforcement.



\---



\## 11. What Neither Pipeline Proves



Neither pipeline proves:



\- medical truth

\- legal sufficiency

\- scientific consensus

\- institutional authority

\- public-health authority

\- source authenticity

\- source authority

\- source freshness

\- source relevance

\- external claim support

\- live runtime enforcement

\- CI enforcement

\- user-interface behavior

\- agent behavior



Both pipelines validate GFC-local structure and boundary discipline only.



\---



\## 12. Current Executable Validation Architecture



Current architecture:



Evidence posture validation:



evidence reference set -> posture registry -> posture lookup -> generated report -> schema validation -> equivalence check



Boundary principles validation:



boundary methodology -> decision record -> schema -> registry -> registry validation



Combined interpretation:



evidence posture validation tells GFC what the evidence state resolves to.



boundary principles validation tells GFC what not to claim from that resolution.



\---



\## 13. Current Maturity Level



Current maturity:



local



file-based



repeatable



schema-aware



methodology-backed



decision-record-backed



boundary-aware



Current maturity is not yet:



CI-enforced



runtime-enforced



release-packaged



source-authority-aware



freshness-aware



domain-authority-aware



institutionally reviewed



\---



\## 14. Future Integration Path



Future GFC work may combine the two pipelines into a unified local validation command.



Future CI work may run both pipelines automatically.



Future runtime work may use both pipelines to:



\- validate evidence state

\- retrieve boundary principles

\- generate warnings

\- block unsupported support claims

\- route support review

\- preserve evidence plurality

\- prevent proof inflation

\- preserve vendor no-import boundaries



Future integration must preserve the distinction between local validation and live enforcement.



\---



\## 15. Current Status



Draft.



This local pipeline map is ready for acceptance by decision record after it is saved and verified.



\---



Status: DRAFT

