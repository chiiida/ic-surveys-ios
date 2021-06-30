//
//  LoginInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

// sourcery: AutoMockable
protocol LoginInteractorInput: AnyObject {
    
    func authenticateWithEmail(email: String, password: String)
}

// sourcery: AutoMockable
protocol LoginInteractorOutput: AnyObject {
    
    func didAuthenticateWithEmail()
    func didFailToAuthenticateWithEmail()
}

final class LoginInteractor {

    weak var output: LoginInteractorOutput?
    
    private(set) var authenticationService: AuthenticationServiceProtocol?
    private(set) var userSessionProvider: UserSessionProviderProtocol?
    
    private var authenticateEmailRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(
        authenticationService: AuthenticationServiceProtocol,
        userSessionProvider: UserSessionProviderProtocol
    ) {
        self.authenticationService = authenticationService
        self.userSessionProvider = userSessionProvider
    }
}

// MARK: - LoginInteractorInput

extension LoginInteractor: LoginInteractorInput {
    
    func authenticateWithEmail(email: String, password: String) {
        authenticateEmailRequest = authenticationService?
            .authenticateEmail(email: email, password: password) { [weak output, weak self] result in
                switch result {
                case .success(let authToken):
                    self?.userSessionProvider?.userSession?.userCredential = authToken.session?.userCredential
                    output?.didAuthenticateWithEmail()
                case .failure:
                    output?.didFailToAuthenticateWithEmail()
                }
            }
    }
}
