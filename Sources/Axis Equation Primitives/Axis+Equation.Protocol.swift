// Axis+Equation.Protocol.swift
// Conformance of Axis to Equation.Protocol — unconditional.
//
// On Swift <6.4, `Equation.Protocol` is the institute fork supporting `borrowing`
// parameters; on Swift 6.4+ it is a typealias to `Swift.Equatable` per SE-0499. The `==`
// witness lives in the root (Axis.swift). The stdlib `extension Axis: Hashable {}` in
// `Axis Hash Primitives` (which implies `Equatable`) is guarded `#if swift(<6.4)` to avoid
// duplicate-conformance.

public import Axis_Primitive
public import Equation_Primitives

extension Axis: Equation.`Protocol` {}
