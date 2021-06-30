//
//  UserCredential.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/16/21.
//

import Foundation

struct UserCredential: Codable {
    
    let accessToken: String?
    let tokenType: String?
    let expiresIn: Int?
    let refreshToken: String?
    let createdAt: TimeInterval?
}
