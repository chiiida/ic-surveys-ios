// swiftlint:disable all
//
//  JSON+AuthenticationService.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Foundation

extension JSON.AuthenticationService {
    
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
    
    static var authenticateEmailSuccess: Data {
        """
        {
            "data": {
                "id": "10",
                "type": "token",
                "attributes": {
                    "access_token": "lbxD2K2BjbYtNzz8xjvh2FvSKx838KBCf79q773kq2c",
                    "token_type": "Bearer",
                    "expires_in": 7200,
                    "refresh_token": "3zJz2oW0njxlj_I3ghyUBF7ZfdQKYXd2n0ODlMkAjHc",
                    "created_at": 1597169495
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
                    "detail": "Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method.",
                    "code": "invalid_client"
                }
            ]
        }
        """.data(using: .utf8)!
    }
}

extension Data {

    func decoded<T: Decodable>() -> T {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try! decoder.decode(T.self, from: self)
    }
}
