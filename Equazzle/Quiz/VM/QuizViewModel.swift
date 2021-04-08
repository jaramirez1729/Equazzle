//
//  QuizViewModel.swift
//  Equazzle
//
//  Created by J.A. Ramirez on 4/5/21.
//

class QuizViewModel {
    // MARK: - View State
    var equationText: Observable<String> = Observable(value: "")
    var buttonOneText: Observable<String> = Observable(value: "")
    var buttonTwoText: Observable<String> = Observable(value: "")
    var buttonThreeText: Observable<String> = Observable(value: "")
    var buttonFourText: Observable<String> = Observable(value: "")
    var buttonOneSelectState: Observable<Bool> = Observable(value: false)
    var buttonTwoSelectState: Observable<Bool> = Observable(value: false)
    var buttonThreeSelectState: Observable<Bool> = Observable(value: false)
    var buttonFourSelectState: Observable<Bool> = Observable(value: false)
    var submitButtonState: Observable<Bool> = Observable(value: nil)
    
    // MARK: - Properties
    var quizWorker = QuizWorker()
    var answers: [Int] {
        return quizWorker.answers
    }
    var selectedChoices: [Int] = [0, 0] {
        didSet {
            updateEquationText()
        }
    }
    
    // MARK: - Task Methods
    func loadNewQuiz() {
        quizWorker.loadNewQuiz()
        selectedChoices = [0, 0]
        updateEquationText()
        buttonOneText.value = "\(answers[0])"
        buttonTwoText.value = "\(answers[1])"
        buttonThreeText.value = "\(answers[2])"
        buttonFourText.value = "\(answers[3])"
    }
    
    func selectedChoice(with value: Int, for tag: Int) {
        if let index = selectedChoices.firstIndex(of: value) {
            selectedChoices[index] = 0
            updateButtonState(false, with: tag)
        } else {
            if selectedChoices[0] == 0 {
                selectedChoices[0] = value
                updateButtonState(true, with: tag)
            } else if selectedChoices[1] == 0 {
                selectedChoices[1] = value
                updateButtonState(true, with: tag)
            } else {
                updateButtonState(false, with: tag)
            }
        }
    }
    
    func verifySelectedAnswers() {
        assert(selectedChoices.count == 2)
        let lhs = Double(selectedChoices[0])
        let rhs = Double(selectedChoices[1])
        let userAnswer = quizWorker.operation.compute(lhs: lhs, rhs: rhs)
        submitButtonState.value = quizWorker.answer == userAnswer
    }
    
    // MARK: - Helpers
    private func updateEquationText() {
        assert(selectedChoices.count == 2)
        let spaceOne = selectedChoices[0] == 0 ? "_" : "\(selectedChoices[0])"
        let spaceTwo = selectedChoices[1] == 0 ? "_" : "\(selectedChoices[1])"
        equationText.value = "\(spaceOne)  \(quizWorker.operation.symbol)  \(spaceTwo)  =  \(quizWorker.answer)"
    }
    
    private func updateButtonState(_ state: Bool, with tag: Int) {
        switch tag {
        case 1: buttonOneSelectState.value = state
        case 2: buttonTwoSelectState.value = state
        case 3: buttonThreeSelectState.value = state
        default: buttonFourSelectState.value = state
        }
    }
}
