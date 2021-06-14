//
//  LoginModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol LoginInput: AnyObject {
    
    func setInitialModule(on window: UIWindow)
}

// sourcery: AutoMockable
protocol LoginOutput: AnyObject {
}

final class LoginModule {

    let view: LoginViewController
    let presenter: LoginPresenter
    let router: LoginRouter
    let interactor: LoginInteractor

    var output: LoginOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: LoginInput { presenter }

    init() {
        let authenticationService = NetworkServiceFactory.shared.createAuthenticationService()
        
        view = LoginViewController()
        router = LoginRouter()
        interactor = LoginInteractor(authenticationService: authenticationService)
        presenter = LoginPresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
