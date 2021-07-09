//
//  QuestionListSection.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/8/21.
//

import Foundation

struct QuestionListSection {
    
    var items: [QuestionCollectionCellViewModel]
    var submitedQuestions: [QuestionSubmission]
    
    init() {
        self.items = []
        self.submitedQuestions = []
    }
}

extension QuestionListSection {
    
    var sortedQuestions: [QuestionCollectionCellViewModel] {
        items.sorted(by: { $0.displayOrder < $1.displayOrder })
    }
}
