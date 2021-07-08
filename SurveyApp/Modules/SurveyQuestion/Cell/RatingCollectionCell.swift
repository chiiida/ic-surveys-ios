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
            icon = DisplayType.RatingIcon.star
        case .smiley:
            icon = DisplayType.RatingIcon.smiley
        default:
            icon = DisplayType.RatingIcon.heart
        }
        
        answerView = RatingAnswerView(icon: icon)
        super.questionLabel.text = question.text
    }
}
