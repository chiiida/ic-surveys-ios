//
//  TextFieldCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import UIKit

class TextFieldCollectionCell: QuestionCollectionCell {
    
    private var isMultipleLines: Bool = false
    
    override var answerView: AnswerView {
        get { super.answerView }
        set { return super.answerView = newValue }
    }
    
    override func configure(with viewModel: QuestionCollectionCellViewModel) {
        switch viewModel.displayType {
        case .textarea:
            isMultipleLines = true
        default:
            isMultipleLines = false
        }
        
        answerView = TextFieldAnswerView(
            isMultipleLines: isMultipleLines,
            answers: viewModel.answers
        )
        super.configure(with: viewModel)
    }
}
