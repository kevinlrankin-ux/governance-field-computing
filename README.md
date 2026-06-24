# Governance Field Computing

**Governance Field Computing (GFC)** is a codeable discipline for analyzing personally, socially, institutionally, legally, and civilizationally weight-bearing language as compressed governance across intelligent systems.

It studies how phrases, principles, laws, norms, constitutions, doctrines, protocols, and enduring cultural teachings survive because they compress deeper pressure fields, prerequisite truths, failure modes, legitimacy conditions, and recurring realities.

> Durable governance language is evidence of recurring pressure across intelligent systems.

## What this repository is for

This repository is the ground-up working lab for Governance Field Computing. It is designed to keep the project from drifting by requiring every concept, schema, test, and artifact to be documented, versioned, and evidence-aware.

The project is intentionally built around a slow, auditable loop:

1. Define the term or component.
2. Preserve the original artifact.
3. Convert it into a schema or method.
4. Test it against simple examples.
5. Mark evidence strength and ambiguity.
6. Version changes rather than silently rewriting ideas.

## Core operations

- **Decompression**: expand a compressed governance phrase into its drivers, pressures, prerequisites, and failure modes.
- **Prerequisite bisection**: interrogate each driver through who, what, when, where, how, why, and why-not questions.
- **Field aggregation**: identify recurring pressure fields across domains and intelligent systems.
- **Sparse reconstruction**: use indexed operators and tokens to recreate larger governance meaning with less repeated parsing.
- **Exploration flagging**: identify high-value areas for evidence gathering, refinement, rediscovery, or breakthrough.

## Repository structure

```text
.
├── README.md
├── LICENSE.md
├── CONTRIBUTING.md
├── CODE_OF_CONDUCT.md
├── CHANGELOG.md
├── docs/
│   ├── artifacts/        # Preserved originating artifacts
│   ├── architecture/     # System architecture and design notes
│   └── methodology/      # Method documents and protocols
├── schemas/              # JSON Schemas for codeable discipline components
├── examples/             # Test cases and sample decompositions
├── tests/                # Validation tests
├── powershell/           # Windows-first build/test scripts
└── src/gfc/              # Future implementation modules
```

## Preserved starting artifacts

The following foundational artifacts are preserved in `docs/artifacts/FOUNDATIONAL_ARTIFACTS.md`:

- Governance Field Computing
- Revised Working Definition
- Scale Invariance Principle
- Revised Scale Invariance Principle -- v0.2

## Quick start with PowerShell

From the repository root:

```powershell
./powershell/Test-Repository.ps1
```

To package the repository into a zip:

```powershell
./powershell/Package-Repository.ps1
```

## Current status

This is an early foundation repository. It is not yet a software package. The first engineering target is to formalize and test **Pressure Driver Bisection Schema v0.1** using the test driver `bacteria` from the phrase:

> Brush your teeth twice a day.

## Documentation discipline

No component should be treated as accepted until it has:

- a working definition,
- a schema or method representation,
- at least one test case,
- evidence notes,
- ambiguity notes,
- version history.

## Disclaimer

This project is research infrastructure. It is not legal advice, medical advice, or a substitute for qualified professional judgment.
