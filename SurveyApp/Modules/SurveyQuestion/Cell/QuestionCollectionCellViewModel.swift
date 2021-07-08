//
//  QuestionCollectionCellViewModel.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import Foundation

struct QuestionCollectionCellViewModel {
    
    let id: String
    let displayOrder: Int
    let displayType: QuestionDisplayType
    let text: String
    let pickType: SurveyQuestion.PickType
    let coverImageUrl: URL?
    let answers: [SurveyAnswer]
    
    init(question: SurveyQuestion) {
        self.id = question.id
        self.displayOrder = question.displayOrder
        self.displayType = question.displayType
        self.text = question.text
        self.pickType = question.pickType
        self.coverImageUrl = question.largeImageURL
        self.answers = question.sortedAnswers
    }
}
