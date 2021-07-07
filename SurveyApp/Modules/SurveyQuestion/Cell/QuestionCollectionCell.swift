//
//  QuestionCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//

import UIKit
import SnapKit

final class QuestionCollectionCell: UICollectionViewCell {
    
    private let questionLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpLayout()
        setUpViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with question: SurveyQuestion) {
        questionLabel.text = question.text
        
        if contentView.subviews.count > 1 {
            contentView.subviews.last?.removeFromSuperview()
        }
        
        let answerView = self.getAnswerView(
            type: question.displayType,
            answers: question.sortedAnswers
        )
        
        contentView.addSubview(answerView)
        
        answerView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    private func setUpLayout() {
        contentView.addSubview(questionLabel)
        
        questionLabel.snp.makeConstraints {
            $0.leading.trailing.top.equalToSuperview()
        }
    }
    
    private func setUpViews() {
        questionLabel.text = "I have a separate space to work (room or living room)."
        questionLabel.font = UIFont.bold(ofSize: .largerTitle)
        questionLabel.textColor = .white
        questionLabel.lineBreakMode = .byWordWrapping
        questionLabel.numberOfLines = 4
    }
}

extension QuestionCollectionCell {
    
    private func getAnswerView(type: DisplayType, answers: [SurveyAnswer] = []) -> UIView {
        switch type {
        case .star:
            return RatingAnswerView(icon: DisplayType.RatingIcon.star)
        case .heart:
            return RatingAnswerView(icon: DisplayType.RatingIcon.heart)
        case .smiley:
            return RatingAnswerView(icon: DisplayType.RatingIcon.smiley)
        case .textarea:
            return TextFieldAnswerView(isMultipleLines: true, answers: answers)
        case .textfield:
            return TextFieldAnswerView(answers: answers)
        case .nps:
            return NPSAnswerView(answers: answers)
        case .choice:
            return ChoiceAnswerView(answers: answers)
        }
    }
}
