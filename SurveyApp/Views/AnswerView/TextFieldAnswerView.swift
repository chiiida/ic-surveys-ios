//
//  TextFieldAnswerView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit
import SnapKit

class TextFieldAnswerView: UIView {

    let isMultipleLines: Bool
    let answers: [SurveyAnswer]

    private let textView = UITextView()
    private let stackView = UIStackView()

    init(isMultipleLines: Bool = false, answers: [SurveyAnswer] = []) {
        self.isMultipleLines = isMultipleLines
        self.answers = answers
        super.init(frame: .zero)
        setUpLayout()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        addSubview(textView)
        addSubview(stackView)

        textView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-20.0)
            $0.height.equalTo(168.0)
        }
        
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-20.0)
        }
    }

    private func setUpViews() {
        if isMultipleLines {
            stackView.removeFromSuperview()
            setUpTextView()
        } else {
            textView.removeFromSuperview()
            setUpTextFieldStack()
        }
    }
    
    private func setUpTextView() {
        textView.isUserInteractionEnabled = true
        textView.text = answers.first?.inputPlaceholder ?? ""
        textView.layer.cornerRadius = 10.0
        textView.contentInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        textView.textColor = .white
        textView.font = .regular(ofSize: .body)
        textView.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
    }
    
    private func setUpTextFieldStack() {
        stackView.spacing = 16.0
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        
        for answer in answers {
            let textField = CustomTextField()
            textField.placeholder = answer.inputPlaceholder
            textField.backgroundColor = UIColor.gray.withAlphaComponent(0.8)
            
            textField.snp.makeConstraints {
                $0.height.equalTo(56.0)
            }
            
            stackView.addArrangedSubview(textField)
        }
    }
}
