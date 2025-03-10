//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import RuntimeAssertions
import Testing


public func expectRuntimeAssertion<T, E: Error>(
    expectedCount: UInt = 1,
    _ comment: Comment? = nil,
    validateAssertion: (@Sendable (String) -> Void)? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: () throws(E) -> T
) throws(E) -> T {
    try withRuntimeAssertion(validateAssertion: validateAssertion, expression) { count in
        assertFulfillmentCount(count, expectedFulfillmentCount: expectedCount, comment, sourceLocation: sourceLocation)
    }
}


public func expectRuntimeAssertion<T, E: Error>(
    expectedCount: UInt = 1,
    _ comment: Comment? = nil,
    validateAssertion: (@Sendable (String) -> Void)? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: () async throws(E) -> T
) async throws(E) -> T {
    try await withRuntimeAssertion(validateAssertion: validateAssertion, expression) { count in
        assertFulfillmentCount(count, expectedFulfillmentCount: expectedCount, comment, sourceLocation: sourceLocation)
    }
}


private func assertFulfillmentCount(
    _ fulfillmentCount: Int,
    expectedFulfillmentCount: UInt,
    _ comment: Comment?,
    sourceLocation: SourceLocation
) {
    Swift.precondition(expectedFulfillmentCount > 0, "expectedFulfillmentCount has to be non-zero!")

    if fulfillmentCount != expectedFulfillmentCount {
        Issue.record(
             """
             Measured an fulfillment count of \(fulfillmentCount), expected \(expectedFulfillmentCount).
             \(comment?.description ?? "") at \(sourceLocation)
             """,
             sourceLocation: sourceLocation
        )
    }
}
