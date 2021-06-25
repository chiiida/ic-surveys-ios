//
//  SplashPresenter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import UIKit

final class SplashPresenter {

    let router: SplashRouterInput
    let interactor: SplashInteractorInput

    weak var view: SplashViewInput?
    weak var output: SplashOutput?

    init(router: SplashRouterInput, interactor: SplashInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SplashViewOutput
extension SplashPresenter: SplashViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
    
    func animationDidFinish() {
        if interactor.isLoggedIn {
            router.showHome()
            return
        } else {
            router.showLogin()
            return
        }
    }
}

// MARK: - SplashInteractorOutput
extension SplashPresenter: SplashInteractorOutput {
}

// MARK: - SplashInput
extension SplashPresenter: SplashInput {

    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
