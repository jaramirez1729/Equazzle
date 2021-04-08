//
//  QuizViewModelTests.swift
//  EquazzleTests
//
//  Created by J.A. Ramirez on 4/5/21.
//

import XCTest
@testable import Equazzle

class QuizViewModelTests: XCTestCase {
    // MARK: - Unit Tests
    func testSelectedChoicesMatchChosenChoices() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        let firstChoice = viewModel.quizWorker.firstAnswer
        let secondChoice = viewModel.quizWorker.secondAnswer
        // When
        viewModel.selectedChoice(with: firstChoice, for: 1)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        // Then
        XCTAssertEqual(viewModel.selectedChoices, [firstChoice, secondChoice])
    }
    
    func testSelectedChoicesResetWhenRemovingChoices() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        let firstChoice = viewModel.quizWorker.firstAnswer
        let secondChoice = viewModel.quizWorker.secondAnswer
        // When
        viewModel.selectedChoice(with: firstChoice, for: 1)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        viewModel.selectedChoice(with: firstChoice, for: 1)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        // Then
        XCTAssertEqual(viewModel.selectedChoices, [0, 0])
    }
    
    func testButtonOneStateIsOnWhenSelected() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        // When
        viewModel.selectedChoice(with: viewModel.answers[0], for: 1)
        // Then
        XCTAssertTrue(viewModel.buttonOneSelectState.value ?? false)
    }
    
    func testButtonTwoStateIsOnWhenSelected() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        // When
        viewModel.selectedChoice(with: viewModel.answers[1], for: 2)
        // Then
        XCTAssertTrue(viewModel.buttonTwoSelectState.value ?? false)
    }
    
    func testButtonThreeStateIsOnWhenSelected() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        // When
        viewModel.selectedChoice(with: viewModel.answers[2], for: 3)
        // Then
        XCTAssertTrue(viewModel.buttonThreeSelectState.value ?? false)
    }
    
    func testButtonFourStateIsOnWhenSelected() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        // When
        viewModel.selectedChoice(with: viewModel.answers[3], for: 4)
        // Then
        XCTAssertTrue(viewModel.buttonFourSelectState.value ?? false)
    }
    
    func testButtonStateIsOffWhenSelectedAgain() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        // When
        viewModel.selectedChoice(with: viewModel.answers[0], for: 1)
        XCTAssertTrue(viewModel.buttonOneSelectState.value ?? false)
        viewModel.selectedChoice(with: viewModel.answers[0], for: 1)
        // Then
        XCTAssertFalse(viewModel.buttonOneSelectState.value ?? true)
    }

    func testEquationUpdatesWithDifferentChoices() {
        // Given
        let viewModel = QuizViewModel()
        let worker = viewModel.quizWorker
        viewModel.loadNewQuiz()
        let firstChoice = viewModel.answers[0]
        let secondChoice = viewModel.answers[1]
        // When
        viewModel.selectedChoice(with: firstChoice, for: 1)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        // Then
        let symbol = worker.operation.symbol
        let equation = "\(firstChoice)  \(symbol)  \(secondChoice)  =  \(worker.answer)"
        XCTAssertEqual(viewModel.equationText.value, equation)
    }
    
    func testEquationRemovesFirstChoiceWhenSameChoice() {
        // Given
        let viewModel = QuizViewModel()
        let worker = viewModel.quizWorker
        viewModel.loadNewQuiz()
        let choice = viewModel.answers[0]
        // When
        viewModel.selectedChoice(with: choice, for: 1)
        viewModel.selectedChoice(with: choice, for: 1)
        // Then
        let symbol = worker.operation.symbol
        let equation = "_  \(symbol)  _  =  \(worker.answer)"
        XCTAssertEqual(viewModel.equationText.value, equation)
    }
    
    
    func testEquationRemovesSecondChoiceWhenSameChoice() {
        // Given
        let viewModel = QuizViewModel()
        let worker = viewModel.quizWorker
        viewModel.loadNewQuiz()
        let firstChoice = viewModel.answers[0]
        let secondChoice = viewModel.answers[1]
        // When
        viewModel.selectedChoice(with: firstChoice, for: 1)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        // Then
        let symbol = worker.operation.symbol
        let equation = "\(firstChoice)  \(symbol)  _  =  \(worker.answer)"
        XCTAssertEqual(viewModel.equationText.value, equation)
    }
    
    func testSubmissionInvalidWithNoChoices() {
        continueAfterFailure = false
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        // When
        viewModel.verifySelectedAnswers()
        // Then
        XCTAssertFalse(viewModel.submitButtonState.value ?? true)
    }

    // MARK: - Integration Tests
    func testSubmissionValidWithCorrectChoices() {
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        let firstChoice = viewModel.quizWorker.firstAnswer
        let secondChoice = viewModel.quizWorker.secondAnswer
        // When
        viewModel.selectedChoice(with: firstChoice, for: 1)
        viewModel.selectedChoice(with: secondChoice, for: 2)
        viewModel.verifySelectedAnswers()
        // Then
        XCTAssertTrue(viewModel.submitButtonState.value ?? false)
    }
    
    func testSubmissionInvalidWithInvalidChoices() {
        continueAfterFailure = false
        // Given
        let viewModel = QuizViewModel()
        viewModel.loadNewQuiz()
        var invalidAnswers = viewModel.quizWorker.answers
        invalidAnswers.removeAll { $0 == viewModel.quizWorker.firstAnswer }
        invalidAnswers.removeAll { $0 == viewModel.quizWorker.secondAnswer }
        XCTAssertEqual(invalidAnswers.count, 2)
        // When
        viewModel.selectedChoice(with: invalidAnswers[0], for: 1)
        viewModel.selectedChoice(with: invalidAnswers[1], for: 2)
        viewModel.verifySelectedAnswers()
        // Then
        XCTAssertFalse(viewModel.submitButtonState.value ?? true)
    }
}
