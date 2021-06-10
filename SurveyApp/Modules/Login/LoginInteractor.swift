//
//  LoginInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

import Foundation

// sourcery: AutoMockable
protocol LoginInteractorInput: AnyObject {
    
    func authenticateEmail(email: String, password: String)
}

// sourcery: AutoMockable
protocol LoginInteractorOutput: AnyObject {
    
    func didAuthenticateEmail(authToken: AuthToken)
    func didFailToAuthenticateEmail(withError error: APIError)
}

final class LoginInteractor {

    weak var output: LoginInteractorOutput?
    
    private(set) var authenticateService: AuthenticationServiceProtocol?
    
    private var authenticateEmailRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(authenticateService: AuthenticationServiceProtocol) {
        self.authenticateService = authenticateService
    }
}

// MARK: - LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
    
    func authenticateEmail(email: String, password: String) {
        authenticateEmailRequest = authenticateService?.authenticateEmail(email: email, password: password) { [weak output] result in
            switch result {
            case .success(let authToken):
                let userDefaults = UserDefaults.standard
                let accessToken = authToken.data?.attributes?.accessToken
                let refreshToken = authToken.data?.attributes?.refreshToken
                userDefaults.setValue(accessToken, forKey: Constants.UserDefaultsKey.accessToken)
                userDefaults.setValue(refreshToken, forKey: Constants.UserDefaultsKey.refreshToken)
                output?.didAuthenticateEmail(authToken: authToken)
            case .failure(let error):
                output?.didFailToAuthenticateEmail(withError: error)
            }
        }
    }
}
