// Axis+Comparison.Protocol.swift
// Conformance of Axis to Comparison.Protocol — unconditional.
//
// On Swift <6.4, `Comparison.Protocol` is the institute fork; on Swift 6.4+ it is a
// typealias to `Swift.Comparable` per SE-0499. The `<` / `<=` / `>` / `>=` witnesses live
// in the root (Axis.swift). The stdlib `extension Axis: Comparable {}` below is guarded
// `#if swift(<6.4)`.

public import Axis_Primitive
public import Comparison_Primitives

extension Axis: Comparison.`Protocol` {}

#if swift(<6.4)
    extension Axis: Comparable {}
#endif
