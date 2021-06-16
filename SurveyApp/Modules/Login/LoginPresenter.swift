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
    
    func didPressLogin() {
        guard let email = view?.emailInputString, !email.isEmpty else { return }
        guard let password = view?.passwordInputString, !password.isEmpty else { return }

        if email.isValidEmail() {
            interactor.authenticateEmail(email: email, password: password)
        } else {
            view?.showError(message: Localize.errorInvalidEmail())
        }
    }
}

// MARK: - LoginInteractorOutput

extension LoginPresenter: LoginInteractorOutput {
    
    func didAuthenticateEmail() {
        router.showHome()
    }
    
    func didFailToAuthenticateEmail() {
        view?.showError(message: Localize.errorLoginFailed())
    }
}

// MARK: - LoginInput

extension LoginPresenter: LoginInput {
    
    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
