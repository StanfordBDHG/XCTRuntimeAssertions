//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//


package func withRuntimeAssertion<T, E: Error>(
    validateAssertion: (@Sendable (String) -> Void)?,
    _ expression: () throws(E) -> T,
    validate: (Int) -> Void
) throws(E) -> T {
    let counter = Counter()
    let injection = setupRuntimeAssertionInjection(fulfillmentCount: counter, validate: validateAssertion)

    var result: Result<T, E>
    do {
        result = .success(try expression())
    } catch {
        result = .failure(error)
    }

    injection.remove()

    validate(counter.count)

    return try result.get()
}


package func withRuntimeAssertion<T, E: Error>(
    validateAssertion: (@Sendable (String) -> Void)?,
    _ expression: () async throws(E) -> T,
    validate: (Int) -> Void
) async throws(E) -> T {
    let counter = Counter()
    let injection = setupRuntimeAssertionInjection(fulfillmentCount: counter, validate: validateAssertion)

    var result: Result<T, E>
    do {
        result = .success(try await expression())
    } catch {
        result = .failure(error)
    }

    injection.remove()

    validate(counter.count)

    return try result.get()
}


private func setupRuntimeAssertionInjection(
    fulfillmentCount: Counter,
    validate: (@Sendable (String) -> Void)?
) -> RuntimeAssertionInjection {
    let injection = RuntimeAssertionInjection(assert: { condition, message, _, _  in
        if !condition() {
            // We execute the message closure independent of the availability of the `validateRuntimeAssertion` closure.
            let message = message()
            validate?(message)
            fulfillmentCount.increment()
        }
    })

    injection.inject()
    return injection
}
