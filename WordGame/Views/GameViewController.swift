//
//  GameViewController.swift
//  WordGame
//
//  Created by Charmy on 11.09.23.
//

import UIKit

class GameViewController: UIViewController, ControllerType {
    
    // MARK: - Variables
    typealias ViewModelType = GameViewModel
    private var viewModel: ViewModelType!
    
    // MARK: - UI components
    private var attemptsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .vertical
        stackView.spacing = 5.0
        return stackView
    }()
    
    private var correctAttemptsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        return stackView
    }()
    
    private var correctAttemptsLabel: UILabel = {
        let label = UILabel()
        label.text = "Correct attempts:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private var correctAttemptsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    private var wrongAttemptsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .trailing
        stackView.axis = .horizontal
        stackView.spacing = 5.0
        return stackView
    }()
    
    private var wrongAttemptsLabel: UILabel = {
        let label = UILabel()
        label.text = "Wrong attempts:"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    private var wrongAttemptsValueLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    private var translationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 15.0
        return stackView
    }()
    
    private var spanishLabel: UILabel = {
        let label = UILabel()
        label.text = "Spanish"
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .systemOrange
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var translationTextLabel: UILabel = {
        let label = UILabel()
        label.text = "is the Spanish translation for"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.textAlignment = .center
        return label
    }()
    
    private var englishLabel: UILabel = {
        let label = UILabel()
        label.text = "English"
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20.0
        return stackView
    }()
    
    private var correctButton: UIButton = {
        let button = UIButton()
        button.setTitle("Correct", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    private var wrongButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Wrong", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 22)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        return button
    }()
    
    // MARK: - Initializers / Configurations
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    func configure(with viewModel: ViewModelType) {
        self.viewModel = viewModel
        viewModel.output.updateAttemptsCounter = updateAttemptsCounter
        viewModel.output.updateTranslationPair = updateTranslationPair
        
        viewModel.prepareTranslationPair()
    }
    
    // MARK: - Layout updates
    private func setupLayout() {
        title = "Word Game"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemOrange]
        view.backgroundColor = .white
        [correctAttemptsLabel, correctAttemptsValueLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            correctAttemptsStackView.addArrangedSubview($0)
        }
        
        [wrongAttemptsLabel, wrongAttemptsValueLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            wrongAttemptsStackView.addArrangedSubview($0)
        }
        
        [correctAttemptsStackView, wrongAttemptsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            attemptsStackView.addArrangedSubview($0)
        }
        
        [spanishLabel, translationTextLabel, englishLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            translationStackView.addArrangedSubview($0)
        }
        
        correctButton.addTarget(self, action: #selector(correctButtonTapped(_:)), for: .touchUpInside)
        wrongButton.addTarget(self, action: #selector(wrongButtonTapped(_:)), for: .touchUpInside)
        [correctButton, wrongButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            buttonsStackView.addArrangedSubview($0)
        }
        
        [attemptsStackView, translationStackView, buttonsStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            attemptsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20.0),
            attemptsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            
            translationStackView.topAnchor.constraint(equalTo: attemptsStackView.bottomAnchor, constant: 80.0),
            translationStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            translationStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            
            correctButton.heightAnchor.constraint(equalToConstant: 48.0),
            wrongButton.heightAnchor.constraint(equalToConstant: 48.0),
            correctButton.widthAnchor.constraint(equalTo: wrongButton.widthAnchor),
            
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20.0),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20.0),
            buttonsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30.0)
        ])
    }
    
    private func updateAttemptsCounter(correctAttempts: Int, wrongAttempts: Int) {
        correctAttemptsValueLabel.text = "\(correctAttempts)"
        wrongAttemptsValueLabel.text = "\(wrongAttempts)"
    }
    
    private func updateTranslationPair(english: String, spanish: String) {
        englishLabel.text = english
        spanishLabel.text = spanish
    }
    
    // MARK: - UIActions
    @IBAction
    func correctButtonTapped(_ sender: UIButton) {
        viewModel.input.checkCorrectAnswer(true)
    }
    
    @IBAction
    func wrongButtonTapped(_ sender: UIButton) {
        viewModel.input.checkCorrectAnswer(false)
    }
}
