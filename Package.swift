// swift-tools-version:5.9

//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import class Foundation.ProcessInfo
import PackageDescription

#if swift(<6)
let swiftConcurrency: SwiftSetting = .enableExperimentalFeature("StrictConcurrency")
#else
let swiftConcurrency: SwiftSetting = .enableUpcomingFeature("StrictConcurrency")
#endif


let package = Package(
    name: "XCTRuntimeAssertions",
    platforms: [
        .iOS(.v16),
        .visionOS(.v1),
        .watchOS(.v9),
        .tvOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(name: "XCTRuntimeAssertions", targets: ["XCTRuntimeAssertions"])
    ],
    dependencies: swiftLintPackage(),
    targets: [
        .target(
            name: "XCTRuntimeAssertions",
            swiftSettings: [
                swiftConcurrency
            ],
            plugins: [] + swiftLintPlugin()
        ),
        .testTarget(
            name: "XCTRuntimeAssertionsTests",
            dependencies: [
                .target(name: "XCTRuntimeAssertions")
            ],
            swiftSettings: [
                swiftConcurrency
            ],
            plugins: [] + swiftLintPlugin()
        )
    ]
)

func swiftLintPlugin() -> [Target.PluginUsage] {
    // Fully quit Xcode and open again with `open --env SPEZI_DEVELOPMENT_SWIFTLINT /Applications/Xcode.app`
    if ProcessInfo.processInfo.environment["SPEZI_DEVELOPMENT_SWIFTLINT"] != nil {
        [.plugin(name: "SwiftLintBuildToolPlugin", package: "SwiftLint")]
    } else {
        []
    }
}

func swiftLintPackage() -> [PackageDescription.Package.Dependency] {
    if ProcessInfo.processInfo.environment["SPEZI_DEVELOPMENT_SWIFTLINT"] != nil {
        [.package(url: "https://github.com/realm/SwiftLint.git", from: "0.55.1")]
    } else {
        []
    }
}
