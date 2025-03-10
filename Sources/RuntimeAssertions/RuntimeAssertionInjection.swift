//
// This source file is part of the Stanford XCTRuntimeAssertions open-source project
//
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
//
// SPDX-License-Identifier: MIT
//

import Foundation


@usableFromInline
package final class RuntimeAssertionInjection {
    @usableFromInline package typealias AssertCall = @Sendable (() -> Bool, () -> String, StaticString, UInt) -> Void
    @usableFromInline package typealias PreconditionCall = @Sendable (() -> Bool, () -> String, StaticString, UInt) -> Void

    
    @usableFromInline static let injection = RuntimeInjections()

    
    @usableFromInline package let id: UUID
    @usableFromInline let assert: AssertCall
    @usableFromInline let precondition: PreconditionCall

    
    package init(
        id: UUID = UUID(),
        assert: @escaping AssertCall,
        precondition: @escaping PreconditionCall
    ) {
        self.id = id
        self.assert = assert
        self.precondition = precondition
    }
    
    package init(
        id: UUID = UUID(),
        assert: @escaping AssertCall
    ) {
        self.id = id
        self.assert = assert
        self.precondition = { @Sendable condition, message, file, line in
            Swift.precondition(condition(), message(), file: file, line: line)
        }
    }
    
    package init(
        id: UUID = UUID(),
        precondition: @escaping PreconditionCall
    ) {
        self.id = id
        self.assert = { @Sendable condition, message, file, line in
            Swift.assert(condition(), message(), file: file, line: line)
        }
        self.precondition = precondition
    }
    
    package init(
        id: UUID = UUID()
    ) {
        self.id = id
        self.assert = { @Sendable condition, message, file, line in
            Swift.assert(condition(), message(), file: file, line: line)
        }
        self.precondition = { @Sendable condition, message, file, line in
            Swift.precondition(condition(), message(), file: file, line: line)
        }
    }

    @inlinable
    package func inject() {
        Self.injection.append(self)
    }

    @inlinable
    package func remove() {
        Self.injection.removeAll(for: self.id)
    }

    deinit {
        remove()
    }
}


extension RuntimeAssertionInjection {
    @inlinable
    static func assert(_ condition: () -> Bool, message: () -> String, file: StaticString, line: UInt) {
        if injection.isEmpty {
            Swift.assert(condition(), message(), file: file, line: line)
        }

        for runtimeAssertionInjector in injection.injections {
            runtimeAssertionInjector.assert(condition, message, file, line)
        }
    }

    @inlinable
    static func precondition(_ condition: () -> Bool, message: () -> String, file: StaticString, line: UInt) {
        if injection.isEmpty {
            Swift.precondition(condition(), message(), file: file, line: line)
        }

        for runtimeAssertionInjector in injection.injections {
            runtimeAssertionInjector.precondition(condition, message, file, line)
        }
    }
}
