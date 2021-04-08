//
//  Operator.swift
//  Equazzle
//
//  Created by J.A. Ramirez on 4/6/21.
//

import GameplayKit

enum Operator: String {
    // MARK: - Cases
    case addition = "+"
    case subtraction = "-"
    case multiplication = "*"
    case division = "/"
    
    // MARK: - Properties
    static var list: [Operator] {
        return [.addition, .subtraction, .multiplication, .division]
    }
    var symbol: String {
        return self.rawValue
    }
    
    // MARK: - Helpers
    static var randomOperation: Operator {
        let index = GKRandomDistribution(lowestValue: 0, highestValue: list.count - 1).nextInt()
        return list[index]
    }
    
    func compute(lhs: Double, rhs: Double) -> Double {
        var total: Double = 0
        switch self {
        case .addition: total = lhs + rhs
        case .subtraction: total = lhs - rhs
        case .multiplication: total = lhs * rhs
        case .division:
            if rhs == 0.0 { break }
            total = lhs / rhs
        }
        return round(total * 100) / 100
    }
}
