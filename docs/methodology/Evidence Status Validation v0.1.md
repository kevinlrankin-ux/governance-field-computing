\# Evidence Status Validation v0.1



Artifact: Evidence Status Validation

Version: 0.1

Status: Draft

Purpose: Define how Governance Field Computing records, distinguishes, and validates evidence status before claiming that a decomposition is medically, legally, scientifically, institutionally, or otherwise supported.

Depends On: Vendor Scan Evidence Status Inputs v0.1; GFC-0008 — Human-Readable Semantic Validation Report Accepted

Required By: evidence-status.schema.json; future evidence validators; future semantic validation upgrades

Evidence Level: Methodology / Requires implementation testing

Date: 2026-06-23



\---



\## 1. Purpose



Governance Field Computing currently validates whether a layer assignment belongs under a domain-bound rule set.



That is semantic validation.



Evidence-status validation is different.



Evidence-status validation asks:



What kind of support, citation, challenge, freshness, weakness, or insufficiency attaches to the claim?



A semantic assignment may be valid under the current rule set while still being evidence-pending.



A semantic assignment may be cited but still invalid within the current taxonomy.



\---



\## 2. Core Rule



Evidence is not the same as:



\- conclusion

\- interpretation

\- policy

\- semantic validity

\- legitimacy

\- authority

\- confidence language



In GFC, evidence is a bounded, inspectable basis attached to a claim, assignment, rule, interpretation, or review result.



Evidence may support meaning.



Evidence does not automatically settle meaning.



\---



\## 3. Adopted Evidence Statuses



GFC adopts the following initial evidence statuses:



1\. pending

2\. cited

3\. supported

4\. contested

5\. insufficient

6\. missing

7\. stale

8\. superseded



These statuses are GFC-native.



They are informed by vendor sources but not imported wholesale.



\---



\## 4. Evidence Status Definitions



\### pending



Definition:



Evidence has not yet been fully gathered, cited, reviewed, or attached.



Use when:



\- a claim is plausible but not yet sourced

\- a rule exists but supporting evidence has not been attached

\- evidence review is planned but incomplete



Example:



The current oral hygiene decomposition may be semantically valid under the rule set, but its dental/public-health evidence remains pending.



\---



\### cited



Definition:



An evidence source has been identified and attached, but the system has not yet determined whether it sufficiently supports the claim.



Use when:



\- a citation exists

\- a source is linked

\- the source has not yet been evaluated for sufficiency



Important:



Cited does not mean supported.



\---



\### supported



Definition:



Evidence has been reviewed and currently supports the claim within the declared domain, scope, and rule set.



Use when:



\- source relevance is established

\- source quality is acceptable for the current purpose

\- the evidence supports the specific claim being made

\- limitations are recorded



Important:



Supported does not mean universally true.



\---



\### contested



Definition:



Evidence is challenged, contradicted, disputed, or in tension with other evidence.



Use when:



\- sources disagree

\- a reviewer disputes interpretation

\- counterevidence exists

\- claim support depends on unresolved assumptions



Important:



Contested does not automatically mean false.



It means the claim cannot be treated as cleanly supported.



\---



\### insufficient



Definition:



Available evidence does not provide enough support for the claim.



Use when:



\- evidence is too weak

\- evidence is too general

\- evidence does not apply to the declared domain

\- evidence supports a nearby claim but not this one

\- evidence lacks necessary specificity



Important:



Insufficient is stronger than pending.



Pending means evidence has not been fully reviewed.



Insufficient means the reviewed or available evidence does not support the claim enough.



\---



\### missing



Definition:



Expected evidence is absent.



Use when:



\- no source is available

\- a required citation is absent

\- a key support artifact cannot be found

\- the claim depends on evidence that has not been supplied



Important:



Missing evidence should remain visible.



It must not be hidden by confidence language.



\---



\### stale



Definition:



Evidence may once have been useful but may no longer be current enough for the claim.



Use when:



\- evidence has expired

\- policy changed

\- scientific understanding changed

\- system version changed

\- model, prompt, route, or retrieval basis changed

\- domain conditions changed



Important:



Stale evidence may require renewal before reuse.



\---



\### superseded



Definition:



Evidence has been replaced by later evidence, a newer source, a revised rule set, or a later decision record.



Use when:



\- a newer source supersedes an older source

\- a rule set changes

\- a decision record retires a prior claim

\- a versioned system changes enough that prior evidence no longer controls



Important:



Superseded evidence should remain auditable, but it should not govern current validation.



\---



\## 5. Evidence Families



Future GFC evidence records may classify evidence by family.



Initial candidate families:



\- observational

\- historical

\- comparative

\- model\_derived

\- human\_reported

\- policy\_or\_rule

\- provenance

\- negative\_or\_missing

\- structural



These families are not yet required for all evidence records.



They are available for future schema expansion.



\---



\## 6. Evidence Roles



Future GFC evidence records may classify evidence by role.



Initial candidate roles:



\- support

\- limitation

\- conflict

\- renewal

\- boundary

\- stewardship

\- audit



These roles help explain what evidence is doing.



Example:



One source may support a claim.



Another source may limit the claim.



Another may contest it.



Another may trigger renewal because it is stale.



\---



\## 7. Relationship to Semantic Validation



Semantic validation asks:



Does the assigned value belong in the assigned layer under the current domain-bound rule set?



Evidence-status validation asks:



What is the evidence condition attached to that assignment or rule?



Examples:



\### Semantically valid but evidence pending



driver = bacteria



Semantic result:



pass



Evidence status:



pending



Meaning:



The assignment belongs under the current rule set, but formal evidence citations are not yet attached.



\---



\### Cited but semantically invalid



first\_principle = dentists



Semantic result:



invalid\_within\_current\_taxonomy



Evidence status:



cited



Meaning:



A source may establish that dentists exist or provide dental guidance, but that does not make dentists a first principle in this decomposition.



\---



\### Supported but scope-limited



pressure = harmful accumulation can increase risk of decay, disease, odor, or damage



Semantic result:



pass



Evidence status:



supported



Scope:



oral hygiene domain only



Meaning:



Evidence may support this pressure in oral hygiene, but it does not automatically generalize to other domains.



\---



\## 8. Evidence Boundary Rules



\### Rule 1 — Evidence is not conclusion



Evidence may support a conclusion, but it is not identical to the conclusion.



\---



\### Rule 2 — Citation is not support



A citation only proves that a source has been identified.



It does not prove that the source supports the claim.



\---



\### Rule 3 — Support is scope-bound



Supported means supported within the declared scope.



It does not mean universally true.



\---



\### Rule 4 — Missing evidence must remain visible



Missing evidence must not be hidden by confident language.



\---



\### Rule 5 — Stale evidence requires renewal review



If evidence may be stale, it must be reviewed before being reused.



\---



\### Rule 6 — Superseded evidence remains auditable



Superseded evidence should remain visible for audit, but it should not control current validation.



\---



\## 9. Minimum Evidence Record Fields



Future evidence records should eventually include:



\- evidence\_id

\- evidence\_status

\- evidence\_family

\- evidence\_role

\- evidence\_source

\- source\_type

\- evidence\_scope

\- supports\_claim

\- limits\_claim

\- conflict\_note

\- weakness\_note

\- freshness\_note

\- issued\_at

\- expires\_at

\- reviewed\_at

\- reviewer\_note



Not every early artifact must include every field.



The schema should support disciplined growth.



\---



\## 10. Current Application to GFC



Current structured semantic validation output uses:



evidence\_status = pending



This is correct for the current phase.



Reason:



The current validator has proven semantic-rule behavior, not evidence support.



The oral hygiene example is not yet fully cited, reviewed, or evidence-scored.



\---



\## 11. Anti-Inflation Note



Evidence-status validation must not be inflated into legitimacy.



Supported evidence does not automatically mean:



\- the phrase is legitimate

\- the governance rule is optimal

\- the action should be prescribed

\- the domain rule is final

\- the conclusion is universally true



Evidence status only describes the current evidence condition attached to a claim or assignment.



\---



\## 12. Adaptive / Versioned Evidence Note



Evidence may decay when systems change.



Future GFC work should account for versioned evidence when:



\- a system updates

\- a model is retrained

\- a policy changes

\- a legal standard changes

\- a scientific consensus changes

\- a retrieval corpus changes

\- a governance phrase is applied to a new domain



This is especially relevant for intelligent and adaptive systems.



\---



\## 13. Current Status



Draft.



This methodology is ready for first schema implementation.



\---



\## 14. Next Approved Build



Create:



schemas\\evidence-status.schema.json



Purpose:



Make evidence statuses machine-readable and testable.



Then update future semantic validation output so evidence\_status values conform to the evidence-status schema.



\---



Status: DRAFT

