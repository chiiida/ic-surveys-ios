//
//  RatingAnswerView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit
import SnapKit

class RatingAnswerView: UIView, AnswerView {
    
    var icon: String
    var answers: [SurveyAnswer]
    
    weak var delegate: AnswerViewDelegate?

    private let stackView = UIStackView()
    private var iconLabelsList = [UILabel]()

    init(icon: String, answers: [SurveyAnswer]) {
        self.icon = icon
        self.answers = answers
        super.init(frame: .zero)
        setUpLayout()
        setUpView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        addSubview(stackView)

        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.handleTouchAtIcon(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.handleTouchAtIcon(touches)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.handleTouchAtIcon(touches)
    }

    private func setUpView() {
        stackView.spacing = 16.0
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually

        for _ in 1...5 {
            let iconLabel = UILabel()
            iconLabel.text = icon
            iconLabel.font = UIFont.regular(ofSize: .title)
            iconLabel.alpha = 0.5

            stackView.addArrangedSubview(iconLabel)
            iconLabelsList.append(iconLabel)
        }
    }

    private func handleTouchAtIcon(_ touches: Set<UITouch>) {
        let touchLocation = touches.first
        let location = touchLocation?.location(in: stackView)
        var rating = 0

        for (index, iconLabel) in iconLabelsList.enumerated() {
            if (location?.x) ?? 0 > iconLabel.frame.origin.x {
                rating = index
                iconLabel.alpha = 1.0
            } else {
                iconLabel.alpha = 0.5
            }
        }

        let answer = AnswerSubmission(id: answers[rating].id, answers: nil)
        delegate?.didAnswer(answers: [answer])
    }
}
