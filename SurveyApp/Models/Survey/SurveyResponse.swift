//
//  SurveyResponse.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/25/21.
//

import Foundation

struct SurveyAttributes: Codable {
    
    enum CodingKeys: String, CodingKey {
        case title, description
        case thankEmailAboveThreshold = "thank_email_above_threshold"
        case thankEmailBelowThreshold = "thank_email_below_threshold"
        case isActive = "is_active"
        case coverImageUrl = "cover_image_url"
        case createdAt = "created_at"
        case activeAt = "active_at"
        case inactiveAt = "inactive_at"
        case surveyType = "survey_type"
    }
    
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
    
    enum CodingKeys: String, CodingKey {
        case id, type
    }
    
    let id: String
    let type: String
}

struct SurveyQuestion: Codable {
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    let data: [SurveyQuestionData]
}

struct SurveyRelationships: Codable {
    
    enum CodingKeys: String, CodingKey {
        case questions
    }
    
    let questions: SurveyQuestion
}

struct SurveyData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, type, attributes, relationships
    }
    
    let id: String
    let type: String
    let attributes: SurveyAttributes
    let relationships: SurveyRelationships
}

struct Meta: Codable {
    
    enum CodingKeys: String, CodingKey {
        case page, pages, records
        case pageSize = "page_size"
    }
    
    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int
}

struct SurveyResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case data, meta
    }
    
    let data: [SurveyData]
    let meta: Meta
}
