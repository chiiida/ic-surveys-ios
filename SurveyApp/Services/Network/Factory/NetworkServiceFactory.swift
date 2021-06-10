//
//  NetworkServiceFactory.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Foundation

final class NetworkServiceFactory {
    
    static let shared = NetworkServiceFactory()
    let api = BaseAPI()
    
    func createAuthenticationService() -> AuthenticationServiceProtocol {
        AuthenticationService(api: api, baseURL: Constants.Network.baseUrl)
    }
}
