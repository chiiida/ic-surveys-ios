//
//  Survey.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/24/21.
//

struct Survey: Codable, Comparable {
    
    let id: String
    let type: String
    let title: String
    let description: String
    let coverImageUrl: String
    
    static func < (lhs: Survey, rhs: Survey) -> Bool {
      return lhs.id < rhs.id
    }
}
