//
//  ViewController.swift
//  Equazzle
//
//  Created by J.A. Ramirez on 4/5/21.
//

import UIKit

class QuizViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var instructionLabel: UILabel!
    @IBOutlet weak var equationLabel: UILabel!
    @IBOutlet weak var choiceOneButton: RoundSelectButton!
    @IBOutlet weak var choiceTwoButton: RoundSelectButton!
    @IBOutlet weak var choiceThreeButton: RoundSelectButton!
    @IBOutlet weak var choiceFourButton: RoundSelectButton!
    @IBOutlet weak var submitButton: UIButton!
    
    // MARK: - Properties
    let viewModel = QuizViewModel()
    var choiceButtons: [RoundSelectButton] {
        return [choiceOneButton, choiceTwoButton, choiceThreeButton, choiceFourButton].compactMap({$0})
    }

    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupBinding()
        viewModel.loadNewQuiz()
    }
    
    // MARK: - Actions
    @IBAction func choiceButtonTapped(_ sender: RoundSelectButton) {
        viewModel.selectedChoice(with: sender.value, for: sender.tag)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        viewModel.verifySelectedAnswers()
    }
    
    // MARK: - Helpers
    private func setupBinding() {
        viewModel.equationText.bind { [unowned self] value in
            self.equationLabel.text = value
        }
        setupChoiceButtonsBinding()
        viewModel.submitButtonState.bind { [unowned self] value in
            switch value {
            case true:
                submitButton.backgroundColor = UIColor.lightGreen
                choiceButtons.forEach { $0.inSelectedState = false }
                viewModel.loadNewQuiz()
            case false: submitButton.backgroundColor = UIColor.lightRed
            default: break
            }
        }
    }
    
    private func setupChoiceButtonsBinding() {
        viewModel.buttonOneText.bind { [unowned self] value in
            self.choiceOneButton.setTitle(value, for: .normal)
        }
        viewModel.buttonTwoText.bind { [unowned self] value in
            self.choiceTwoButton.setTitle(value, for: .normal)
        }
        viewModel.buttonThreeText.bind { [unowned self] value in
            self.choiceThreeButton.setTitle(value, for: .normal)
        }
        viewModel.buttonFourText.bind { [unowned self] value in
            self.choiceFourButton.setTitle(value, for: .normal)
        }
        viewModel.buttonOneSelectState.bind { [unowned self] value in
            if let val = value { self.choiceOneButton.inSelectedState = val }
        }
        viewModel.buttonTwoSelectState.bind { [unowned self] value in
            if let val = value { self.choiceTwoButton.inSelectedState = val }
        }
        viewModel.buttonThreeSelectState.bind { [unowned self] value in
            if let val = value { self.choiceThreeButton.inSelectedState = val }
        }
        viewModel.buttonFourSelectState.bind { [unowned self] value in
            if let val = value { self.choiceFourButton.inSelectedState = val }
        }
    }
    
    // MARK: - Layout
    private func setupUI() {
        view.backgroundColor = UIColor.backgroundGray
        instructionLabel.text = "Choose the two numbers that make the equation true."
        instructionLabel.textColor = UIColor.darkGray
        instructionLabel.font = UIFont.preferredFont(forTextStyle: .title1)
        
        equationLabel.textColor = UIColor.darkGray
        equationLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        
        choiceButtons.forEach {
            $0.setTitleColor(UIColor.darkGray, for: .normal)
            $0.titleLabel?.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        }
        choiceButtons.enumerated().forEach { $1.tag = $0 + 1 }
        
        submitButton.setTitle("Submit", for: .normal)
        submitButton.layer.cornerRadius = 10
        submitButton.backgroundColor = UIColor.lightGreen
        submitButton.setTitleColor(UIColor.darkGray, for: .normal)
        submitButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
    }
}
