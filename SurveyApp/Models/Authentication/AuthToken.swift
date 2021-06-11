//
//  AuthToken.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

struct AuthAttributes: Codable {
    
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
    let createdAt: Int?
}

struct AuthData: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, type, attributes
    }
    
    let id: Int?
    let type: String?
    let attributes: AuthAttributes?
}

struct AuthToken: Codable {
    
    enum CodingKeys: String, CodingKey {
        case data
    }
    
    let data: AuthData?
}
