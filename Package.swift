// swift-tools-version: 6.3.1
import PackageDescription

let package = Package(
    name: "swift-axis-primitives",
    platforms: [
        .macOS(.v26),
        .iOS(.v26),
        .tvOS(.v26),
        .watchOS(.v26),
        .visionOS(.v26),
    ],
    products: [
        // MARK: - Namespace
        .library(
            name: "Axis Primitive",
            targets: ["Axis Primitive"]
        ),

        // MARK: - Sub-namespace targets
        .library(
            name: "Axis Equation Primitives",
            targets: ["Axis Equation Primitives"]
        ),
        .library(
            name: "Axis Hash Primitives",
            targets: ["Axis Hash Primitives"]
        ),
        .library(
            name: "Axis Comparison Primitives",
            targets: ["Axis Comparison Primitives"]
        ),
        .library(
            name: "Axis Enumerable Primitives",
            targets: ["Axis Enumerable Primitives"]
        ),

        // MARK: - Umbrella
        .library(
            name: "Axis Primitives",
            targets: ["Axis Primitives"]
        ),

        // MARK: - Test Support
        .library(
            name: "Axis Primitives Test Support",
            targets: ["Axis Primitives Test Support"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-primitives/swift-equation-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-hash-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-comparison-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-finite-primitives.git", branch: "main"),
        .package(url: "https://github.com/swift-primitives/swift-ordinal-primitives.git", branch: "main"),
    ],
    targets: [
        // MARK: - Namespace (zero external dependencies — [MOD-017])
        .target(
            name: "Axis Primitive",
            dependencies: []
        ),

        // MARK: - Sub-namespace targets (per [MOD-031])
        // Institute Equatable/Hashable/Comparable twins:
        .target(
            name: "Axis Equation Primitives",
            dependencies: [
                "Axis Primitive",
                .product(name: "Equation Primitives", package: "swift-equation-primitives"),
            ]
        ),
        .target(
            name: "Axis Hash Primitives",
            dependencies: [
                "Axis Primitive",
                .product(name: "Hash Primitives", package: "swift-hash-primitives"),
            ]
        ),
        .target(
            name: "Axis Comparison Primitives",
            dependencies: [
                "Axis Primitive",
                .product(name: "Comparison Primitives", package: "swift-comparison-primitives"),
            ]
        ),
        // Finite.Enumerable conformance (2N inhabitants enumeration):
        .target(
            name: "Axis Enumerable Primitives",
            dependencies: [
                "Axis Primitive",
                .product(name: "Finite Primitives", package: "swift-finite-primitives"),
                .product(name: "Ordinal Primitives", package: "swift-ordinal-primitives"),
            ]
        ),

        // MARK: - Umbrella
        .target(
            name: "Axis Primitives",
            dependencies: [
                "Axis Primitive",
                "Axis Equation Primitives",
                "Axis Hash Primitives",
                "Axis Comparison Primitives",
                "Axis Enumerable Primitives",
            ]
        ),

        // MARK: - Test Support
        .target(
            name: "Axis Primitives Test Support",
            dependencies: [
                "Axis Primitives",
                .product(name: "Ordinal Primitives Test Support", package: "swift-ordinal-primitives"),
            ],
            path: "Tests/Support"
        ),

        // MARK: - Tests
        .testTarget(
            name: "Axis Primitives Tests",
            dependencies: [
                "Axis Primitives",
                "Axis Primitives Test Support",
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    let ecosystem: [SwiftSetting] = [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableExperimentalFeature("LifetimeDependence"),
        .enableExperimentalFeature("Lifetimes"),
        .enableExperimentalFeature("SuppressedAssociatedTypes"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableUpcomingFeature("LifetimeDependence"),
    ]

    let package: [SwiftSetting] = []

    target.swiftSettings = (target.swiftSettings ?? []) + ecosystem + package
}
