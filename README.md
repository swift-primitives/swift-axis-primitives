# swift-axis-primitives

![Development Status](https://img.shields.io/badge/status-active--development-blue.svg)

Dimension-checked coordinate-axis selection for Swift — `Axis<N>` identifies one of exactly `N` basis vector directions, with the dimension carried in the type.

---

## Quick Start

`Axis<N>` names a basis vector direction in an `N`-dimensional coordinate system. The `let N: Int` value-generic parameter lives in the type, so `Axis<2>` and `Axis<3>` are distinct types: a 2D axis cannot be passed where a 3D axis is expected, and the mismatch is a compile error rather than a runtime bug.

```swift
import Axis_Primitives

// Per-arity accessors give the basis directions by name.
let x: Axis<3> = .primary      // index 0 (X)
let y: Axis<3> = .secondary    // index 1 (Y)
let z: Axis<3> = .tertiary     // index 2 (Z)

// 2D axes have a perpendicular; applying it twice is the identity.
let perp = Axis<2>.primary.perpendicular          // .secondary
let back = perp.perpendicular                      // .primary again

// The N inhabitants are enumerable, ordered by index.
for axis in Axis<3>.allCases { print(axis.ordinal) }   // 0, 1, 2
print(Axis<3>.count)                                   // 3

// Construction from a raw index is bounds-checked with typed throws.
let valid = try Axis<3>(2)                              // ok
// try Axis<3>(3)  →  throws Axis.Error.outOfBounds(3)
```

`Axis<3>` and `Axis<2>` carrying the same `underlying` index are still different types, so they cannot be compared or substituted for one another — the dimension check is enforced by the compiler, not by a runtime guard.

---

## Installation

```swift
dependencies: [
    .package(url: "https://github.com/swift-primitives/swift-axis-primitives.git", branch: "main")
]
```

```swift
.target(
    name: "App",
    dependencies: [
        .product(name: "Axis Primitives", package: "swift-axis-primitives"),
    ]
)
```

Requires Swift 6.3.1 and macOS 26 / iOS 26 / tvOS 26 / watchOS 26 / visionOS 26 (or the matching Linux / Windows toolchain).

---

## Architecture

The root `Axis Primitive` target is zero-dependency ([MOD-017]); each protocol conformance lives in its own sub-target so consumers import only what they use.

| Product | Depends on | When to import |
|---------|-----------|----------------|
| `Axis Primitive` | — | The `Axis<N>` value type, `Axis.Error`, per-arity accessors (`.primary` / `.secondary` / `.tertiary` / `.quaternary`, 2D `.perpendicular`), and conditional `Codable`. |
| `Axis Equation Primitives` | `swift-equation-primitives` | `Equation.Protocol` conformance (institute `Equatable` twin). |
| `Axis Hash Primitives` | `swift-hash-primitives` | `Hash.Protocol` conformance (institute `Hashable` twin). |
| `Axis Comparison Primitives` | `swift-comparison-primitives` | `Comparison.Protocol` conformance (institute `Comparable` twin), ordered by index. |
| `Axis Enumerable Primitives` | `swift-finite-primitives`, `swift-ordinal-primitives` | `Finite.Enumerable` conformance: `.count`, `.ordinal`, `.allCases`. |
| `Axis Primitives` | all of the above | Umbrella re-exporting every sub-target. |
| `Axis Primitives Test Support` | `Axis Primitives` | Test-only spine re-exporting upstream Test Support for literal comparisons. |

The `Direction` sign factor lives in `swift-direction-primitives`; the composite `Facet<N> = Axis<N> × Direction` lives in `swift-facet-primitives`.

Foundation-free.

---

## Platform Support

| Platform | Status |
|----------|--------|
| macOS 26 | Full support |
| Linux | Full support |
| Windows | Full support |
| iOS / tvOS / watchOS / visionOS | Supported |
| Swift Embedded | Supported (the `Codable` conformance is gated out under Embedded) |

---

## Community

<!-- BEGIN: discussion -->
<!-- Discussion thread created at publication. -->
<!-- END: discussion -->

## License

Apache 2.0. See [LICENSE.md](LICENSE.md).
