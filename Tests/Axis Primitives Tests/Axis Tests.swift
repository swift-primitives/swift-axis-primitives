// Axis Tests.swift

import Testing

import Axis_Primitives

// MARK: - Axis - Static Functions

@Suite
struct `Axis - Static Functions` {
    @Test(arguments: [Axis<2>.primary, Axis<2>.secondary])
    func `perpendicular is involution in 2D`(axis: Axis<2>) {
        let perp1 = Axis<2>.perpendicular(of: axis)
        let perp2 = Axis<2>.perpendicular(of: perp1)
        #expect(perp2 == axis)
    }

    @Test
    func `perpendicular maps primary to secondary in 2D`() {
        #expect(Axis<2>.perpendicular(of: .primary) == .secondary)
    }

    @Test
    func `perpendicular maps secondary to primary in 2D`() {
        #expect(Axis<2>.perpendicular(of: .secondary) == .primary)
    }
}

// MARK: - Axis - Properties

@Suite
struct `Axis - Properties` {
    @Test(arguments: [Axis<2>.primary, Axis<2>.secondary])
    func `perpendicular property delegates to static function`(axis: Axis<2>) {
        #expect(axis.perpendicular == Axis<2>.perpendicular(of: axis))
    }

    @Test(arguments: [0, 1, 2, 3])
    func `underlying accessor`(value: Int) {
        let axis: Axis<5>? = try? Axis(value)
        #expect(axis?.underlying == value)
    }
}

// MARK: - Axis - Initializers

@Suite
struct `Axis - Initializers` {
    @Test(arguments: [0, 1, 2, 3, 4])
    func `init with valid index`(value: Int) {
        let axis: Axis<5>? = try? Axis(value)
        #expect(axis != nil)
        #expect(axis?.underlying == value)
    }

    @Test(arguments: [-1, 5, 10])
    func `init with invalid index returns nil`(value: Int) {
        let axis: Axis<5>? = try? Axis(value)
        #expect(axis == nil)
    }

    @Test
    func `init throws outOfBounds for negative index`() {
        #expect(throws: Axis<3>.Error.outOfBounds(-1)) {
            _ = try Axis<3>(-1)
        }
    }

    @Test
    func `init throws outOfBounds for index at N`() {
        #expect(throws: Axis<3>.Error.outOfBounds(3)) {
            _ = try Axis<3>(3)
        }
    }
}

// MARK: - Axis - Dimension-Specific Constants

@Suite
struct `Axis - Dimension-Specific Constants` {
    @Test
    func `1D has only primary`() {
        #expect(Axis<1>.primary.underlying == 0)
    }

    @Test
    func `2D has primary and secondary`() {
        #expect(Axis<2>.primary.underlying == 0)
        #expect(Axis<2>.secondary.underlying == 1)
    }

    @Test
    func `3D has primary secondary and tertiary`() {
        #expect(Axis<3>.primary.underlying == 0)
        #expect(Axis<3>.secondary.underlying == 1)
        #expect(Axis<3>.tertiary.underlying == 2)
    }

    @Test
    func `4D has primary secondary tertiary and quaternary`() {
        #expect(Axis<4>.primary.underlying == 0)
        #expect(Axis<4>.secondary.underlying == 1)
        #expect(Axis<4>.tertiary.underlying == 2)
        #expect(Axis<4>.quaternary.underlying == 3)
    }
}

// MARK: - Axis - Protocol Conformances

@Suite
struct `Axis - Protocol Conformances` {
    @Test
    func `Equatable reflexivity`() {
        #expect(Axis<2>.primary == Axis<2>.primary)
        #expect(Axis<3>.tertiary == Axis<3>.tertiary)
    }

    @Test
    func `Equatable distinguishes axes`() {
        #expect(Axis<2>.primary != Axis<2>.secondary)
        #expect(Axis<3>.primary != Axis<3>.tertiary)
    }

    @Test
    func `Hashable produces unique hashes`() {
        let set: Set<Axis<3>> = [.primary, .secondary, .tertiary, .primary]
        #expect(set.count == 3)
    }
}

// MARK: - Axis - Type Safety

@Suite
struct `Axis - Type Safety` {
    @Test
    func `Axes of different dimensions have same index but different types`() {
        let axis2: Axis<2> = .primary
        let axis3: Axis<3> = .primary

        // Same index value
        #expect(axis2.underlying == axis3.underlying)
        #expect(axis2.underlying == 0)

        // But different types — cannot compare directly (compile-time safety):
        // axis2 == axis3  // would not compile
    }

    @Test
    func `Functions accepting specific dimensions enforce type safety`() {
        func process2D(_ axis: Axis<2>) -> Int {
            axis.underlying
        }

        let axis2: Axis<2> = .secondary
        #expect(process2D(axis2) == 1)

        // This would NOT compile — type safety prevents dimensional mismatch:
        // let axis3: Axis<3> = .secondary
        // process2D(axis3)  // Error: cannot convert Axis<3> to Axis<2>
    }
}
