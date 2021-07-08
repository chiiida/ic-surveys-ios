//
//  SurveyQuestion.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/6/21.
//

import Foundation

struct SurveyQuestion {

    let id: String
    let displayOrder: Int
    let displayType: QuestionDisplayType
    let text: String
    let pickType: PickType
    let coverImageUrl: String
    let answers: [SurveyAnswer]
}

extension SurveyQuestion {

    var sortedAnswers: [SurveyAnswer] {
        answers.sorted(by: { $0.displayOrder < $1.displayOrder })
    }
    
    var largeImageURL: URL? {
        URL(string: coverImageUrl + "l")
    }

    enum PickType: String {

        case one, any, none
    }
}
