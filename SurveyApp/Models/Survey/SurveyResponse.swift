//
//  SurveyResponse.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/25/21.
//

import Foundation

struct SurveyAttributes: Codable {

    let title: String
    let description: String
    let thankEmailAboveThreshold: String?
    let thankEmailBelowThreshold: String?
    let isActive: Bool
    let coverImageUrl: String
    let createdAt: String
    let activeAt: String
    let inactiveAt: String?
    let surveyType: String
}

struct SurveyQuestionData: Codable {
    
    let id: String
    let type: String
}

struct SurveyQuestion: Codable {
    
    let data: [SurveyQuestionData]
}

struct SurveyRelationships: Codable {
    
    let questions: SurveyQuestion
}

struct SurveyData: Codable {
    
    let id: String
    let type: String
    let attributes: SurveyAttributes
    let relationships: SurveyRelationships
}

struct Meta: Codable {
    
    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int
}

struct SurveyResponse: Codable {
    
    let data: [SurveyData]
    let meta: Meta
}
