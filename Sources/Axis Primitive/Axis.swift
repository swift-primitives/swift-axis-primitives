// Axis.swift
// A coordinate axis in N-dimensional space.

/// A coordinate axis in N-dimensional space.
///
/// `Axis<N>` identifies one of exactly N basis vector directions in a coordinate system, independent of orientation. The type parameter provides compile-time dimension checking, preventing operations on incompatible spaces (e.g., cannot use `Axis<2>` in 3D context).
///
/// In linear algebra, axes are the basis vector directions indexed 0 through N-1. Use `primary`, `secondary`, `tertiary`, and `quaternary` for intuitive access to X, Y, Z, and W axes respectively.
///
/// Equality, hashing, and ordering are provided through the institute twins
/// `Equation.Protocol` / `Hash.Protocol` / `Comparison.Protocol` (in the
/// `Axis Equation/Hash/Comparison Primitives` sub-targets), ordered by `underlying` index;
/// the operators themselves live here in the root.
///
/// ## Example
///
/// ```swift
/// let x: Axis<3> = .primary     // Axis 0 (X)
/// let y: Axis<3> = .secondary   // Axis 1 (Y)
/// let z: Axis<3> = .tertiary    // Axis 2 (Z)
///
/// // 2D perpendicular axis
/// let perp = Axis<2>.primary.perpendicular  // .secondary
///
/// // Iterate all axes
/// for axis in Axis<3>.allCases { print(axis.underlying) }  // 0, 1, 2
/// ```
public struct Axis<let N: Int>: Sendable {
    /// Zero-based index of this axis (0 to N-1).
    public let underlying: Int

    /// Error thrown when axis construction fails.
    public enum Error: Swift.Error, Hashable, Sendable {
        /// The provided value was outside the valid range `0..<N`.
        case outOfBounds(Int)
    }

    /// Creates an axis from a raw index.
    ///
    /// - Parameter underlying: The axis index.
    /// - Throws: `Error.outOfBounds` if `underlying < 0` or `underlying >= N`.
    @inlinable
    public init(_ underlying: Int) throws(Self.Error) {
        guard underlying >= 0, underlying < N else { throw .outOfBounds(underlying) }
        self.underlying = underlying
    }

    /// Creates an axis from a raw value without bounds checking.
    ///
    /// - Parameters:
    ///   - _unchecked: Marker parameter indicating unchecked access.
    ///   - underlying: Must be in `0..<N`.
    @inlinable
    public init(_unchecked: Void, _ underlying: Int) {
        self.underlying = underlying
    }
}

// MARK: - Equality, Hashing, Ordering

// The full ==/</<=/>/>= operator set + hash(into:) is declared here in the type's own
// module so it witnesses both any stdlib conformance and the institute
// `Equation.Protocol` / `Hash.Protocol` / `Comparison.Protocol` twins, whose <6.4 fork
// forms require explicitly-declared `borrowing` witnesses. The twin conformances (and the
// gated `#if swift(<6.4)` stdlib `Hashable` / `Comparable`) live in the
// `Axis Equation/Hash/Comparison Primitives` sub-targets. Axes order by `underlying`.

extension Axis {
    /// Returns whether two axes have the same `underlying` index.
    @inlinable
    public static func == (lhs: Axis, rhs: Axis) -> Bool {
        lhs.underlying == rhs.underlying
    }

    /// Returns whether `lhs` orders before `rhs` by `underlying` index.
    @inlinable
    public static func < (lhs: Axis, rhs: Axis) -> Bool {
        lhs.underlying < rhs.underlying
    }

    /// Returns whether `lhs` orders at or before `rhs` by `underlying` index.
    @inlinable
    public static func <= (lhs: Axis, rhs: Axis) -> Bool {
        lhs.underlying <= rhs.underlying
    }

    /// Returns whether `lhs` orders after `rhs` by `underlying` index.
    @inlinable
    public static func > (lhs: Axis, rhs: Axis) -> Bool {
        lhs.underlying > rhs.underlying
    }

    /// Returns whether `lhs` orders at or after `rhs` by `underlying` index.
    @inlinable
    public static func >= (lhs: Axis, rhs: Axis) -> Bool {
        lhs.underlying >= rhs.underlying
    }

    /// Feeds the `underlying` index into `hasher`.
    @inlinable
    public func hash(into hasher: inout Hasher) {
        hasher.combine(underlying)
    }
}

// MARK: - Codable

#if !hasFeature(Embedded)
    // swiftlint:disable no_any_protocol_existential
    // reason: stdlib protocol witnesses — Decodable.init(from:) / Encodable.encode(to:)
    // signatures mandate the existential Decoder / Encoder shape; the typed throws clause
    // uses `any Swift.Error` to mirror the protocol requirement's untyped throws. [API-ERR-006] exception.
    extension Axis: Codable {
        /// Decodes an axis from a single encoded `Int` index, validating its bounds.
        public init(from decoder: any Decoder) throws(any Swift.Error) {
            let container = try decoder.singleValueContainer()
            let value = try container.decode(Int.self)
            do {
                self = try Self(value)
            } catch {
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: decoder.codingPath,
                        debugDescription:
                            "Axis index \(value) out of bounds for \(N)-dimensional space"
                    )
                )
            }
        }

        /// Encodes this axis as its single `underlying` `Int` index.
        public func encode(to encoder: any Encoder) throws(any Swift.Error) {
            var container = encoder.singleValueContainer()
            try container.encode(underlying)
        }
    }
// swiftlint:enable no_any_protocol_existential
#endif

// MARK: - 1D

extension Axis where N == 1 {
    /// First axis (index 0).
    @inlinable
    public static var primary: Self { Self(_unchecked: (), 0) }
}

// MARK: - 2D

extension Axis where N == 2 {
    /// First axis (index 0, typically X/horizontal).
    @inlinable
    public static var primary: Self { Self(_unchecked: (), 0) }

    /// Second axis (index 1, typically Y/vertical).
    @inlinable
    public static var secondary: Self { Self(_unchecked: (), 1) }

    /// Returns the perpendicular axis of a 2D axis.
    ///
    /// In 2D, each axis has exactly one perpendicular: primary↔secondary.
    @inlinable
    public static func perpendicular(of axis: Self) -> Self {
        Self(_unchecked: (), 1 - axis.underlying)
    }

    /// Returns the perpendicular axis.
    ///
    /// In 2D, each axis has exactly one perpendicular: primary↔secondary.
    @inlinable
    public var perpendicular: Self {
        Self.perpendicular(of: self)
    }
}

// MARK: - 3D

extension Axis where N == 3 {
    /// First axis (index 0, typically X/horizontal).
    @inlinable
    public static var primary: Self { Self(_unchecked: (), 0) }

    /// Second axis (index 1, typically Y/vertical).
    @inlinable
    public static var secondary: Self { Self(_unchecked: (), 1) }

    /// Third axis (index 2, typically Z/depth).
    @inlinable
    public static var tertiary: Self { Self(_unchecked: (), 2) }
}

// MARK: - 4D

extension Axis where N == 4 {
    /// First axis (index 0, typically X).
    @inlinable
    public static var primary: Self { Self(_unchecked: (), 0) }

    /// Second axis (index 1, typically Y).
    @inlinable
    public static var secondary: Self { Self(_unchecked: (), 1) }

    /// Third axis (index 2, typically Z).
    @inlinable
    public static var tertiary: Self { Self(_unchecked: (), 2) }

    /// Fourth axis (index 3, typically W).
    @inlinable
    public static var quaternary: Self { Self(_unchecked: (), 3) }
}
