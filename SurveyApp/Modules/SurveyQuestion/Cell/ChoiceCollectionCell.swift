//
//  ChoiceCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import UIKit

class ChoiceCollectionCell: QuestionCollectionCell {
    
    override var answerView: UIView {
        get { super.answerView }
        set { return super.answerView = newValue }
    }
    
    override func configure(with viewModel: QuestionCollectionCellViewModel) {
        if viewModel.pickType == SurveyQuestion.PickType.any {
            answerView = MultipleChoiceAnswerView(answers: viewModel.answers)
        } else {
            answerView = ChoiceAnswerView(answers: viewModel.answers)
        }
        
        super.configure(with: viewModel)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        if let view = answerView as? ChoiceAnswerView {
            view.reset()
        }
    }
}
