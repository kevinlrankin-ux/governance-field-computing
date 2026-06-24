\# GFC-0005 — Adopt Domain-Bounded Semantic Validity



Artifact: GFC-0005 — Adopt Domain-Bounded Semantic Validity

Version: 1.0

Status: Accepted

Decision Type: Methodology Decision

Date: 2026-06-23



\---



\## 1. Summary



Governance Field Computing adopts \*\*Domain-Bounded Semantic Validity\*\* as the first semantic validation principle.



This decision establishes that a layer assignment is not judged in isolation.



A layer assignment is valid only relative to:



1\. a declared domain

2\. a source governance phrase

3\. a decomposition purpose

4\. the current pressure-layer taxonomy

5\. the evidence or reasoning available at the time of validation



\---



\## 2. Reason for Decision



GFC is moving from structural validation toward semantic validation.



Structural validation asks:



Does the artifact exist, parse, and contain the required fields?



Semantic validation asks:



Do the field values belong in the assigned layers?



The current valid taxonomy example assigns:



driver:



bacteria



pressure:



harmful accumulation can increase risk of decay, disease, odor, or damage



prerequisite\_truth:



bacteria can grow, reproduce, and accumulate under certain conditions



first\_principle:



time permits accumulation and change



This is semantically plausible in the oral hygiene domain.



However, the same terms may not carry the same layer roles in other domains.



Therefore, GFC must avoid both overclaiming and underclaiming.



\---



\## 3. Adopted Principle



Domain-Bounded Semantic Validity:



A layer assignment is valid only relative to a declared domain, source phrase, decomposition purpose, current taxonomy, and available warrant.



\---



\## 4. Boundary Rule



A valid layer assignment in one domain must not automatically inflate into a universal rule.



Example:



The claim:



bacteria is a valid driver for the phrase "Brush your teeth twice a day"



does not imply:



bacteria is always a driver



or:



bacteria is a driver in every governance decomposition



or:



the oral hygiene decomposition governs constitutional, financial, ecological, or AI-system examples.



\---



\## 5. Validity Scope



Every future semantic validation should eventually record:



\- domain

\- source phrase

\- decomposition purpose

\- layer assignment

\- validation result

\- scope note

\- warrant note

\- uncertainty note when needed



\---



\## 6. GFC Layer Relationship



This decision does not alter the core pressure layers.



The core layers remain:



1\. Governance Phrase

2\. Driver

3\. Pressure

4\. Prerequisite Truth

5\. First Principle



Domain-Bounded Semantic Validity governs how assignments to those layers are judged.



It is not itself a layer.



\---



\## 7. Relationship to Vendor Source



This decision is informed by VENDOR-005:



kevinlrankin-ux/-legitimacy-and-warrant-sandbox



Relevant vendor candidate:



LW-CAND-005 — Domain-Bounded Legitimacy



Vendor concept status before this decision:



Candidate only



GFC adoption status after this decision:



Adapted into GFC as Domain-Bounded Semantic Validity



This decision does not import the vendor concept wholesale.



It adapts a narrow principle for GFC semantic validation.



\---



\## 8. Why This Is Not Domain-Bounded Legitimacy



GFC is not yet adopting domain-bounded legitimacy.



Legitimacy is broader than semantic layer correctness.



This decision adopts a narrower concept:



domain-bounded semantic validity



This means:



A layer assignment may be valid or invalid within a domain-specific decomposition.



It does not mean:



The source, phrase, system, institution, or governance outcome is legitimate.



\---



\## 9. Application to Current Examples



\### Valid Example



File:



examples\\pressure-layer-taxonomy.example.json



Domain:



oral hygiene



Phrase:



Brush your teeth twice a day



Assignment:



driver = bacteria



Semantic status:



Valid within current oral hygiene decomposition.



Scope note:



This does not generalize outside the oral hygiene example without review.



\---



\### Invalid Example



File:



examples\\pressure-layer-taxonomy.invalid.example.json



Domain:



oral hygiene



Phrase:



Brush your teeth twice a day



Assignments:



driver = time



pressure = bacteria



prerequisite\_truth = tooth brushing



first\_principle = dentists



Semantic status:



Expected future result: fail



Reason:



The assignments are not valid within the current oral hygiene decomposition.



\---



\## 10. Required Schema Impact



Future semantic rule schemas should support:



\- domain

\- phrase

\- valid\_assignments

\- invalid\_assignments

\- scope\_note

\- warrant\_note

\- validation\_result



\---



\## 11. Required Validator Impact



Future validators should distinguish:



1\. structural validation

2\. semantic rule validation

3\. domain-bound validity

4\. warrant status



The next validator should not claim universal semantic truth.



It should claim only that an assignment passes or fails the current domain-bound rule set.



\---



\## 12. Risk Review



\### Risk 1 — Overgeneralization



A valid assignment in one domain may be treated as universal.



Mitigation:



Require scope notes.



\---



\### Risk 2 — Excessive Relativism



Invalid assignments may be excused as domain-dependent.



Mitigation:



Require declared domain and rule-set comparison.



\---



\### Risk 3 — Premature Legitimacy Claims



Semantic validity may be mistaken for legitimacy.



Mitigation:



Maintain separation between semantic validity and legitimacy.



\---



\### Risk 4 — Rule Freezing



Early domain rules may become treated as final.



Mitigation:



Rules remain versioned, revisable, and subject to adversarial testing.



\---



\## 13. Decision



Accepted.



Domain-Bounded Semantic Validity is now a Governance Field Computing methodology principle.



It will guide the first semantic rule set and semantic validator.



\---



\## 14. Next Approved Build



Create:



schemas\\pressure-layer-semantic-rules.v0.1.json



Purpose:



Define domain-bound valid and invalid layer assignments for the oral hygiene test case.



Then create:



tests\\test\_pressure\_layer\_semantic\_rules.ps1



Purpose:



Validate that the current valid example passes and the adversarial example fails under the first semantic rule set.



\---



Decision Status: ACTIVE

