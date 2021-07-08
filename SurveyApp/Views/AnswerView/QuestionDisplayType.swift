//
//  QuestionDisplayType.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import UIKit

enum QuestionDisplayType {

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