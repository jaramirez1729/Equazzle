//
//  QuizWorkerTests.swift
//  EquazzleTests
//
//  Created by J.A. Ramirez on 4/6/21.
//

import XCTest
@testable import Equazzle

class QuizWorkerTests: XCTestCase {
    func testCorrectAnswersEqualAnswer() {
        // Given
        let worker = QuizWorker()
        // When
        worker.loadNewQuiz()
        // Then
        let answer = worker.operation.compute(lhs: Double(worker.firstAnswer),
                                              rhs: Double(worker.secondAnswer))
        XCTAssertNotEqual(worker.answer, 0)
        XCTAssertEqual(answer, worker.answer)
    }
    
    func testValidAnswersExistInList() {
        // Given
        let worker = QuizWorker()
        // When
        worker.loadNewQuiz()
        // Then
        XCTAssertTrue(worker.answers.contains(worker.firstAnswer))
        XCTAssertTrue(worker.answers.contains(worker.secondAnswer))
    }
    
    func testAnswersAreUnique() {
        // Given
        let worker = QuizWorker()
        // When
        worker.loadNewQuiz()
        // Then
        XCTAssertEqual(Set(worker.answers).count, 4)
    }
    
    func testDefaultListIfNonHalting() {
        // Given
        let worker = QuizWorker()
        worker.counterLimit = 1
        // When
        worker.loadNewQuiz()
        // Then
        XCTAssertEqual(worker.answers.sorted(), [3, 4, 5, 6])
    }
}
