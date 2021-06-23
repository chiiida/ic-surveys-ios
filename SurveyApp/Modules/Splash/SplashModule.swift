//
//  SplashModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol SplashInput: AnyObject {

    func setInitialModule(on window: UIWindow)
}

// sourcery: AutoMockable
protocol SplashOutput: AnyObject {
}

final class SplashModule {

    let view: SplashViewController
    let presenter: SplashPresenter
    let router: SplashRouter

    var output: SplashOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: SplashInput { presenter }

    init() {
        view = SplashViewController()
        router = SplashRouter()
        presenter = SplashPresenter(router: router)

        view.output = presenter

        presenter.view = view
        
        interactor.output = presenter

        router.view = view
    }
}
