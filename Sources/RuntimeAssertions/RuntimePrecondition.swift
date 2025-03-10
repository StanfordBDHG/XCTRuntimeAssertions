//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


private struct UnsafeSendable<Value>: @unchecked Sendable {
    let value: Value
}


package func withRuntimePrecondition(
    timeout: TimeInterval,
    validatePrecondition: (@Sendable (String) -> Void)?,
    _ expression: @escaping () -> Void,
    validate: (Int) -> Void
) {
    let counter = Counter()
    let injection = setupRuntimePreconditionInjection(fulfillmentCount: counter, validate: validatePrecondition)

    // We have to run the operation on a `DispatchQueue` as we have to call `RunLoop.current.run()` in the `preconditionFailure` call.
    let dispatchQueue = DispatchQueue(label: "RuntimePrecondition-\(injection.id)")

    let expressionWorkItem = DispatchWorkItem {
        expression()
    }
    dispatchQueue.async(execute: expressionWorkItem)

    // We don't use:
    // `wait(for: [expectation], timeout: timeout)`
    // here as we need to make the method independent of XCTestCase to also use it in our TestApp UITest target which fails if you import XCTest.
    usleep(useconds_t(1_000_000 * timeout))
    expressionWorkItem.cancel()

    injection.remove()

    validate(counter.count)
}


package func withRuntimePrecondition(
    timeout: TimeInterval,
    validatePrecondition: (@Sendable (String) -> Void)?,
    _ expression: @escaping () async -> Void,
    validate: (Int) -> Void
) {
    let counter = Counter()
    let injection = setupRuntimePreconditionInjection(fulfillmentCount: counter, validate: validatePrecondition)

    let expressionClosure = UnsafeSendable(value: expression)
    let task = Task {
        await expressionClosure.value()
    }

    // We don't use:
    // `wait(for: [expectation], timeout: timeout)`
    // here as we need to make the method independent of XCTestCase to also use it in our TestApp UITest target which fails if you import XCTest.
    usleep(useconds_t(1_000_000 * timeout))
    task.cancel()

    injection.remove()

    validate(counter.count)
}


private func setupRuntimePreconditionInjection(
    fulfillmentCount: Counter,
    validate: (@Sendable (String) -> Void)?
) -> RuntimeAssertionInjection {
    let injection = RuntimeAssertionInjection(precondition: { condition, message, _, _  in
        if !condition() {
            // We execute the message closure independent of the availability of the `validateRuntimeAssertion` closure.
            let message = message()
            validate?(message)
            fulfillmentCount.increment()
            neverReturn()
        }
    })

    injection.inject()

    return injection
}
