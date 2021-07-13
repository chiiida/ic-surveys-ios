//
//  SurveyAnswer.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/7/21.
//

import Foundation

struct SurveyAnswer {

    let id: String
    let displayOrder: Int
    let text: String
    let inputPlaceholder: String?
    let inputMask: String?
    
    init(data: SurveyData) {
        let attributes = data.attributes as? SurveyAnswerAttributes
        
        self.id = data.id
        self.displayOrder = attributes?.displayOrder ?? 0
        self.text = attributes?.text ?? ""
        self.inputPlaceholder = attributes?.inputMaskPlaceholder
        self.inputMask = attributes?.inputMask
    }
}
