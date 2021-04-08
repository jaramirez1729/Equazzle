//
//  UIButtonExtension.swift
//  Equazzle
//
//  Created by J.A. Ramirez on 4/6/21.
//

import UIKit

class RoundSelectButton: UIButton {
    // MARK: - Properties
    var inSelectedState: Bool = false {
        didSet {
            layer.borderColor = inSelectedState ? UIColor.lightBlue.cgColor : UIColor.lightGray.cgColor
        }
    }
    var value: Int {
        if let number = Int(title(for: .normal) ?? "") {
            return number
        }
        return 0
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - Layout
    private func setupUI() {
        layer.cornerRadius = 10
        backgroundColor = UIColor.white
        layer.borderWidth = 4
        layer.borderColor = UIColor.lightGray.cgColor
    }
}
