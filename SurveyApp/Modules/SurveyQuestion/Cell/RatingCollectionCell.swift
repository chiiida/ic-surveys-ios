//
//  RatingCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import UIKit

class RatingCollectionCell: QuestionCollectionCell {
    
    private var icon: String = ""
    
    override var answerView: UIView {
        get { super.answerView }
        set { return super.answerView = newValue }
    }
    
    override func configure(with question: SurveyQuestion) {
        switch question.displayType {
        case .star:
            icon = QuestionDisplayType.RatingIcon.star
        case .smiley:
            icon = QuestionDisplayType.RatingIcon.smiley
        default:
            icon = QuestionDisplayType.RatingIcon.heart
        }
        
        answerView = RatingAnswerView(icon: icon)
        super.configure(with: question)
    }
}
