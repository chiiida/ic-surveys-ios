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
    
    override func configure(with question: SurveyQuestion) {
        answerView = NPSAnswerView(answers: question.sortedAnswers)
        super.questionLabel.text = question.text
    }
}
