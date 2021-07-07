//
//  SurveyQuestionPresenter.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//  
//

final class SurveyQuestionPresenter {

    let router: SurveyQuestionRouterInput
    let interactor: SurveyQuestionInteractorInput

    weak var view: SurveyQuestionViewInput?
    weak var output: SurveyQuestionOutput?

    init(
        router: SurveyQuestionRouterInput,
        interactor: SurveyQuestionInteractorInput
    ) {
        self.router = router
        self.interactor = interactor
    }
}

// MARK: - SurveyQuestionViewOutput

extension SurveyQuestionPresenter: SurveyQuestionViewOutput {

    func viewDidLoad() {
        view?.configure()
    }
}

// MARK: - SurveyInteractorOutput

extension SurveyQuestionPresenter: SurveyQuestionInteractorOutput {
}

// MARK: - SurveyQuestionInput

extension SurveyQuestionPresenter: SurveyQuestionInput {
}
