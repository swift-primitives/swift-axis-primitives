// Axis+Finite.Enumerable Tests.swift

import Axis_Primitives
import Axis_Primitives_Test_Support
import Testing

// MARK: - Axis+Finite.Enumerable - Enumerable

@Suite
struct `Axis+Finite.Enumerable - Enumerable` {
    @Test
    func `count equals dimension`() {
        #expect(Axis<1>.count == 1)
        #expect(Axis<2>.count == 2)
        #expect(Axis<3>.count == 3)
        #expect(Axis<4>.count == 4)
    }

    @Test
    func `ordinal matches index`() {
        #expect(Axis<3>.primary.underlying == 0)
        #expect(Axis<3>.primary.ordinal == 0)
        #expect(Axis<3>.secondary.underlying == 1)
        #expect(Axis<3>.secondary.ordinal == 1)
        #expect(Axis<3>.tertiary.underlying == 2)
        #expect(Axis<3>.tertiary.ordinal == 2)
    }

    @Test(arguments: [0, 1, 2])
    func `init from index creates correct axis`(index: Int) {
        let axis: Axis<3>? = try? Axis(index)
        #expect(axis != nil)
        #expect(axis?.underlying == index)
    }

    @Test(arguments: [0, 1, 2, 3])
    func `index roundtrip`(index: Int) {
        let axis: Axis<4>? = try? Axis(index)
        #expect(axis != nil)
        #expect(axis?.underlying == index)
        let reconstructed: Axis<4>? = try? Axis(axis!.underlying)
        #expect(reconstructed?.underlying == axis?.underlying)
    }
}

// MARK: - Axis+Finite.Enumerable - AllCases

@Suite
struct `Axis+Finite.Enumerable - AllCases` {
    @Test
    func `allCases for 1D has 1 element`() {
        let allCases = Array(Axis<1>.allCases)
        #expect(allCases.count == 1)
        #expect(allCases[0].underlying == 0)
    }

    @Test
    func `allCases for 2D has 2 elements`() {
        let allCases = Array(Axis<2>.allCases)
        #expect(allCases.count == 2)
        #expect(allCases[0] == .primary)
        #expect(allCases[1] == .secondary)
    }

    @Test
    func `allCases for 3D has 3 elements`() {
        let allCases = Array(Axis<3>.allCases)
        #expect(allCases.count == 3)
        #expect(allCases[0] == .primary)
        #expect(allCases[1] == .secondary)
        #expect(allCases[2] == .tertiary)
    }

    @Test
    func `allCases for 4D has 4 elements`() {
        let allCases = Array(Axis<4>.allCases)
        #expect(allCases.count == 4)
        #expect(allCases[0] == .primary)
        #expect(allCases[1] == .secondary)
        #expect(allCases[2] == .tertiary)
        #expect(allCases[3] == .quaternary)
    }

    @Test
    func `allCases are in order by index`() {
        let allCases = Array(Axis<4>.allCases)
        for (index, axis) in allCases.enumerated() {
            #expect(axis.underlying == index)
        }
    }
}

// MARK: - Axis+Finite.Enumerable - Iteration

@Suite
struct `Axis+Finite.Enumerable - Iteration` {
    @Test
    func `for-in loop over allCases`() {
        var indices: [Int] = []
        for axis in Axis<3>.allCases {
            indices.append(axis.underlying)
        }
        #expect(indices == [0, 1, 2])
    }

    @Test
    func `allCases supports RandomAccessCollection operations`() {
        let allCases = Axis<5>.allCases
        #expect(allCases.count == 5)
        #expect(allCases[2].underlying == 2)
        #expect(allCases.first?.underlying == 0)
        #expect(allCases.last?.underlying == 4)
    }
}
