//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2025 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


@usableFromInline
final class RuntimeInjections: Sendable {
    @usableFromInline nonisolated(unsafe) var injected: [RuntimeAssertionInjection] = []
    @usableFromInline let lock = NSLock()

    @inlinable var isEmpty: Bool {
        injected.isEmpty
    }

    @inlinable var injections: [RuntimeAssertionInjection] {
        lock.withLock {
            injected
        }
    }

    init() {}

    @inlinable
    func append(_ element: RuntimeAssertionInjection) {
        lock.withLock {
            injected.append(element)
        }
    }

    @inlinable
    func removeAll(for id: UUID) {
        lock.withLock {
            injected.removeAll(where: { $0.id == id })
        }
    }
}
