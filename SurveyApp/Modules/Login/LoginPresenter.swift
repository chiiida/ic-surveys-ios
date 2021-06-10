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
        
        // TODO: remove mock login use case
        interactor.authenticateEmail(email: "dev@nimblehq.co", password: "12345678")
    }
}

// MARK: - LoginInteractorOutput

extension LoginPresenter: LoginInteractorOutput {

    func didAuthenticateEmail(authToken: AuthToken) {
        // TODO: Intergrate with ViewController
        dump(authToken)
    }
    
    func didFailToAuthenticateEmail(withError error: APIError) {
        // TODO: Intergrate with ViewController
        dump(error)
    }
}

// MARK: - LoginInput

extension LoginPresenter: LoginInput {
    
    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
