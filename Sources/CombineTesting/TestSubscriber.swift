
import Combine

/// A subscriber to use for testing custom Publishers.
public final class TestSubscriber<Input, Failure: Error> {
    public private(set) var events: [Event] = []
    public init() {}
}

extension TestSubscriber: Subscriber {

    public func receive(subscription: Subscription) {
        events.append(.subscription)
        subscription.request(.unlimited)
    }

    public func receive(_ input: Input) -> Subscribers.Demand {
        events.append(.input(input))
        return .unlimited
    }

    public func receive(completion: Subscribers.Completion<Failure>) {
        events.append(.completion(completion))
    }
}

extension TestSubscriber {

    /// Represents the events received by the TestSubscriber.
    public enum Event {
        case subscription
        case input(Input)
        case completion(Subscribers.Completion<Failure>)
    }
}

extension TestSubscriber.Event: Equatable where Input: Equatable, Failure: Equatable {

    public static func == (lhs: TestSubscriber.Event, rhs: TestSubscriber.Event) -> Bool {
        switch (lhs, rhs) {
        case (.subscription, .subscription): return true
        case (.input(let lhs), .input(let rhs)): return lhs == rhs
        case (.completion(.failure(let lhs)), .completion(.failure(let rhs))): return lhs == rhs
        case (.completion(.finished), .completion(.finished)): return true
        default: return false
        }
    }
}

extension TestSubscriber.Event: CustomStringConvertible {

    public var description: String {
        switch self {
        case .subscription: return ".subscription"
        case let .input(input): return ".input(\(input))"
        case let .completion(.failure(failure)): return "completion(.failure(\(failure.localizedDescription)))"
        case .completion(.finished): return "completion(.finished)"
        }
    }
}
