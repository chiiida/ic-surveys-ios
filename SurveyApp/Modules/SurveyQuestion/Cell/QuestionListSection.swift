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
        items.sorted { $0.displayOrder < $1.displayOrder }
    }
    
    var sortedSubmitedQuestions: [QuestionSubmission] {
        
        submitedQuestions.sorted { lhs, rhs in
            sortedQuestions.firstIndex { $0.id == lhs.id } ?? 0
                < sortedQuestions.firstIndex { $0.id == rhs.id } ?? 0
        }
    }
}
