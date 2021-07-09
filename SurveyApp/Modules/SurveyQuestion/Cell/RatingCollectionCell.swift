//
//  RatingCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import UIKit

class RatingCollectionCell: QuestionCollectionCell {
    
    private var icon: String = ""
    
    override var answerView: AnswerView {
        get { super.answerView }
        set { return super.answerView = newValue }
    }
    
    override func configure(with viewModel: QuestionCollectionCellViewModel) {
        switch viewModel.displayType {
        case .star:
            icon = QuestionDisplayType.RatingIcon.star
        case .smiley:
            icon = QuestionDisplayType.RatingIcon.smiley
        default:
            icon = QuestionDisplayType.RatingIcon.heart
        }
        
        answerView = RatingAnswerView(icon: icon, answers: viewModel.answers)
        super.configure(with: viewModel)
    }
}
