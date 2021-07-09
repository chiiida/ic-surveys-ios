//
//  NPSAnswerView.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit

class NPSAnswerView: UIView {

    let answers: [SurveyAnswer]

    let segmentedControl = UISegmentedControl()
    private let mostLikelyLabel = UILabel()
    private let leastLikelyLabel = UILabel()

    init(answers: [SurveyAnswer]) {
        self.answers = answers
        super.init(frame: .zero)
        setUpLayout()
        setUpViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setUpLayout() {
        addSubview(segmentedControl)
        addSubview(mostLikelyLabel)
        addSubview(leastLikelyLabel)

        segmentedControl.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().offset(-20.0)
            $0.height.equalTo(56.0)
        }

        mostLikelyLabel.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(16.0)
            $0.trailing.equalTo(segmentedControl.snp.trailing)
        }

        leastLikelyLabel.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(16.0)
            $0.leading.equalTo(segmentedControl.snp.leading)
        }
    }

    private func setUpViews() {
        mostLikelyLabel.text = Localize.answerNpsMostLikely()
        mostLikelyLabel.font = UIFont.bold(ofSize: .heading)
        mostLikelyLabel.textColor = .white
        mostLikelyLabel.alpha = 0.5

        leastLikelyLabel.text = Localize.answerNpsLeastLikely()
        leastLikelyLabel.font = UIFont.bold(ofSize: .heading)
        leastLikelyLabel.textColor = .white

        setSegmentedItems()
        setUpSegmentedControl()
    }

    private func setUpSegmentedControl() {
        segmentedControl.isUserInteractionEnabled = true
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.layer.borderWidth = 0.5
        segmentedControl.layer.borderColor = UIColor.white.cgColor
        segmentedControl.selectedSegmentTintColor = .clear
        segmentedControl.addTarget(self, action: #selector(handleValueChanged(_:)), for: .valueChanged)
        segmentedControl.setTitleTextAttributes(
            [.font: UIFont.regular(ofSize: .heading), .foregroundColor: UIColor.white.withAlphaComponent(0.5)],
            for: .normal
        )
        segmentedControl.setTitleTextAttributes(
            [.font: UIFont.bold(ofSize: .heading), .foregroundColor: UIColor.white],
            for: .selected
        )

        let whiteImage = UIImage.withBackground(color: UIColor.white.withAlphaComponent(0.5))
        segmentedControl.setDividerImage(
            whiteImage,
            forLeftSegmentState: .normal,
            rightSegmentState: .normal,
            barMetrics: .default
        )
    }

    private func setSegmentedItems() {
        for (index, answer) in answers.enumerated() {
            segmentedControl.insertSegment(withTitle: answer.text, at: index, animated: false)
        }
    }
}

extension NPSAnswerView {

    @objc func handleValueChanged(_ sender: UISegmentedControl) {
        let selectedIndex = segmentedControl.selectedSegmentIndex
        mostLikelyLabel.alpha = selectedIndex > 4 ? 1.0 : 0.5
        leastLikelyLabel.alpha = selectedIndex > 4 ? 0.5 : 1.0

        // TODO: handle selected index with real answer
    }
}
