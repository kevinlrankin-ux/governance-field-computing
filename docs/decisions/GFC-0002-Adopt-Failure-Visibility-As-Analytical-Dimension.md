\# GFC-0002 — Adopt Failure Visibility as Analytical Dimension



Artifact: GFC-0002 — Adopt Failure Visibility as Analytical Dimension

Version: 1.0

Status: Accepted

Decision Type: Methodology Decision

Date: 2026-06-23



\---



\## 1. Summary



Governance Field Computing adopts \*\*Failure Visibility\*\* as an analytical dimension.



Failure Visibility is not adopted as a core pressure layer.



It does not replace:



\- Driver

\- Pressure

\- Prerequisite Truth

\- First Principle



Instead, Failure Visibility describes how a failure manifests when a governance phrase, pressure field, or constraint structure fails.



\---



\## 2. Source



Vendor Source:



kevinlrankin-ux/constitutional-language-protocol



Vendor ID:



VENDOR-003



Relevant vendor concept:



Failure Visibility



Vendor Status:



Reference Only



Import Status Before Decision:



Not Imported



\---



\## 3. Vendor Finding



The Constitutional Language Protocol defines Failure Visibility as a dimension describing how system failure manifests.



Examples include:



\- immediate or delayed

\- visible or silent

\- localized or systemic

\- recoverable or irreversible



CLP does not define acceptable failure.



\---



\## 4. GFC Interpretation



Governance Field Computing requires a way to identify how failures appear when a governance phrase fails to govern its pressure field.



Failure Visibility is useful because some governance failures are not immediately obvious.



For example:



The phrase:



"Brush your teeth twice a day"



may fail visibly through pain, odor, or decay.



But it may also fail silently through gradual accumulation before visible harm appears.



This distinction helps GFC identify whether a governance phrase is protecting against immediate, delayed, visible, silent, local, systemic, recoverable, or irreversible failure.



\---



\## 5. Decision



GFC adopts Failure Visibility as an analytical dimension.



It is accepted for use in examples, schemas, validators, methodology documents, and future decompositions.



It is not accepted as a core layer.



The core pressure layers remain:



1\. Governance Phrase

2\. Driver

3\. Pressure

4\. Prerequisite Truth

5\. First Principle



Failure Visibility may be attached to any decomposition as an evaluative or descriptive field.



\---



\## 6. Accepted GFC Definition



Failure Visibility:



The manner in which failure manifests when a governance phrase, pressure field, constraint, or system boundary fails.



Failure Visibility may describe whether failure is:



\- immediate

\- delayed

\- visible

\- silent

\- localized

\- systemic

\- recoverable

\- irreversible



\---



\## 7. Boundary Rule



Failure Visibility must not be confused with Pressure.



Pressure explains why governance is needed.



Failure Visibility explains how failure appears if governance does not hold.



Example:



Driver:



bacteria



Pressure:



harmful accumulation can increase risk of decay, disease, odor, or damage



Failure Visibility:



failure may be delayed and initially silent before becoming visible as pain, odor, decay, or disease



\---



\## 8. Required Schema Impact



Future schemas may include:



failure\_visibility



This field should be optional at first.



It should not be required until tested across multiple examples.



\---



\## 9. Required Test Impact



Future validators should eventually test whether Failure Visibility contains valid descriptors.



Initial permitted descriptors:



\- immediate

\- delayed

\- visible

\- silent

\- localized

\- systemic

\- recoverable

\- irreversible



\---



\## 10. Risk Review



Risk 1:



Failure Visibility may be confused with Pressure.



Mitigation:



Maintain the boundary rule.



Risk 2:



The concept is vendor-derived.



Mitigation:



This decision adapts the concept into GFC rather than importing CLP wholesale.



Risk 3:



The field may become too broad.



Mitigation:



Limit accepted descriptors in early schemas and tests.



\---



\## 11. Decision



Accepted.



Failure Visibility is now a Governance Field Computing analytical dimension.



It is not a core pressure layer.



\---



\## 12. Next Approved Build



Update the pressure-layer taxonomy example to include optional failure\_visibility.



Then update the taxonomy validator to display Failure Visibility when present.



\---



Decision Status: ACTIVE

