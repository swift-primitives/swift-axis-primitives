// Axis+Finite.Enumerable.swift
// Finite.Enumerable conformance for Axis<N> via Finite.Enumerable.

import Axis_Primitive
import Finite_Primitives
import Ordinal_Primitives

// MARK: - Axis: Finite.Enumerable

extension Axis: Finite.Enumerable {
    /// Number of axes in N-dimensional space.
    @inlinable
    public static var count: Cardinal { Cardinal.init(integerLiteral: UInt(N)) }

    /// Ordinal of this axis (0 to N-1).
    @inlinable
    public var ordinal: Ordinal { .init(UInt8(underlying)) }

    /// Creates an axis from its ordinal without bounds checking.
    @inlinable
    public init(_unchecked: Void, ordinal: Ordinal) {
        self.init(_unchecked: (), Int(bitPattern: ordinal))
    }
}
