
import Combine
import CombineTesting
import XCTest

final class TestSubscriberTests: XCTestCase {

    func testInput() {
        let just = Just(12)
        let subscriber = TestSubscriber<Int, Never>()
        just.subscribe(subscriber)
        XCTAssertEqual(subscriber.events, [
            .subscription,
            .input(12),
            .completion(.finished)
        ])
    }

    func testMultipleInputs() {
        let subject = PassthroughSubject<Int, Never>()
        let subscriber = TestSubscriber<Int, Never>()
        subject.subscribe(subscriber)
        subject.send(1)
        subject.send(2)
        XCTAssertEqual(subscriber.events, [
            .subscription,
            .input(1),
            .input(2)
        ])
    }

    func testCompletionFinished() {
        let subject = PassthroughSubject<Int, Never>()
        let subscriber = TestSubscriber<Int, Never>()
        subject.subscribe(subscriber)
        subject.send(completion: .finished)
        XCTAssertEqual(subscriber.events, [
            .subscription,
            .completion(.finished)
        ])
    }

    func testCompletionFailure() {
        let subject = PassthroughSubject<Int, TestError>()
        let subscriber = TestSubscriber<Int, TestError>()
        subject.subscribe(subscriber)
        subject.send(completion: .failure("Error!"))

        XCTAssertEqual(subscriber.events, [
            .subscription,
            .completion(.failure("Error!"))
        ])
    }
}
