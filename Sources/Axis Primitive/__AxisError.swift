/// Error thrown when `Axis<N>` construction fails.
///
/// Hoisted to module scope (non-generic) rather than nested in `Axis<N>`:
/// the cases never use `N`, so a nested form is an accidentally-generic
/// `@error` SIL result that can trip `FunctionSignatureOpts` under
/// `-O -enable-default-cmo` (swiftlang/swift#89617). `Axis<N>.Error` still
/// resolves via the `public typealias Error` on `Axis` — behaviour-preserving.
public enum __AxisError: Swift.Error, Hashable, Sendable {
    /// The provided value was outside the valid range `0..<N`.
    case outOfBounds(Int)
}
