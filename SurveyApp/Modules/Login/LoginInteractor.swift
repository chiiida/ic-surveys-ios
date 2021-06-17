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
    
    func didAuthenticateEmail()
    func didFailToAuthenticateEmail()
}

final class LoginInteractor {

    weak var output: LoginInteractorOutput?
    
    private(set) var authenticationService: AuthenticationServiceProtocol?
    
    private var authenticateEmailRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(authenticationService: AuthenticationServiceProtocol) {
        self.authenticationService = authenticationService
    }
}

// MARK: - LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
    
    func authenticateEmail(email: String, password: String) {
        authenticateEmailRequest = authenticationService?.authenticateEmail(email: email, password: password) { [weak output] result in
            switch result {
            case .success(let authToken):
                UserSessionProvider.shared.userSession?.userCredential = authToken.session?.userCredential
                output?.didAuthenticateEmail()
            case .failure:
                output?.didFailToAuthenticateEmail()
            }
        }
    }
}
