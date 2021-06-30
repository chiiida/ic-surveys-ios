//
//  SplashRouter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol SplashRouterInput: AnyObject {

    func show(on window: UIWindow)
    func showLogin()
    func showHome()
}

final class SplashRouter {

    weak var view: SplashViewInput?

    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - SplashRouterInput
extension SplashRouter: SplashRouterInput {

    func show(on window: UIWindow) {
        guard let viewController = viewController else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
    
    func showLogin() {
        guard let window = viewController?.view.window else { return }
        let module = LoginModule()
        module.router.show(on: window)
    }
    
    func showHome() {
        guard let window = viewController?.view.window else { return }
        let module = HomeModule()
        module.router.show(on: window)
    }
}
