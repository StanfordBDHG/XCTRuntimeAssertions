//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
import RuntimeAssertions
import Testing


public func expectRuntimePrecondition(
    timeout: TimeInterval = 1,
    _ comment: Comment? = nil,
    validatePrecondition: (@Sendable (String) -> Void)? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: @escaping () -> Void
) {
    withRuntimePrecondition(timeout: timeout, validatePrecondition: validatePrecondition, expression) { count in
        assertFulfillmentCount(count, comment, sourceLocation: sourceLocation)
    }
}


public func expectRuntimePrecondition(
    timeout: TimeInterval = 1,
    _ comment: Comment? = nil,
    validatePrecondition: (@Sendable (String) -> Void)? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: @escaping () async -> Void
) {
    withRuntimePrecondition(timeout: timeout, validatePrecondition: validatePrecondition, expression) { count in
        assertFulfillmentCount(count, comment, sourceLocation: sourceLocation)
    }
}


private func assertFulfillmentCount(
    _ fulfillmentCount: Int,
    _ comment: Comment? = nil,
    sourceLocation: SourceLocation
) {
    if fulfillmentCount <= 0 {
        Issue.record(
            """
            The precondition was never called.
            \(comment?.description ?? "") at \(sourceLocation)
            """,
            sourceLocation: sourceLocation
        )
    } else if fulfillmentCount > 1 {
        Issue.record(
            """
            The precondition was called multiple times (\(fulfillmentCount)).
            \(comment?.description ?? "") at \(sourceLocation)
            """,
            sourceLocation: sourceLocation
        )
    }
}
