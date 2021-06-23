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
}
