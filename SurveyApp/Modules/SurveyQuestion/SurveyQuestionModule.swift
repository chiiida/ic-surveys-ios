//
//  SurveyQuestionModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//
//

// sourcery: AutoMockable
protocol SurveyQuestionInput: AnyObject {
    
    func setSurveyQuestions(id: String, questions: [SurveyQuestion])
}

// sourcery: AutoMockable
protocol SurveyQuestionOutput: AnyObject {
}

final class SurveyQuestionModule {

    let view: SurveyQuestionViewController
    let presenter: SurveyQuestionPresenter
    let router: SurveyQuestionRouter
    let interactor: SurveyQuestionInteractor

    var output: SurveyQuestionOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: SurveyQuestionInput { presenter }

    init() {
        let surveyService = NetworkServiceFactory.shared.createSurveyService()
        
        view = SurveyQuestionViewController()
        router = SurveyQuestionRouter()
        interactor = SurveyQuestionInteractor(surveyService: surveyService)
        presenter = SurveyQuestionPresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
