//
//  QuestionDisplayType.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit

enum QuestionDisplayType: String {

    case star
    case heart
    case smiley
    case choice
    case nps
    case textarea
    case textfield

    enum RatingIcon {

        static let star = "⭐️"
        static let heart = "❤️"
        static let smiley = "😄"
    }
}

protocol AnswerViewDelegate: AnyObject {
    
    func didAnswer(answers: [AnswerSubmission])
}

protocol AnswerView: UIView {
    
    var delegate: AnswerViewDelegate? { get set }
}

class DefaultAnswerView: UIView, AnswerView {
    
    var delegate: AnswerViewDelegate?
}
