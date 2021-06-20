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

    weak var view: SplashViewInput?
    weak var output: SplashOutput?

    init(router: SplashRouterInput) {
        self.router = router
    }
}

// MARK: - SplashViewOutput
extension SplashPresenter: SplashViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
    
    func showNextScreen() {
        // TODO: update logic
        if !UserSessionProvider.shared.isLoggedIn {
            router.showLogin()
        }
    }
}

// MARK: - SplashInput
extension SplashPresenter: SplashInput {

    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
