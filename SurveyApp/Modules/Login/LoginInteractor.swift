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
        authenticateEmailRequest = authenticateService?.authenticateEmail(email: email, password: password) { result in
            switch result {
            case .success(let authToken):
                let userDefaults = UserDefaults.standard
                let accessToken = authToken.data?.attributes?.accessToken
                let refreshToken = authToken.data?.attributes?.refreshToken
                userDefaults.setValue(accessToken, forKey: Constants.UserDefaultsKey.accessToken)
                userDefaults.setValue(refreshToken, forKey: Constants.UserDefaultsKey.refreshToken)
                // TODO: Connect with LoginPresenter
                dump(authToken)
            case .failure(let error):
                // TODO: Connect with LoginPresenter
                print(error)
            }
        }
    }
}
