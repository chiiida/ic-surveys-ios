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
    
    override func configure(with question: SurveyQuestion) {
        if question.pickType == SurveyQuestion.PickType.any {
            answerView = MultipleChoiceAnswerView(answers: question.sortedAnswers)
        } else {
            answerView = ChoiceAnswerView(answers: question.sortedAnswers)
        }
        
        super.questionLabel.text = question.text
    }
}
