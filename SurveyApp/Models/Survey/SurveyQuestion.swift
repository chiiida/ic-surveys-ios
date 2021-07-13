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

    init(data: SurveyData, answers: [SurveyAnswer]) {
        let attributes = data.attributes as? SurveyQuestionAttributes

        self.id = data.id
        self.displayOrder = attributes?.displayOrder ?? 0
        self.displayType = attributes?.displayType ?? .choice
        self.text = attributes?.text ?? ""
        self.pickType = attributes?.pick ?? .none
        self.coverImageUrl = attributes?.coverImageUrl ?? ""
        self.answers = answers
    }
    
    var sortedAnswers: [SurveyAnswer] {
        answers.sorted(by: { $0.displayOrder < $1.displayOrder })
    }
    
    var largeImageURL: URL? {
        URL(string: coverImageUrl + "l")
    }

    enum PickType: String, Decodable {

        case one, any, none
    }
}
