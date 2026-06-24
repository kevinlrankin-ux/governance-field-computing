\# GFC Evidence Boundary Principles v0.1



Artifact: GFC Evidence Boundary Principles v0.1

Version: 0.1

Status: Draft

Methodology Type: Boundary Principles

Date: 2026-06-23



\---



\## 1. Purpose



The GFC Evidence Boundary Principles define the stable rules that govern how Governance Field Computing handles evidence, support, warrant, and proof boundaries.



These principles sit above the local evidence posture pipeline.



They are intended to prevent GFC from confusing internal validation with external authority.



The principles apply whenever GFC evaluates, validates, emits, reports, or routes claims that may touch medical, legal, scientific, educational, institutional, public-health, governance, infrastructure, or safety-sensitive domains.



\---



\## 2. Core Boundary Statement



GFC may validate structure.



GFC may validate declared semantic fit.



GFC may validate evidence posture.



GFC may validate whether an evidence bundle resolves to a handling posture.



GFC may not treat any of those validations as external proof.



Evidence boundary discipline exists because intelligent systems can appear legitimate before they are warranted.



\---



\## 3. Principle 1 — Semantic Validation Is Not Proof



A semantic validation result means that a claim, decomposition, layer assignment, or artifact conforms to the current declared semantic rules.



It does not mean the claim is true.



It does not mean the claim is medically, scientifically, legally, institutionally, or externally proven.



Semantic validation answers:



Does this fit the current declared rule set?



It does not answer:



Is this externally warranted?



Boundary rule:



Semantic validation must not be inflated into proof.



\---



\## 4. Principle 2 — Citation Presence Is Not Support



A citation or source reference may show that a source has been attached.



It does not automatically show that the source supports the claim.



Citation presence answers:



Has a source reference been recorded?



It does not answer:



Does the source actually support the claim?



Boundary rule:



Cited evidence must remain distinct from supported evidence.



\---



\## 5. Principle 3 — Support Is Scope-Bound



Supported evidence may allow a scoped support claim only within declared boundaries.



Those boundaries may include:



\- domain

\- source phrase

\- rule set

\- target claim

\- target decomposition

\- time period

\- review scope

\- source type

\- source authority

\- intended use



Supported evidence does not become universal truth.



Boundary rule:



Support must travel with scope.



\---



\## 6. Principle 4 — Stronger Evidence Does Not Erase Weaker Evidence Records



An evidence bundle may contain pending, cited, supported, contested, stale, missing, insufficient, or superseded records at the same time.



The presence of stronger evidence does not erase weaker evidence records.



A supported reference may allow scoped continuation.



It does not delete the fact that other references may still require citation, review, renewal, conflict resolution, or retirement.



Boundary rule:



Evidence status plurality must be preserved.



\---



\## 7. Principle 5 — Missing Evidence Is Not Disproof



Missing evidence means that evidence has not been supplied or attached.



It does not automatically mean the claim is false.



Missing evidence creates a support gap.



It may block support claims.



It may require source collection.



But it is not the same as disproof.



Boundary rule:



Missing evidence blocks support inflation without pretending to settle truth.



\---



\## 8. Principle 6 — Stale Evidence Is Not Erased Evidence



Stale evidence may no longer be current enough to govern present support claims.



It remains auditable.



It may require renewal.



It may require updated review.



It may require a freshness check.



It should not simply disappear from the evidence history.



Boundary rule:



Stale evidence loses current authority before it loses audit value.



\---



\## 9. Principle 7 — Superseded Evidence Remains Auditable



Superseded evidence has been replaced by newer evidence, a newer source, a revised rule, or a changed decision context.



Superseded evidence should not govern current support when newer controlling evidence exists.



However, it remains part of the audit trail.



Boundary rule:



Superseded evidence is retired from current authority, not erased from history.



\---



\## 10. Principle 8 — Runtime Posture Is Not Institutional Authority



A runtime posture may determine how GFC should respond to an evidence state.



For example, a runtime posture may say:



\- continue

\- cite sources

\- review support

\- resolve conflict

\- renew stale evidence

\- block support claim

\- retire superseded evidence



This is system behavior.



It is not institutional authority.



Boundary rule:



Runtime posture governs GFC handling, not external legitimacy.



\---



\## 11. Principle 9 — Domain Rules Must Be Declared Before Domain Claims Are Expanded



GFC must not silently generalize a rule from one domain into another.



A rule created for an oral hygiene example does not automatically apply to medicine broadly.



A rule created for education does not automatically apply to law.



A rule created for governance language does not automatically apply to public health.



Boundary rule:



Domain expansion requires declared domain rules.



\---



\## 12. Principle 10 — Anti-Inflation Language Must Travel With Generated Artifacts



Generated artifacts must preserve boundary language when there is risk of warrant inflation.



This includes reports, schemas, runtime outputs, methodology documents, and future CI or agent outputs.



Anti-inflation language should clarify what was validated and what was not proven.



Boundary rule:



Generated artifacts must carry their own proof boundary.



\---



\## 13. Principle 11 — Evidence Status Is Not Evidence Quality



Evidence status records how evidence is currently positioned in GFC.



It does not automatically score quality.



For example:



pending



does not mean low quality.



cited



does not mean high quality.



supported



does not mean universally sufficient.



stale



does not mean false.



superseded



does not mean useless.



Boundary rule:



Evidence status and evidence quality must remain distinct unless a quality-scoring layer is explicitly added.



\---



\## 14. Principle 12 — Evidence Handling Must Preserve Review Pathways



Evidence posture should not merely accept or reject.



It should preserve pathways for:



\- citation collection

\- support review

\- conflict review

\- renewal review

\- source replacement

\- domain review

\- retirement from authority

\- audit preservation



Boundary rule:



A mature evidence system routes uncertainty instead of collapsing it.



\---



\## 15. Principle 13 — Local Validation Is Not Live Enforcement



A local pipeline can prove that scripts run and artifacts validate.



It does not prove that a live runtime will enforce those rules.



Runtime enforcement requires additional integration.



Boundary rule:



Local validation may prepare runtime behavior, but must not claim runtime enforcement prematurely.



\---



\## 16. Principle 14 — Placeholder Sources Must Remain Marked



Placeholder sources may be used for structure, schema, and pipeline development.



They must not be treated as real external support.



A placeholder-supported example may validate mechanics.



It does not validate the external claim.



Boundary rule:



Placeholder evidence must remain visibly bounded.



\---



\## 17. Principle 15 — Evidence Boundary Failures Must Be Visible



When GFC cannot determine support, freshness, authority, conflict, or domain fit, the uncertainty should be surfaced.



The system should avoid hiding uncertainty behind clean output.



Boundary rule:



Uncertainty must remain visible where it affects warrant.



\---



\## 18. Relationship to the Evidence Posture Pipeline



These principles govern the evidence posture pipeline accepted in:



docs\\decisions\\GFC-0019-Local-Evidence-Posture-Pipeline-Accepted.md



and documented in:



docs\\methodology\\GFC Evidence Posture Pipeline v0.1.md



The pipeline is the executable local chain.



These principles are the boundary grammar above that chain.



\---



\## 19. Relationship to Vendor-Derived Inputs



Vendor-derived repositories may inform future GFC concepts.



However, vendor-derived concepts are not imported into GFC unless accepted through GFC decision records.



This preserves the boundary between:



candidate influence



and:



accepted GFC methodology



Boundary rule:



Vendor scan does not equal adoption.



\---



\## 20. Current Accepted Principles



The current evidence boundary principles are:



1\. Semantic validation is not proof.

2\. Citation presence is not support.

3\. Support is scope-bound.

4\. Stronger evidence does not erase weaker evidence records.

5\. Missing evidence is not disproof.

6\. Stale evidence is not erased evidence.

7\. Superseded evidence remains auditable.

8\. Runtime posture is not institutional authority.

9\. Domain rules must be declared before domain claims are expanded.

10\. Anti-inflation language must travel with generated artifacts.

11\. Evidence status is not evidence quality.

12\. Evidence handling must preserve review pathways.

13\. Local validation is not live enforcement.

14\. Placeholder sources must remain marked.

15\. Evidence boundary failures must be visible.



\---



\## 21. Current Limitations



This methodology defines principles only.



It does not yet define:



\- source authority scoring

\- freshness scoring

\- domain-specific evidence thresholds

\- institutional review criteria

\- legal adequacy

\- medical sufficiency

\- scientific consensus handling

\- conflict adjudication

\- CI enforcement

\- runtime enforcement

\- user-facing warning copy



These limitations are accepted for v0.1.



\---



\## 22. Current Status



Draft.



This methodology is ready for acceptance by decision record after it is saved and verified.



\---



Status: DRAFT

