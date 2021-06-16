//
//  UserCredential.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

import Foundation

struct UserCredential: Codable {
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case expiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case createdAt = "created_at"
    }
    
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int?
    let refreshToken: String?
    let createdAt: TimeInterval?
}
