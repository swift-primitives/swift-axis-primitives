# swift-axis-primitives

Dimension-checked coordinate-axis selection for the Swift Institute primitives layer.

`Axis<N>` identifies one of exactly `N` basis vector directions in an `N`-dimensional
coordinate system. The `let N: Int` value-generic parameter carries the dimension in the
type, so `Axis<2>` and `Axis<3>` are distinct types and cannot be mixed.

```swift
import Axis_Primitives

let x: Axis<3> = .primary       // index 0
let y: Axis<3> = .secondary     // index 1
let perp = Axis<2>.primary.perpendicular   // .secondary

for axis in Axis<3>.allCases { print(axis.ordinal) }   // 0, 1, 2
```

The root `Axis Primitive` target is **zero-dependency** ([MOD-017]); the
`Finite.Enumerable` conformance (`.count`, `.ordinal`, `.allCases`) lives in the
`Axis Enumerable Primitives` sub-target, which depends on finite + ordinal.

The `Direction` sign factor lives in `swift-direction-primitives`; the composite
`Facet<N> = Axis<N> × Direction` lives in `swift-facet-primitives`.

## License

Apache License 2.0. See [LICENSE](LICENSE.md).
