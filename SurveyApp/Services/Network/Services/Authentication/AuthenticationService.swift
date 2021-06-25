//
//  AuthenticationService.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Alamofire
import Keys

// sourcery: AutoMockable
protocol AuthenticationServiceProtocol {

    func authenticateEmail(
        email: String,
        password: String,
        completion: @escaping RequestCompletion<AuthToken>
    ) -> Request?
}

final class AuthenticationService: NetworkService, AuthenticationServiceProtocol {
    
    func authenticateEmail(email: String, password: String, completion: @escaping RequestCompletion<AuthToken>) -> Request? {
        let configuration = RequestConfiguration(
            method: .post,
            url: url(forEndpoint: "/api/v1/oauth/token"),
            parameters: [
                "grant_type": "password",
                "email": email,
                "password": password,
                "client_id": Constants.ApiKeys.clientId,
                "client_secret": Constants.ApiKeys.clientSecret
            ]
        )
        
        return api.performRequest(with: configuration, completion: completion)
    }
}
