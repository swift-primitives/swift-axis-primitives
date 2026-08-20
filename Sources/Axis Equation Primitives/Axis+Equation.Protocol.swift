// Axis+Equation.Protocol.swift
// Conformance of Axis to Equation.Protocol — unconditional.
//
// `Equation.Protocol` aliases `Swift.Equatable`; the equality witness lives in
// the root (Axis.swift).

public import Axis_Primitive
public import Equation_Primitives

extension Axis: Equation.`Protocol` {}
