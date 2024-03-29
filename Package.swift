// swift-tools-version:5.9

//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


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
    targets: [
        .target(
            name: "XCTRuntimeAssertions"
        ),
        .testTarget(
            name: "XCTRuntimeAssertionsTests",
            dependencies: [
                .target(name: "XCTRuntimeAssertions")
            ]
        )
    ]
)
