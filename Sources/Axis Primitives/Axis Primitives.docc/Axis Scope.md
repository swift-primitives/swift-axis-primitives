# Axis Scope

The identity surface of `swift-axis-primitives` and what it deliberately excludes.

## Identity

`swift-axis-primitives` provides **dimension-checked coordinate-axis selection** — `Axis<N>`,
a value type identifying one of exactly `N` basis vector directions in an `N`-dimensional
coordinate system, with the dimension carried at the type level (`Axis<2>` ≠ `Axis<3>`).

## Core targets

- `Axis Primitive` — the root namespace: the `Axis<N>` value type, `Axis.Error`, per-arity
  accessors (`.primary` / `.secondary` / `.tertiary` / `.quaternary`, 2D `.perpendicular`),
  and conditional `Codable`. **Zero external dependencies** (the [MOD-017] root-target
  invariant).
- `Axis Enumerable Primitives` — the `Finite.Enumerable` conformance (`count`, `ordinal`,
  ordinal-based construction). Depends on finite + ordinal.

## Out of scope

- The binary orientation `Direction`: `swift-direction-primitives`.
- Domain-specific axis ↔ orientation typealiases (`Axis.Horizontal`, `Axis.Vertical`,
  `Axis.Depth`, `Axis.Temporal`, `Axis.Direction`): live in `swift-dimension-primitives`,
  which binds its preserved orientation family onto `Axis` via extensions on the imported
  type.
- Axis × Direction composite (`Facet<N>`): `swift-facet-primitives`.

## Evaluation rule

Sub-target additions are evaluated against this scope. If a proposed addition is OUT of
scope, it extracts to a sibling package, not into this one.
