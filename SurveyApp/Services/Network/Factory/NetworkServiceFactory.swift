//
//  NetworkServiceFactory.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Foundation

final class NetworkServiceFactory {
    
    static let shared = NetworkServiceFactory()
    let api: API

    init() {
        let keychain = KeychainStorage.default

        let userSession = UserSession(keychain: keychain)
        UserSessionProvider.shared.userSession = userSession

        api = BaseAPI(userSession: userSession)
    }
    
    func createAuthenticationService() -> AuthenticationServiceProtocol {
        AuthenticationService(api: api, baseURL: Constants.Network.baseUrl)
    }
}
