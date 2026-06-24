\# GFC-0004 — Adversarial Taxonomy Fixture Accepted



Artifact: GFC-0004 — Adversarial Taxonomy Fixture Accepted

Version: 1.0

Status: Accepted

Decision Type: Test Fixture / Limitation Record

Date: 2026-06-23



\---



\## 1. Summary



Governance Field Computing created and validated its first adversarial pressure-layer taxonomy fixture.



The fixture is intentionally incorrect.



It exists to prove the boundary between:



\- structural validation

\- semantic validation



The current adversarial test confirms that the invalid fixture exists, parses, and is structurally readable.



It does not yet prove semantic rejection.



\---



\## 2. Files Created



Invalid example fixture:



examples\\pressure-layer-taxonomy.invalid.example.json



Adversarial validator:



tests\\test\_pressure\_layer\_taxonomy\_adversarial.ps1



\---



\## 3. Invalid Fixture



The invalid fixture intentionally assigns concepts to the wrong layers:



driver:



time



pressure:



bacteria



prerequisite\_truth:



tooth brushing



first\_principle:



dentists



Expected validation result:



fail



\---



\## 4. Why the Fixture Is Invalid



The fixture is invalid because:



\- time is more appropriately treated as a first principle or prerequisite reality, not as the local driver in this example

\- bacteria is more appropriately treated as a driver, not as the pressure itself

\- tooth brushing is a governance behavior or phrase-derived action, not a prerequisite truth

\- dentists are institutional actors, not first principles



\---



\## 5. Current Validator Behavior



Current adversarial validator behavior:



PASS



Reason:



The validator currently confirms that the adversarial fixture exists and is structurally readable.



It does not yet evaluate whether the layer assignments are semantically correct.



\---



\## 6. Validation Output



ADVERSARIAL FIXTURE LOADED.

Governance Phrase: Brush your teeth twice a day

Driver: time

Pressure: bacteria

Prerequisite Truth: tooth brushing

First Principle: dentists

Expected Validation Result: fail



KNOWN LIMITATION:

This test currently verifies that the invalid fixture exists and is structurally readable.

It does not yet prove semantic rejection.



PASS: Adversarial taxonomy fixture validated as a test fixture.



\---



\## 7. Significance



This is the first Governance Field Computing artifact that intentionally captures a bad decomposition.



The project now has both:



\- a valid taxonomy example

\- an invalid taxonomy example



This enables future validators to test not only whether an artifact is present and structured, but whether it correctly assigns concepts to layers.



\---



\## 8. Boundary Established



Structural validation answers:



Does the file exist, parse, and contain the required fields?



Semantic validation answers:



Do the field values belong in the assigned layers?



The current system supports structural validation.



The next build must begin semantic validation.



\---



\## 9. Next Approved Build



Create the first semantic rule set.



Proposed file:



schemas\\pressure-layer-semantic-rules.v0.1.json



Purpose:



Define known invalid and valid assignments for early pressure-layer taxonomy validation.



Initial rule examples:



\- bacteria may be a valid driver in oral-hygiene examples

\- time may be a valid first principle

\- dentists may not be valid first principles

\- tooth brushing may not be valid prerequisite truth in this example



\---



Decision Status: ACTIVE

