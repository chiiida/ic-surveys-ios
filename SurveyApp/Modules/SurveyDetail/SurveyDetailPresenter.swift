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
    
    internal var survey: Survey?

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
        if let survey = survey {
            view?.configure(with: survey)
        }
    }
}

// MARK: - SurveyDetailInteractorOutput

extension SurveyDetailPresenter: SurveyDetailInteractorOutput {
    
    func didPressStartSurvey() {
        router.showSurveyQuestion()
    }
}

// MARK: - SurveyDetailInput

extension SurveyDetailPresenter: SurveyDetailInput {
    
    func setSurvey(survey: Survey) {
        self.survey = survey
    }
}
