//
//  SurveyDetailPresenter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

import UIKit

final class SurveyDetailPresenter {

    let router: SurveyDetailRouterInput
    let interactor: SurveyDetailInteractorInput

    weak var view: SurveyDetailViewInput?
    weak var output: SurveyDetailOutput?

    init(
        router: SurveyDetailRouterInput,
        interactor: SurveyDetailInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SurveyDetailViewOutput

extension SurveyDetailPresenter: SurveyDetailViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
}

// MARK: - SurveyDetailInteractorOutput

extension SurveyDetailPresenter: SurveyDetailInteractorOutput {
}

// MARK: - SurveyDetailInput

extension SurveyDetailPresenter: SurveyDetailInput {
}
