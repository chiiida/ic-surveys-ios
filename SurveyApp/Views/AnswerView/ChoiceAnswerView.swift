//
//  ChoiceAnswerView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit
import NimbleExtension

class ChoiceAnswerView: UIView, AnswerView {

    var answers: [SurveyAnswer]
    
    weak var delegate: AnswerViewDelegate?

    private let pickerView = UIPickerView()

    init(answers: [SurveyAnswer]) {
        self.answers = answers
        super.init(frame: .zero)
        setUpLayout()
        setUpViews()
        setIdentifiers()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(answers: [SurveyAnswer]) {
        self.answers = answers
        pickerView.reloadAllComponents()
    }

    private func setUpLayout() {
        addSubview(pickerView)

        pickerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    private func setUpViews() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.tintColor = .white
        pickerView.backgroundColor = .clear
    }
    
    private func setIdentifiers() {
        pickerView.accessibilityIdentifier = TestConstants.SurveyQuestion.pickerView
    }
}

extension ChoiceAnswerView: UIPickerViewDelegate, UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return answers.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return answers[row].text
    }

    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50.0
    }

    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let attributes = [
            NSAttributedString.Key.font: UIFont.regular(ofSize: .heading),
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
        return NSAttributedString(string: answers[row].text, attributes: attributes)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let answer = AnswerSubmission(id: answers[row].id, answers: nil)
        delegate?.didAnswer(answers: [answer])
    }
}
