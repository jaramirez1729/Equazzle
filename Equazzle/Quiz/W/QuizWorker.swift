//
//  NewQuizWorker.swift
//  Equazzle
//
//  Created by J.A. Ramirez on 4/6/21.
//

import GameplayKit

class QuizWorker {
    // MARK: - Properties
    var counterLimit: Int = 5   // Injection Property
    var firstAnswer: Int = 0
    var secondAnswer: Int = 0
    var operation: Operator = Operator.addition
    var answer: Double = 0
    var answers: [Int] = []
    private let randomDistribution = GKRandomDistribution(lowestValue: 7, highestValue: 17)
    
    // MARK: - Helpers
    func loadNewQuiz() {
        generateAnswers()
        assert(answers.count == 4)
        firstAnswer = answers[0]
        secondAnswer = answers[1]
        answers.shuffle()
        print("Answers: \(firstAnswer), \(secondAnswer)")
        operation = Operator.randomOperation
        answer = operation.compute(lhs: Double(firstAnswer), rhs: Double(secondAnswer))
    }
    
    private func generateAnswers() {
        answers.removeAll()
        var list: [Int] = []
        var counter: Int = 0
        
        // Keep shuffling until there are no duplicate values. In extremely rare cases,
        // we use a counter to avoid the loop from running forever.
        while Set(list).count != 4 {
            list.removeAll()
            for _ in 1...4 {
                list.append(randomDistribution.nextInt())
            }
            
            counter += 1
            if counter == counterLimit {
                list = [3, 4, 5, 6]
                break
            }
        }
        answers = list
    }
}
