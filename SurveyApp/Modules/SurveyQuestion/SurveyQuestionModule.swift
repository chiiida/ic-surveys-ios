//
//  SurveyQuestionModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//
//

// sourcery: AutoMockable
protocol SurveyQuestionInput: AnyObject {
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
        view = SurveyQuestionViewController()
        router = SurveyQuestionRouter()
        interactor = SurveyQuestionInteractor()
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
