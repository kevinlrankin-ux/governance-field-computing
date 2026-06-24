# Semantic Validation Result Levels v0.1

Artifact: Semantic Validation Result Levels
Version: 0.1
Status: Draft
Purpose: Define the permitted semantic validation outcomes for Governance Field Computing before expanding beyond binary pass/fail.
Depends On: GFC-0005 — Adopt Domain-Bounded Semantic Validity; GFC-0006 — First Semantic Rejection Achieved
Required By: Future semantic validators, rule-set expansion, warrant scoring, domain review, and legal-semantic operator validation.
Evidence Level: Methodology / Requires implementation testing
Date: 2026-06-23

---

## 1. Purpose

Governance Field Computing has achieved its first executable semantic rejection.

The current validator supports two outcomes:

- pass
- fail

This document defines a richer set of semantic validation result levels so future validators can avoid overclaiming.

The goal is to distinguish between:

- valid assignment
- invalid assignment
- insufficient evidence
- unsupported claim
- domain mismatch
- taxonomy mismatch
- review escalation

---

## 2. Core Rule

A semantic validation result must describe the status of the assignment within the declared:

1. domain
2. source phrase
3. decomposition purpose
4. current taxonomy
5. current rule set
6. current warrant level

A result must not imply universal truth unless explicitly supported by future evidence and decision records.

---

## 3. Result Level Table

| Result Level | Meaning | Validator Posture |
|---|---|---|
| pass | Assignment conforms to the current rule set within the declared domain and purpose | Accepted for current rule set |
| fail | Assignment violates the current rule set within the declared domain and purpose | Rejected for current rule set |
| needs_evidence | Assignment may be plausible, but evidence is insufficient or missing | Hold / evidence required |
| needs_domain_review | Assignment may depend on domain expertise or cross-domain interpretation | Escalate to domain review |
| unsupported | Assignment is not supported by current evidence, rules, or reasoning | Do not accept |
| invalid_within_current_taxonomy | Assignment conflicts with the current pressure-layer taxonomy | Reject unless taxonomy is revised |
| out_of_scope | Assignment cannot be evaluated under the declared domain, phrase, or purpose | Defer or reframe |
| ambiguous | Assignment has multiple plausible interpretations and cannot yet be resolved | Hold / clarify |
| superseded | Assignment was previously accepted but has been replaced by a later rule, evidence, or decision | Retire previous status |

---

## 4. Result Definitions

### pass

Definition:

The assignment belongs in the assigned layer under the current domain-bound rule set.

Use when:

- the domain matches
- the phrase matches
- the value appears in valid assignments
- no blocking conflict is detected

Example:

driver = bacteria

within the oral hygiene phrase:

Brush your teeth twice a day

Current status:

pass

---

### fail

Definition:

The assignment violates the current domain-bound rule set.

Use when:

- the value appears in invalid assignments
- the value clearly belongs to another layer
- the assignment contradicts the current taxonomy

Example:

first_principle = dentists

within the oral hygiene phrase:

Brush your teeth twice a day

Current status:

fail

---

### needs_evidence

Definition:

The assignment may be plausible, but the current artifact lacks enough evidence to validate it.

Use when:

- evidence citation is missing
- claim support is incomplete
- scientific, legal, historical, or domain sources are required
- reasoning alone is insufficient

Example:

pressure = twice-daily brushing prevents all meaningful dental decay

This may require evidence review and should not pass merely because it sounds plausible.

---

### needs_domain_review

Definition:

The assignment may be domain-dependent and requires a knowledgeable review context.

Use when:

- the phrase crosses fields
- the driver belongs to a specialized discipline
- the assignment may be correct only under specific technical, legal, biological, or institutional conditions

Example:

driver = biofilm ecology

This may require dental, microbiological, or public-health review.

---

### unsupported

Definition:

The assignment lacks support in the current rule set, evidence base, or reasoning record.

Use when:

- the claim is asserted without basis
- no rule permits it
- no evidence supports it
- no rationale explains it

Unsupported is weaker than fail.

A failed assignment is rejected by rule.

An unsupported assignment lacks enough support to accept.

---

### invalid_within_current_taxonomy

Definition:

The assignment violates the pressure-layer taxonomy itself.

Use when:

- a governance action is placed as a prerequisite truth
- an institutional actor is placed as a first principle
- a first principle is treated as a local driver without justification
- a pressure is confused with a driver

Example:

prerequisite_truth = tooth brushing

This is invalid within the current taxonomy because tooth brushing is a governance behavior or phrase-derived action, not a prerequisite truth.

---

### out_of_scope

Definition:

The assignment cannot be evaluated under the declared domain, source phrase, or decomposition purpose.

Use when:

- the artifact introduces a domain not declared
- the assignment depends on a different phrase
- the example does not match the rule set
- the validation target is outside the current schema

Example:

driver = monetary inflation

within the oral hygiene test case may be out of scope unless the decomposition explicitly includes economics, dental access, or cost pressure.

---

### ambiguous

Definition:

The assignment has more than one plausible interpretation and cannot yet be resolved.

Use when:

- the term has multiple meanings
- the layer role depends on context not yet specified
- a value may be valid in one decomposition but invalid in another
- more precise phrasing is required

Example:

pressure = accumulation

This may refer to bacterial accumulation, financial accumulation, data accumulation, institutional burden, or entropy.

---

### superseded

Definition:

The assignment or rule was once accepted but has been replaced by a later rule, evidence source, schema, or decision record.

Use when:

- a better decomposition replaces an older one
- a rule set is upgraded
- an evidence pass changes status
- a decision record retires an earlier interpretation

Example:

A future evidence review may supersede the current oral hygiene rule set if better public-health phrasing changes the pressure definition.

---

## 5. Required Result Metadata

Future semantic validators should eventually return:

- result_level
- domain
- source_phrase
- rule_set_id
- layer
- assigned_value
- reason
- scope_note
- warrant_note
- evidence_status
- recommended_next_action

---

## 6. Minimal Machine-Readable Result Shape

Future validator output may use this structure:

```json
{
  "result_level": "",
  "domain": "",
  "source_phrase": "",
  "rule_set_id": "",
  "layer": "",
  "assigned_value": "",
  "reason": "",
  "scope_note": "",
  "warrant_note": "",
  "evidence_status": "",
  "recommended_next_action": ""
}
7. Boundary Rules
Rule 1 — Pass is not universal truth

A pass result means:

The assignment passes the current domain-bound rule set.

It does not mean:

The assignment is universally true.

Rule 2 — Fail is not universal impossibility

A fail result means:

The assignment fails under the current rule set.

It does not mean:

The term could never be valid in another domain, phrase, or decomposition.

Rule 3 — Needs evidence is not failure

A needs_evidence result means:

The assignment may be plausible but is not yet supported enough to pass.

Rule 4 — Unsupported is not the same as false

Unsupported means the system lacks support for acceptance.

It does not automatically prove falsity.

Rule 5 — Invalid within taxonomy requires taxonomy review if contested

If an assignment is marked invalid_within_current_taxonomy and a reviewer contests it, the reviewer must either:

provide evidence that the assignment fits the current taxonomy
propose a taxonomy revision
create a new domain-bound rule set
8. Application to Current Examples
Valid Example

File:

examples\pressure-layer-taxonomy.example.json

Expected result:

pass

Reason:

All assignments match the current oral hygiene semantic rule set.

Adversarial Example

File:

examples\pressure-layer-taxonomy.invalid.example.json

Expected result:

fail

More precise future result:

invalid_within_current_taxonomy

Reason:

The adversarial example assigns terms to layers where they do not belong under the current oral hygiene rule set.

9. Current Status

This document defines result levels conceptually.

The current semantic validator still supports binary pass/fail.

Future implementation should expand validator output to support these result levels.

10. Next Approved Build

Create:

schemas\semantic-validation-result.schema.json

Purpose:

Define a machine-readable schema for semantic validation results.

Then update:

tests\test_pressure_layer_semantic_rules.ps1

Purpose:

Emit structured result levels instead of only console text.
}
