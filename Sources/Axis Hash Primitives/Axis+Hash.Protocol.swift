// Axis+Hash.Protocol.swift
// Conformance of Axis to Hash.Protocol — unconditional.
//
// `Hash.Protocol` refines `Swift.Hashable`. The `hash(into:)` and `==` witnesses
// live in the root (Axis.swift), so this conformance is empty.

public import Axis_Primitive
public import Hash_Primitives

extension Axis: Hash.`Protocol` {}
