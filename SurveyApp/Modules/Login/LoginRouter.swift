//
//  LoginRouter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/7/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol LoginRouterInput: AnyObject {
    
    func show(on window: UIWindow)
    func showHome()
}

final class LoginRouter {
    
    weak var view: LoginViewInput?
    
    private var viewController: UIViewController? {
        view as? UIViewController
    }
}

// MARK: - LoginRouterInput

extension LoginRouter: LoginRouterInput {
    
    func show(on window: UIWindow) {
        guard let viewController = viewController else { return }
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
    }
    
    func showHome() {
        guard let window = viewController?.view.window else { return }
        let module = HomeModule()
        module.router.show(on: window)
    }
}
