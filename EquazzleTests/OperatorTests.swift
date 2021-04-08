//
//  OperatorTests.swift
//  EquazzleTests
//
//  Created by J.A. Ramirez on 4/6/21.
//

import XCTest
@testable import Equazzle

class OperatorTests: XCTestCase {
    
    func testListIncludesAllCases() {
        // Given
        let list = Operator.list
        // Then
        XCTAssertEqual(list.count, 4)
        XCTAssertEqual(Set(list).count, 4)
    }
    
    func testComputeAddition() {
        // Given
        let operation = Operator.addition
        let lhs = 2.0
        let rhs = 3.0
        // When
        let total = operation.compute(lhs: lhs, rhs: rhs)
        // Then
        XCTAssertEqual(total, 5.0)
    }
    
    func testComputeSubtraction() {
        // Given
        let operation = Operator.subtraction
        let lhs = 10.0
        let rhs = 3.0
        // When
        let total = operation.compute(lhs: lhs, rhs: rhs)
        // Then
        XCTAssertEqual(total, 7.0)
    }
    
    func testComputeMultiplication() {
        // Given
        let operation = Operator.multiplication
        let lhs = 2.0
        let rhs = 3.0
        // When
        let total = operation.compute(lhs: lhs, rhs: rhs)
        // Then
        XCTAssertEqual(total, 6.0)
    }
    
    func testComputeDivision() {
        // Given
        let operation = Operator.division
        let lhs = 12.0
        let rhs = 4.0
        // When
        let total = operation.compute(lhs: lhs, rhs: rhs)
        // Then
        XCTAssertEqual(total, 3.0)
    }
    
    func testRoundAnswerIsValid() {
        // Given
        let operation = Operator.division
        let lhs = 7.0
        let rhs = 3.0
        // When
        let total = operation.compute(lhs: lhs, rhs: rhs)
        // Then
        XCTAssertEqual(total, 2.33)
    }
}
