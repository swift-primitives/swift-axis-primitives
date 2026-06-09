# ``Axis_Primitives``

@Metadata {
    @DisplayName("Axis Primitives")
    @TitleHeading("Swift Institute — Primitives Layer")
}

Dimension-checked coordinate-axis selection — `Axis<N>`, one of N basis directions with the dimension carried in the type.

## Overview

`Axis Primitives` ships ``Axis_Primitive/Axis``, a value type identifying one of exactly `N` basis vector directions in an `N`-dimensional coordinate system, independent of orientation. The `let N: Int` value-generic parameter carries the dimension at the type level — `Axis<2>` and `Axis<3>` are distinct types, so operations cannot mix incompatible spaces.

Per-arity accessors (`.primary`, `.secondary`, `.tertiary`, `.quaternary`, and 2D `.perpendicular`) give intuitive access to the X/Y/Z/W axes. `Axis<N>` conforms to `Finite.Enumerable` (in the `Axis Enumerable Primitives` sub-target), so its `N` inhabitants are enumerable via `.allCases`, addressable by `.ordinal`, and counted by `.count`.

`Axis` is an **atom**: the root `Axis Primitive` target has zero external dependencies. The `Direction` sign factor lives in `swift-direction-primitives`; the composite `Facet<N> = Axis<N> × Direction` lives in `swift-facet-primitives`.

## Topics

### Essentials

- <doc:Axis-Scope>

### Core Type

- ``Axis_Primitive/Axis``
- ``Axis_Primitive/Axis/Error``
