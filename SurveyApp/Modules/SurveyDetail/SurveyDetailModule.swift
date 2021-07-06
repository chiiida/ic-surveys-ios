//
//  SurveyDetailModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

// sourcery: AutoMockable
protocol SurveyDetailInput: AnyObject {
    
    func setSurvey(survey: Survey)
}

// sourcery: AutoMockable
protocol SurveyDetailOutput: AnyObject {
}

final class SurveyDetailModule {

    let view: SurveyDetailViewController
    let presenter: SurveyDetailPresenter
    let router: SurveyDetailRouter
    let interactor: SurveyDetailInteractor

    var output: SurveyDetailOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: SurveyDetailInput { presenter }

    init() {
        view = SurveyDetailViewController()
        router = SurveyDetailRouter()
        interactor = SurveyDetailInteractor()
        presenter = SurveyDetailPresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
    }
}
