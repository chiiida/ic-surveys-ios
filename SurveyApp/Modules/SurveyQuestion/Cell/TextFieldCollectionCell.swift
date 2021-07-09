//
//  TextFieldCollectionCell.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import UIKit

class TextFieldCollectionCell: QuestionCollectionCell {
    
    private var isMultipleLines: Bool = false
    
    override var answerView: UIView {
        get { super.answerView }
        set { return super.answerView = newValue }
    }
    
    override func configure(with question: SurveyQuestion) {
        switch question.displayType {
        case .textarea:
            isMultipleLines = true
        default:
            isMultipleLines = false
        }
        
        answerView = TextFieldAnswerView(
            isMultipleLines: isMultipleLines,
            answers: question.sortedAnswers
        )
        super.configure(with: question)
    }
}
