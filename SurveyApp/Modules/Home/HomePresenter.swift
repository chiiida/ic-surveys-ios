//
//  HomePresenter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//  
//

import UIKit

final class HomePresenter {

    let router: HomeRouterInput
    let interactor: HomeInteractorInput

    weak var view: HomeViewInput?
    weak var output: HomeOutput?

    init(
        router: HomeRouterInput,
        interactor: HomeInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - HomeViewOutput

extension HomePresenter: HomeViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
}

// MARK: - HomeInput

extension HomePresenter: HomeInput {
    
    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
