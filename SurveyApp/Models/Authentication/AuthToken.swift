//
//  AuthToken.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

struct Session: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id, type
        case userCredential = "attributes"
    }
    
    let id: String?
    let type: String?
    let userCredential: UserCredential?
}

struct AuthToken: Codable {
    
    enum CodingKeys: String, CodingKey {
        case session = "data"
    }
    
    let session: Session?
}
