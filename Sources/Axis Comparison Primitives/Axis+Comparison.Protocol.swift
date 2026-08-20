// Axis+Comparison.Protocol.swift
// Conformance of Axis to Comparison.Protocol — unconditional.
//
// `Comparison.Protocol` aliases `Swift.Comparable`. The comparison witnesses live
// in the root (Axis.swift).

public import Axis_Primitive
public import Comparison_Primitives

extension Axis: Comparison.`Protocol` {}
