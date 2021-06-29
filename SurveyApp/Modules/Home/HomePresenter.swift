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
        interactor.fetchSurveys(pageNumber: 1, pageSize: 5)
    }
    
    func didPressDetailButton(survey: SurveyCollectionCellViewModel) {
        // TODO: pass survey to survey detail screen
//        dump(survey)
        router.showSurveyDetail()
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    
    func didFetchSurveys(surveys: [Survey]) {
        let viewModels: [SurveyCollectionCellViewModel] = surveys.map {
            return SurveyCollectionCellViewModel(survey: $0)
        }
        view?.setUpSurveys(viewModels: viewModels)
    }
    
    func didFailToFetchSurveys() {
        view?.showError(message: Localize.errorFetchSurveys())
    }
}

// MARK: - HomeInput

extension HomePresenter: HomeInput {
    
    func setInitialModule(on window: UIWindow) {
        router.show(on: window)
    }
}
