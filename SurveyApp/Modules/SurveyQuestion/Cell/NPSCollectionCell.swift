//
//  NPSCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import UIKit

class NPSCollectionCell: QuestionCollectionCell {
    
    override var answerView: UIView {
        get { super.answerView }
        set { return super.answerView = newValue }
    }
    
    override func configure(with viewModel: QuestionCollectionCellViewModel) {
        answerView = NPSAnswerView(answers: viewModel.answers)
        super.configure(with: viewModel)
    }
}
