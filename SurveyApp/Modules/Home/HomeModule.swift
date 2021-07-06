//
//  HomeModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol HomeInput: AnyObject {
    
    func setInitialModule(on window: UIWindow)
}

// sourcery: AutoMockable
protocol HomeOutput: AnyObject {
}

final class HomeModule {

    let view: HomeViewController
    let presenter: HomePresenter
    let router: HomeRouter
    let interactor: HomeInteractor

    var output: HomeOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: HomeInput { presenter }

    init() {
        let surveyService = NetworkServiceFactory.shared.createSurveyService()
        
        view = HomeViewController()
        router = HomeRouter()
        interactor = HomeInteractor(surveyService: surveyService)
        presenter = HomePresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
