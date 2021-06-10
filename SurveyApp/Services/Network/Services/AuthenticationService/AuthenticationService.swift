//
//  AuthenticationService.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Alamofire

protocol AuthenticationServiceProtocol {
    
    var clientId: String { get set }
    var clientSecret: String { get set }

    func authenticateEmail(
        email: String,
        password: String,
        completion: @escaping RequestCompletion<AuthToken>
    ) -> Request?
}

final class AuthenticationService: NetworkService, AuthenticationServiceProtocol {
        
    var clientId: String = ProcessInfo.processInfo.environment["CLIENT_ID"] ?? ""
    var clientSecret: String = ProcessInfo.processInfo.environment["CLIENT_SECRET"] ?? ""
    
    func authenticateEmail(email: String, password: String, completion: @escaping RequestCompletion<AuthToken>) -> Request? {
        let configuration = RequestConfiguration(
            method: .post,
            url: url(forEndpoint: "/api/v1/oauth/token"),
            parameters: [
                "grant_type": "password",
                "email": email,
                "password": password,
                "client_id": clientId,
                "client_secret": clientSecret
            ]
        )
        
        return api.performRequest(with: configuration, completion: completion)
    }
}
