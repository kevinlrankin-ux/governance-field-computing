\# Semantic Validation Review Report v0.1



Artifact: Semantic Validation Review Report

Version: 0.1

Status: Draft

Date: 2026-06-23



Generated From:



artifacts\\semantic-validation-results.v0.1.json



Rule Set:



schemas\\pressure-layer-semantic-rules.v0.1.json



Validator:



tests\\test\_pressure\_layer\_semantic\_rules.ps1



Run Artifact Validator:



tests\\test\_semantic\_validation\_run\_artifact.ps1



\---



\## 1. Report Summary



Governance Field Computing successfully produced structured semantic validation results and rendered them into this human-readable review report.



The current validation run tested two examples:



1\. valid oral hygiene example

2\. adversarial oral hygiene example



Result:



\- Valid example passed.

\- Adversarial example failed.

\- Four invalid layer assignments were detected.



\---



\## 2. Domain and Scope



Domain:



oral hygiene



Source Phrase:



Brush your teeth twice a day



Rule Set:



pressure-layer-semantic-rules.v0.1



Scope Rule:



These results apply only to the current oral hygiene test case and source phrase.



They must not be generalized to other domains, phrases, legal clauses, institutions, intelligent systems, or pressure-field decompositions without a separate rule set and review.



\---



\## 3. Source Artifacts



The following artifacts support this report:



\- schemas\\pressure-layer-semantic-rules.v0.1.json

\- schemas\\semantic-validation-result.schema.json

\- schemas\\semantic-validation-run.schema.json

\- examples\\pressure-layer-taxonomy.example.json

\- examples\\pressure-layer-taxonomy.invalid.example.json

\- tests\\test\_pressure\_layer\_semantic\_rules.ps1

\- tests\\test\_semantic\_validation\_run\_artifact.ps1

\- artifacts\\semantic-validation-results.v0.1.json



\---



\## 4. Valid Example Result



Label:



valid oral hygiene example



Overall Result:



pass



Layer Assignments:



\- driver = bacteria

\- pressure = harmful accumulation can increase risk of decay, disease, odor, or damage

\- prerequisite\_truth = bacteria can grow, reproduce, and accumulate under certain conditions

\- first\_principle = time permits accumulation and change



Interpretation:



All current layer assignments match the domain-bound valid assignment list.



This means the example passes the current oral hygiene semantic rule set.



It does not mean the decomposition is universally true, complete, or fully evidenced.



\---



\## 5. Adversarial Example Result



Label:



adversarial oral hygiene example



Overall Result:



fail



Invalid Layer Assignments:



\- driver = time

\- pressure = bacteria

\- prerequisite\_truth = tooth brushing

\- first\_principle = dentists



Interpretation:



The adversarial example fails because all four layer assignments conflict with the current oral hygiene semantic rule set.



This proves that the validator can reject a structurally readable but semantically invalid decomposition under the current domain-bound rule set.



\---



\## 6. Failure Analysis



\### 6.1 driver = time



Result Level:



invalid\_within\_current\_taxonomy



Reason:



Time is treated in the current valid decomposition as a first principle, not the local driver.



Current Interpretation:



Time may permit accumulation and change, but in this oral hygiene example it is not the concrete driver generating the pressure.



\---



\### 6.2 pressure = bacteria



Result Level:



invalid\_within\_current\_taxonomy



Reason:



Bacteria is treated in the current valid decomposition as the driver, not the pressure.



Current Interpretation:



Bacteria generates or contributes to the pressure.



It is not itself the pressure in this decomposition.



\---



\### 6.3 prerequisite\_truth = tooth brushing



Result Level:



invalid\_within\_current\_taxonomy



Reason:



Tooth brushing is a governance behavior or phrase-derived action, not a prerequisite truth for the pressure to exist.



Current Interpretation:



The pressure can exist before or without tooth brushing.



Therefore tooth brushing cannot serve as the prerequisite truth in this decomposition.



\---



\### 6.4 first\_principle = dentists



Result Level:



invalid\_within\_current\_taxonomy



Reason:



Dentists are institutional actors.



They are not a first principle in the current decomposition.



Current Interpretation:



Dentists may be relevant to treatment, expertise, recommendation, institutional trust, or public-health guidance.



They are not a foundational reality that makes the pressure chain possible.



\---



\## 7. Warrant and Evidence Status



Current Evidence Status:



pending



Meaning:



The current semantic validation is rule-based and structurally tested.



Evidence citations remain pending.



This report does not claim that all biological, dental, medical, or public-health evidence has been fully cited.



\---



\## 8. What This Report Proves



This report proves that Governance Field Computing can currently:



1\. Define a domain-bound semantic rule set.

2\. Validate a correct example against that rule set.

3\. Reject an adversarial example under that rule set.

4\. Emit structured semantic validation results.

5\. Validate the result artifact shape.

6\. Render the result into a human-readable report.



\---



\## 9. What This Report Does Not Prove



This report does not prove:



\- universal semantic truth

\- complete dental science

\- legal legitimacy

\- cross-domain validity

\- general semantic intelligence

\- final pressure-layer taxonomy completeness

\- evidence-complete medical or public-health validation



\---



\## 10. Anti-Inflation Note



The current result must not inflate beyond its domain.



A valid assignment here does not imply universal validity elsewhere.



A failed assignment here does not imply universal impossibility elsewhere.



The result applies only to:



\- the current oral hygiene domain

\- the current source phrase

\- the current rule set

\- the current examples

\- the current validator version



\---



\## 11. Current Limitations



The current system still relies on:



\- exact string matching

\- manually authored rule sets

\- manually authored examples

\- pending evidence citations

\- fixed result-level logic



It does not yet support:



\- synonym handling

\- evidence citation validation

\- confidence scoring

\- legal-semantic operator handling

\- ontology lookup

\- multi-domain rule selection

\- automated warrant scoring

\- natural-language explanation generation beyond fixed result reasons



\---



\## 12. Recommended Next Actions



Recommended next actions:



1\. Preserve the current semantic validation chain.

2\. Add evidence citation validation later.

3\. Test a second governance phrase.

4\. Test one legal or constitutional phrase.

5\. Add a decision record accepting this review report artifact.

6\. Avoid generalizing the oral hygiene rule set.



\---



\## 13. Status



Draft.



This report should be accepted by decision record only after it is verified as saved and reviewed.

