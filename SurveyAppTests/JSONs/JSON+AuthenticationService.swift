// swiftlint:disable:this file_name
// swiftlint:disable all
//
//  JSON+AuthenticationService.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Foundation

extension JSON.AuthenticationService {
    
    static var authenticateEmailSuccess: Data {
        """
        {
            "data": {
                "id": 0,
                "type": "token",
                "attributes": {
                    "access_token": "sampleAccessToken",
                    "token_type": "sampleTokenType",
                    "expires_in": 7200,
                    "refresh_token": "sampleRefreshToken",
                    "created_at": 1623320860
                }
            }
        }
        """.data(using: .utf8)!
    }
    
    static var authenticateEmailFailure: Data {
        """
        {
            "errors": [
                {
                    "source": "Doorkeeper::OAuth::Error",
                    "detail": "Sample API error detail",
                    "code": "invalid_grant"
                }
            ]
        }
        """.data(using: .utf8)!
    }
    
    static var sampleUserCredential: Data {
        """
        {
            "access_token": "sampleAccessToken",
            "token_type": "sampleTokenType",
            "expires_in": 7200,
            "refresh_token": "sampleRefreshToken",
            "created_at": 1623320860
        }
        """.data(using: .utf8)!
    }
}

extension Data {

    func decoded<T: Decodable>() -> T {
        return try! JSONDecoder().decode(T.self, from: self)
    }
}
