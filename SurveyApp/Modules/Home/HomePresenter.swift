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
    
    var surveys: [Survey] = []

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
        DispatchQueue.main.async {
            self.view?.dismissSkeletonView()
        }
    }
    
    func didPressDetailButton(surveyIndex: Int) {
        let survey = surveys[surveyIndex]
        router.showSurveyDetail(survey: survey)
    }
    
    func didRefreshSurveys(_ completion: EmptyCompletion? = nil) {
        interactor.fetchSurveys(pageNumber: 1, pageSize: 5)
        DispatchQueue.main.async {
            completion?()
        }
    }
}

// MARK: - HomeInteractorOutput

extension HomePresenter: HomeInteractorOutput {
    
    func didFetchSurveys(surveys: [Survey]) {
        self.surveys = surveys
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
