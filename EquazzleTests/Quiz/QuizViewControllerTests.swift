//
//  QuizViewControllerTests.swift
//  EquazzleTests
//
//  Created by J.A. Ramirez on 4/5/21.
//

import XCTest
@testable import Equazzle

class QuizViewControllerTests: XCTestCase {
    // MARK: - Unit Tests
    func testEquationLabelUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.equationText.value = "3+5=8"
        // Then
        XCTAssertEqual(sut.equationLabel.text, "3+5=8")
    }
    
    func testButtonOneTitleUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonOneText.value = "2"
        // Then
        XCTAssertEqual(sut.choiceOneButton.title(for: .normal), "2")
    }
    
    func testButtonTwoTitleUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonTwoText.value = "3"
        // Then
        XCTAssertEqual(sut.choiceTwoButton.title(for: .normal), "3")
    }
    
    func testButtonThreeTitleUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonThreeText.value = "5"
        // Then
        XCTAssertEqual(sut.choiceThreeButton.title(for: .normal), "5")
    }
    
    func testButtonFourTitleUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonFourText.value = "7"
        // Then
        XCTAssertEqual(sut.choiceFourButton.title(for: .normal), "7")
    }
    
    func testButtonOneStateUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonOneSelectState.value = true
        // Then
        XCTAssertTrue(sut.choiceOneButton.inSelectedState)
    }
    
    func testButtonTwoStateUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonTwoSelectState.value = true
        // Then
        XCTAssertTrue(sut.choiceTwoButton.inSelectedState)
    }
    
    func testButtonThreeStateUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonThreeSelectState.value = true
        // Then
        XCTAssertTrue(sut.choiceThreeButton.inSelectedState)
    }
    
    func testButtonFourStateUpdatesWithValueChange() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        // When
        sut.viewModel.buttonFourSelectState.value = true
        // Then
        XCTAssertTrue(sut.choiceFourButton.inSelectedState)
    }
    
    // MARK: - Integration Test
    func testViewResetsWithValidSubmission() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        let worker = sut.viewModel.quizWorker
        let choiceOneButton = sut.choiceButtons.filter({ $0.value == worker.firstAnswer }).first
        let choiceTwoButton = sut.choiceButtons.filter({ $0.value == worker.secondAnswer }).first
        // When
        sut.choiceButtonTapped(choiceOneButton ?? RoundSelectButton())
        sut.choiceButtonTapped(choiceTwoButton ?? RoundSelectButton())
        sut.submitButtonTapped(sut.submitButton)
        // Then
        XCTAssertFalse(choiceOneButton?.inSelectedState ?? true)
        XCTAssertFalse(choiceTwoButton?.inSelectedState ?? true)
        XCTAssertEqual(sut.submitButton.backgroundColor, UIColor.lightGreen)
    }
    
    func testViewWarningWithInvalidSubmission() {
        // Given
        let sut = instantiateQuizViewController()
        sut.loadViewIfNeeded()
        let worker = sut.viewModel.quizWorker
        let choiceOneButton = sut.choiceButtons.filter({ $0.value != worker.firstAnswer }).first
        let choiceTwoButton = sut.choiceButtons.filter({ $0.value != worker.firstAnswer
                                                        && $0.value != worker.secondAnswer }).last
        // When
        sut.choiceButtonTapped(choiceOneButton ?? RoundSelectButton())
        sut.choiceButtonTapped(choiceTwoButton ?? RoundSelectButton())
        sut.viewModel.verifySelectedAnswers()
        // Then
        XCTAssertTrue(choiceOneButton?.inSelectedState ?? false)
        XCTAssertTrue(choiceTwoButton?.inSelectedState ?? false)
        XCTAssertEqual(sut.submitButton.backgroundColor, UIColor.lightRed)
    }
    
    // MARK: - Helpers
    private func instantiateQuizViewController() -> QuizViewController {
        continueAfterFailure = false
        
        let sb = UIStoryboard(name: "Quiz", bundle: nil)
        let vcId = "QuizViewController"
        if let vc = sb.instantiateViewController(identifier: vcId) as? QuizViewController {
            return vc
        }
        
        XCTFail("Quiz View Controller could not be instantiated from a storyboard.")
        return QuizViewController()
    }
}
