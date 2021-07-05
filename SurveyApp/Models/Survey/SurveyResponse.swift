//
//  SurveyResponse.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/25/21.
//

import Foundation

struct SurveyAttributes: Decodable {

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

struct SurveyRelationshipData: Decodable {
    
    let id: String
    let type: String
}

struct SurveyRelationshipType: Decodable {
    
    var data: [SurveyRelationshipData]
}

struct SurveyRelationship: Decodable {
    
    private struct CodingKeys: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int?
        init?(intValue: Int) {
            return nil
        }
    }
    
    let type: String
    let relationship: SurveyRelationshipType
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        relationship = try container.decode(SurveyRelationshipType.self,
                                    forKey: CodingKeys(stringValue: container.allKeys[0].stringValue)!)
        
        type = container.allKeys[0].stringValue
    }
}

struct SurveyData: Decodable {
    
    enum CodingKeys: String, CodingKey {
        case id, type, attributes, relationships
    }
    
    let id: String
    let type: String
    var attributes: Any?
    var relationships: SurveyRelationship?
    
    var surveyType: SurveyType {
        guard let surveyType = SurveyType(rawValue: type ?? "") else { return .undefined }
        return surveyType
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        type = try container.decode(String.self, forKey: .type)
        relationships = try? container.decodeIfPresent(SurveyRelationship.self, forKey: .relationships)
        
        switch surveyType {
        case .question:
            attributes = try? container.decode(SurveyQuestionAttributes.self, forKey: .attributes)
        case .answer:
            attributes = try? container.decode(SurveyAnswerAttributes.self, forKey: .attributes)
        default:
            attributes = try? container.decode(SurveyAttributes.self, forKey: .attributes)
        }
    }
}

struct Meta: Decodable {
    
    let page: Int
    let pages: Int
    let pageSize: Int
    let records: Int
}

struct SurveyResponse: Decodable {
    
    let data: [SurveyData]
    let meta: Meta
}

// MARK: - Survey Detail

struct SurveyQuestionAttributes: Decodable {
    
    let text: String?
    let helpText: String?
    let displayOrder: Int?
    let shortText: String?
    let pick: String?
    let displayType: String?
    let isMandatory: Bool
    let correctAnswerId: String?
    let facebookProfile: String?
    let twitterProfile: String?
    let imageUrl: String?
    let coverImageUrl: String?
    let coverImageOpacity: Double?
    let coverBackgroundColor: String?
    let isShareableOnFacebook: Bool
    let isShareableOnTwitter: Bool
    let fontFace: String?
    let fontSize: String?
    let tagList: String?
}

struct SurveyAnswerAttributes: Decodable {
    
    let text: String?
    let helpText: String?
    let inputMaskPlaceholder: String?
    let shortText: String?
    let isMandatory: Bool
    let isCustomerFirstName: Bool
    let isCustomerLastName: Bool
    let isCustomerTitle: Bool
    let isCustomerEmail: Bool
    let promptCustomAnswer: Bool
    let weight: String?
    let displayOrder: Int?
    let displayType: String?
    let inputMask: String?
    let dateConstraint: String?
    let defaultValue: String?
    let responseClass: String?
    let referenceIdentifier: String?
    let score: Int?
    let alerts: [String?]
}

struct SurveyDetailResponse: Decodable {
    
    let data: SurveyData
    let included: [SurveyData]
}

extension SurveyData {
    
    enum SurveyType: String {
        case survey
        case question
        case answer
        
        case undefined
    }
}
