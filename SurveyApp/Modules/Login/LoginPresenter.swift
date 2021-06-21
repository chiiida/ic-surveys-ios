//
//  LoginPresenter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

import UIKit

final class LoginPresenter {
    
    let router: LoginRouterInput
    let interactor: LoginInteractorInput
    
    weak var view: LoginViewInput?
    weak var output: LoginOutput?
    
    init(
        router: LoginRouterInput,
        interactor: LoginInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - LoginViewOutput

extension LoginPresenter: LoginViewOutput {
    
    func viewDidLoad() {
        view?.configure()
    }
    
    func didPressLogin(email: String, password: String) {
        guard !email.isEmpty && !password.isEmpty else { return }

        guard email.isValidEmail() else {
            view?.showError(message: Localize.errorInvalidEmail())
            return
        }
        interactor.authenticateWithEmail(email: email, password: password)
    }
}

// MARK: - LoginInteractorOutput

extension LoginPresenter: LoginInteractorOutput {
    
    func didAuthenticateWithEmail() {
        router.showHome()
    }
    
    func didFailToAuthenticateWithEmail() {
        view?.showError(message: Localize.errorLoginFailed())
    }
}

// MARK: - LoginInput

extension LoginPresenter: LoginInput {
    
    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
