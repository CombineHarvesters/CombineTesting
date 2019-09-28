
import Foundation

/// An error type to use for testing purposes.
public struct TestError: Error, Equatable {
    private let description: String
    public init(description: String) {
        self.description = description
    }
}

extension TestError: LocalizedError {
    public var errorDescription: String? { description }
}

extension TestError: ExpressibleByStringLiteral {
    public init(stringLiteral string: String) {
        self.init(description: string)
    }
}
