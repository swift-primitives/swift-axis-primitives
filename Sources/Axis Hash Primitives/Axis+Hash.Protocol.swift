// Axis+Hash.Protocol.swift
// Conformance of Axis to Hash.Protocol — unconditional.
//
// On Swift <6.4, `Hash.Protocol` is the institute fork; on Swift 6.4+ it refines
// `Swift.Hashable` per SE-0499. The `hash(into:)` and `==` witnesses live in the root
// (Axis.swift), so this conformance is empty. `Axis` is a struct (not auto-Hashable), so
// the stdlib `Hashable` conformance is declared here, guarded `#if swift(<6.4)`.

public import Axis_Primitive
public import Hash_Primitives

extension Axis: Hash.`Protocol` {}

#if swift(<6.4)
    extension Axis: Hashable {}
#endif
