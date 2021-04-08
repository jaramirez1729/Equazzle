//
//  ObservableTests.swift
//  EquazzleTests
//
//  Created by J.A. Ramirez on 4/5/21.
//

import XCTest
@testable import Equazzle

class ObservableTests: XCTestCase {
    
    func testBindingWhenValueChanges() {
        // Given
        var text = ""
        let number = Observable(value: 2)
        // When
        number.bind { value in
            text = "\(value ?? 0)"
        }
        number.value = 1729
        // Then
        XCTAssertEqual(text, "1729")
    }
}
