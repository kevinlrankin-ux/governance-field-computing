\# VENDOR-005 Candidate Concepts v0.1



Artifact: VENDOR-005 Candidate Concepts

Version: 0.1

Status: Draft

Purpose: Identify candidate concepts from legitimacy-and-warrant-sandbox that may later inform Governance Field Computing semantic validation.

Depends On: Vendor Repository Intake Standard v0.1; Vendor Repository Index v0.1; Vendor Scan VENDOR-005 legitimacy-and-warrant-sandbox v0.1

Required By: Future semantic validation, bounded warrant design, domain-bounded layer assignment, and category-drift rejection.

Evidence Level: Vendor-derived candidate list / not imported

Date: 2026-06-23



\---



\## 1. Vendor Source



Repository:



kevinlrankin-ux/-legitimacy-and-warrant-sandbox



Vendor ID:



VENDOR-005



Source Classification:



Reference Only



Import Status:



Not Imported



Modification Status:



No vendor files modified



\---



\## 2. Core Rule



This document identifies candidate concepts only.



No concept listed here is accepted into Governance Field Computing until a separate GFC decision record explicitly accepts, adapts, rejects, defers, or promotes it.



\---



\## 3. Why This Vendor Source Matters



Governance Field Computing is currently moving from structural validation toward semantic validation.



Structural validation asks:



Does the file exist, parse, and contain required fields?



Semantic validation asks:



Do the field values belong in the assigned layers?



The legitimacy-and-warrant-sandbox repository is relevant because it already works with bounded trust, warrant, legitimacy, review depth, evidence, provenance, domain boundaries, and drift feedback.



However, it remains a vendor repository.



Its concepts may inform GFC, but they do not control GFC.



\---



\## 4. Candidate Concept Table



| ID | Candidate Concept | Possible GFC Use | Risk | Current Status |

|---|---|---|---|---|

| LW-CAND-001 | Bounded Warrant | Help GFC avoid claiming universal truth when validating layer assignments | May understate cases where strong rejection is appropriate | Candidate |

| LW-CAND-002 | Source-Neutral Review | Ensure all decompositions are reviewed by the same rules regardless of origin | May ignore source-specific reliability when evidence quality matters | Candidate |

| LW-CAND-003 | Embedded Proposition Extraction | Treat governance phrases as containing claims that must be separately inspected | May overcomplicate early examples | Candidate |

| LW-CAND-004 | Tiered Review Depth | Route simple cases through lightweight review and ambiguous cases through deeper review | May add runtime complexity too early | Candidate |

| LW-CAND-005 | Domain-Bounded Legitimacy | Recognize that a layer assignment may be valid in one domain and invalid in another | Could weaken layer definitions if applied too loosely | High-Priority Candidate |

| LW-CAND-006 | Legitimacy as Standing, Not Sovereignty | Prevent semantic validation from becoming absolute authority | Strong fit with GFC boundaries | High-Priority Candidate |

| LW-CAND-007 | Anti-Inflation | Prevent a bounded result from expanding into broader authority | Strong fit with category-drift prevention | High-Priority Candidate |

| LW-CAND-008 | Anti-Boxing | Prevent current taxonomies from being treated as final maps | Useful for long-term adaptability | Candidate |

| LW-CAND-009 | Incident and Drift Feedback | Treat repeated failed decompositions as evidence for improving rules | Strong fit with adversarial testing | High-Priority Candidate |

| LW-CAND-010 | Review Route Assignment | Help decide when semantic validation should escalate to deeper review | Useful later, but may be premature | Candidate |

| LW-CAND-011 | Proportionate Response Envelope | Allow validators to produce bounded outputs instead of binary overclaims | Strong fit with semantic validation | Candidate |

| LW-CAND-012 | Evidence-First Reflective Rule | Preserve GFC’s existing build discipline | Already aligned with current practice | High-Priority Candidate |



\---



\## 5. Candidate Details



\### LW-CAND-001 — Bounded Warrant



Potential GFC Use:



GFC can use bounded warrant to avoid overclaiming.



A semantic validator should not immediately claim:



"This is universally true."



Instead, it may claim:



"This assignment is warranted within this example and this domain."



Candidate Benefit:



Supports disciplined semantic validation.



Risk:



If applied too weakly, GFC may hesitate to reject clearly invalid layer assignments.



Example:



In the invalid fixture:



driver: time



first\_principle: dentists



GFC should eventually reject the assignment, not merely say it is uncertain.



Required Before Adoption:



Define validation result levels.



Possible result levels:



\- pass

\- fail

\- needs evidence

\- needs domain review

\- unsupported

\- invalid within current taxonomy



Current Status:



Candidate only.



\---



\### LW-CAND-002 — Source-Neutral Review



Potential GFC Use:



All decompositions should be evaluated by the same GFC validation rules regardless of who created them.



Candidate Benefit:



Prevents prestige-based acceptance.



Risk:



Source reliability may still matter in evidence review.



Required Before Adoption:



Separate source neutrality from evidence quality.



Current Status:



Candidate only.



\---



\### LW-CAND-003 — Embedded Proposition Extraction



Potential GFC Use:



A governance phrase may contain embedded propositions.



Example:



"Brush your teeth twice a day"



contains or implies propositions such as:



\- teeth can accumulate harmful material

\- brushing can reduce harmful accumulation

\- daily repetition matters

\- twice daily is an appropriate public-health compression



Candidate Benefit:



Helps GFC separate the governance phrase from the claims supporting it.



Risk:



May add too much complexity before the first semantic validator exists.



Required Before Adoption:



Test against one simple phrase and one legal phrase.



Current Status:



Candidate only.



\---



\### LW-CAND-004 — Tiered Review Depth



Potential GFC Use:



Not every decomposition should require the same level of review.



Simple cases may need lightweight validation.



Ambiguous, high-stakes, cross-domain, or novel cases may require deeper review.



Candidate Benefit:



Preserves computational efficiency.



Risk:



Premature runtime complexity.



Required Before Adoption:



Define review triggers.



Possible triggers:



\- ambiguity

\- novelty

\- consequence severity

\- cross-domain transfer

\- evidence conflict

\- category-drift risk



Current Status:



Candidate only.



\---



\### LW-CAND-005 — Domain-Bounded Legitimacy



Potential GFC Use:



A layer assignment may be valid in one domain but invalid in another.



Example:



"bacteria" may be a valid driver in oral hygiene.



"bacteria" may not be the relevant driver in a constitutional due-process analysis unless the case itself involves biological contamination, health regulation, or a related domain.



Candidate Benefit:



Directly supports semantic validation.



Risk:



Could weaken core layer definitions if every invalid assignment is excused as "domain dependent."



Required Before Adoption:



Define domain-bounded semantic validity.



Possible GFC rule:



A layer assignment is valid only relative to a declared domain, phrase, and decomposition purpose.



Current Status:



High-priority candidate.



\---



\### LW-CAND-006 — Legitimacy as Standing, Not Sovereignty



Potential GFC Use:



A semantic validator may grant a decomposition standing without treating it as final truth.



Example:



A decomposition may be accepted as:



\- structurally valid

\- semantically plausible

\- evidence pending

\- accepted for current example

\- not yet generalized



Candidate Benefit:



Prevents semantic validation from becoming overconfident.



Risk:



Requires careful output language.



Required Before Adoption:



Define GFC standing levels.



Possible standing levels:



\- candidate

\- structurally valid

\- semantically plausible

\- warranted

\- accepted

\- rejected

\- superseded



Current Status:



High-priority candidate.



\---



\### LW-CAND-007 — Anti-Inflation



Potential GFC Use:



Prevent a narrow validation result from expanding beyond its scope.



Example:



If GFC validates:



"bacteria is a driver for the oral hygiene phrase"



that must not inflate into:



"bacteria is always a driver"



or:



"all biological drivers behave like bacteria"



Candidate Benefit:



Strong protection against category drift.



Risk:



Low.



Required Before Adoption:



Add scope notes to semantic validation results.



Current Status:



High-priority candidate.



\---



\### LW-CAND-008 — Anti-Boxing



Potential GFC Use:



Prevent early layer taxonomies from becoming final maps.



Candidate Benefit:



Supports long-term discovery.



Risk:



May be used to avoid necessary definitions.



Required Before Adoption:



Define how GFC can revise schemas without dissolving discipline.



Current Status:



Candidate only.



\---



\### LW-CAND-009 — Incident and Drift Feedback



Potential GFC Use:



Failed decompositions should become evidence.



Example:



The invalid fixture:



driver: time

pressure: bacteria

prerequisite\_truth: tooth brushing

first\_principle: dentists



should not be discarded.



It should become a drift example that helps GFC build semantic rejection rules.



Candidate Benefit:



Very strong fit with adversarial testing.



Risk:



Low.



Required Before Adoption:



Define how failed examples are stored and classified.



Current Status:



High-priority candidate.



\---



\### LW-CAND-010 — Review Route Assignment



Potential GFC Use:



Semantic validators may eventually route cases to different review paths.



Example:



\- ordinary review

\- evidence review

\- domain review

\- legal review

\- adversarial review

\- first-principle review



Candidate Benefit:



Useful for scaling.



Risk:



Premature architecture complexity.



Required Before Adoption:



Wait until at least three semantic examples and one legal example exist.



Current Status:



Deferred candidate.



\---



\### LW-CAND-011 — Proportionate Response Envelope



Potential GFC Use:



A validator should not only return pass/fail.



It may return a response envelope.



Example:



\- accept

\- reject

\- accept within domain

\- reject as layer drift

\- require evidence

\- require human review

\- require domain review



Candidate Benefit:



Useful for nuanced semantic validation.



Risk:



Could complicate early tests.



Required Before Adoption:



Define minimal response outputs first.



Current Status:



Candidate only.



\---



\### LW-CAND-012 — Evidence-First Reflective Rule



Potential GFC Use:



GFC should continue allowing tested artifacts to reveal what the project is before forcing grand claims.



Candidate Benefit:



Already aligned with current GFC practice.



Risk:



Low.



Required Before Adoption:



May be accepted as a methodology rule.



Current Status:



High-priority candidate.



\---



\## 6. Recommended Review Order



Recommended order for future GFC review:



1\. Domain-Bounded Legitimacy

2\. Anti-Inflation

3\. Incident and Drift Feedback

4\. Legitimacy as Standing, Not Sovereignty

5\. Evidence-First Reflective Rule

6\. Bounded Warrant

7\. Proportionate Response Envelope

8\. Embedded Proposition Extraction

9\. Source-Neutral Review

10\. Tiered Review Depth

11\. Anti-Boxing

12\. Review Route Assignment



Reason:



The first three are immediately useful for the next semantic validation step.



GFC needs to reject invalid assignments without pretending its rules are universal across all domains.



\---



\## 7. No-Import Statement



This document does not import legitimacy-and-warrant-sandbox concepts into Governance Field Computing.



It identifies possible future review targets only.



Any promotion into GFC requires a decision record under:



docs/decisions/



\---



\## 8. Next Recommended Decision



Create:



docs/decisions/GFC-0005-Adopt-Domain-Bounded-Semantic-Validity.md



Purpose:



Evaluate whether GFC should adopt domain-bounded semantic validity as the first semantic validation principle.



Proposed principle:



A layer assignment is valid only relative to a declared domain, phrase, and decomposition purpose.



\---



Status: DRAFT

