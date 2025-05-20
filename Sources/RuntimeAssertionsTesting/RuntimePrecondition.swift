//
// This source file is part of the Stanford RuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation
import RuntimeAssertions
import Testing


/// Test assertions that use `precondition` or `preconditionFailure` of the `RuntimeAssertions` library.
///
/// - Important: The `expression` is executed on a background thread, even though it is not annotated as `@Sendable`. This is by design. Preconditions return `Never` and, therefore,
/// need to be run on a separate thread that can block forever. Without this workaround, testing preconditions that are isolated to `@MainActor` would be impossible.
/// Make sure to only run isolated parts of your code that don't suffer from concurrency issues in such a scenario.
///
/// - Parameters:
///   - timeout: A timeout defining how long to wait for the precondition to be triggered.
///   - comment: A comment describing the expectation.
///   - sourceLocation: The source location to which recorded expectations and issues should be attributed.
///   - expression: The expression to be evaluated.
///   - precondition: Validate and handle the contents of the precondition.
public func expectRuntimePrecondition(
    timeout: TimeInterval = 2,
    _ comment: Comment? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: @escaping () -> Void,
    precondition: (@Sendable (String) -> Void)? = nil
) {
    withRuntimePrecondition(timeout: timeout, validatePrecondition: precondition, expression) { count in
        assertFulfillmentCount(count, expected: 1, comment, sourceLocation: sourceLocation)
    }
}

/// Test the absence of assertions that use `precondition` or `preconditionFailure` of the `RuntimeAssertions` library.
///
/// - Important: The `expression` is executed on a background thread, even though it is not annotated as `@Sendable`. This is by design. Preconditions return `Never` and, therefore,
/// need to be run on a separate thread that can block forever. Without this workaround, testing preconditions that are isolated to `@MainActor` would be impossible.
/// Make sure to only run isolated parts of your code that don't suffer from concurrency issues in such a scenario.
///
/// - Parameters:
///   - timeout: A timeout defining how long to wait for the precondition to be triggered.
///   - comment: A comment describing the expectation.
///   - sourceLocation: The source location to which recorded expectations and issues should be attributed.
///   - expression: The expression to be evaluated.
///   - precondition: Validate and handle the contents of the precondition.
public func expectNoRuntimePrecondition(
    timeout: TimeInterval = 2,
    _ comment: Comment? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: @escaping () -> Void,
    precondition: (@Sendable (String) -> Void)? = nil
) {
    withRuntimePrecondition(timeout: timeout, validatePrecondition: precondition, expression) { count in
        assertFulfillmentCount(count, expected: 0, comment, sourceLocation: sourceLocation)
    }
}


/// Test assertions that use `precondition` or `preconditionFailure` of the `RuntimeAssertions` library.
/// 
/// - Important: The `expression` is executed on a background thread, even though it is not annotated as `@Sendable`. This is by design. Preconditions return `Never` and, therefore,
/// need to be run on a separate thread that can block forever. Without this workaround, testing preconditions that are isolated to `@MainActor` would be impossible.
/// Make sure to only run isolated parts of your code that don't suffer from concurrency issues in such a scenario.
/// 
/// - Parameters:
///   - timeout: A timeout defining how long to wait for the precondition to be triggered.
///   - comment: A comment describing the expectation.
///   - sourceLocation: The source location to which recorded expectations and issues should be attributed.
///   - expression: The expression to be evaluated.
///   - precondition: Validate and handle the contents of the precondition.
public func expectRuntimePrecondition(
    timeout: TimeInterval = 2,
    _ comment: Comment? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: @escaping () async -> Void,
    precondition: (@Sendable (String) -> Void)? = nil
) {
    withRuntimePrecondition(timeout: timeout, validatePrecondition: precondition, expression) { count in
        assertFulfillmentCount(count, expected: 1, comment, sourceLocation: sourceLocation)
    }
}

/// Test the absence of assertions that use `precondition` or `preconditionFailure` of the `RuntimeAssertions` library.
///
/// - Important: The `expression` is executed on a background thread, even though it is not annotated as `@Sendable`. This is by design. Preconditions return `Never` and, therefore,
/// need to be run on a separate thread that can block forever. Without this workaround, testing preconditions that are isolated to `@MainActor` would be impossible.
/// Make sure to only run isolated parts of your code that don't suffer from concurrency issues in such a scenario.
///
/// - Parameters:
///   - timeout: A timeout defining how long to wait for the precondition to be triggered.
///   - comment: A comment describing the expectation.
///   - sourceLocation: The source location to which recorded expectations and issues should be attributed.
///   - expression: The expression to be evaluated.
///   - precondition: Validate and handle the contents of the precondition.
public func expectNoRuntimePrecondition(
    timeout: TimeInterval = 2,
    _ comment: Comment? = nil,
    sourceLocation: SourceLocation = #_sourceLocation,
    _ expression: @escaping () async -> Void,
    precondition: (@Sendable (String) -> Void)? = nil
) {
    withRuntimePrecondition(timeout: timeout, validatePrecondition: precondition, expression) { count in
        assertFulfillmentCount(count, expected: 0, comment, sourceLocation: sourceLocation)
    }
}


/// - parameter expected: the expected number of `precondition` or `preconditionFailure` calls.
private func assertFulfillmentCount(
    _ fulfillmentCount: Int,
    expected: UInt,
    _ comment: Comment?,
    sourceLocation: SourceLocation
) {
    guard fulfillmentCount != expected else {
        // everything is fine
        return
    }
    if expected > fulfillmentCount {
        Issue.record(
            """
            The precondition was called too many times (expected \(expected); got \(fulfillmentCount)).
            \(comment?.description ?? "") at \(sourceLocation)
            """,
            sourceLocation: sourceLocation
        )
    } else {
        Issue.record(
            """
            The precondition was called too few times (expected \(expected); got \(fulfillmentCount)).
            \(comment?.description ?? "") at \(sourceLocation)
            """,
            sourceLocation: sourceLocation
        )
    }
}
