//
//  QuestionDisplayType.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//

import UIKit
import SnapKit

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
