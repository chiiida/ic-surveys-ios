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
        guard let survey = survey else { return }
        view?.configure(with: survey)
    }
    
    func didPressStartSurvey() {
        guard let survey = survey else { return }
        interactor.fetchSurveyDetail(id: survey.id)
    }
}

// MARK: - SurveyDetailInteractorOutput

extension SurveyDetailPresenter: SurveyDetailInteractorOutput {
    
    func didFetchSurveyDetail(questions: [SurveyQuestion]) {
        guard let survey = survey else { return }
        router.showSurveyQuestion(id: survey.id, questions: questions)
    }
    
    func didFailToFetchSurveyDetail() {
        view?.showError(message: Localize.errorFetchSurveys())
    }
}

// MARK: - SurveyDetailInput

extension SurveyDetailPresenter: SurveyDetailInput {
    
    func setSurvey(survey: Survey) {
        self.survey = survey
    }
}
