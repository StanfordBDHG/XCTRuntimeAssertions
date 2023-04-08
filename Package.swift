// swift-tools-version:5.8

//
// This source file is part of the CardinalKit open-source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "XCTRuntimeAssertions",
    platforms: [
        .iOS(.v16)
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
