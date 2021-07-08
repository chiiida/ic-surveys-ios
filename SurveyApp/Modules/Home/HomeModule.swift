//
//  HomeModule.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//  
//

import UIKit

// sourcery: AutoMockable
protocol HomeInput: AnyObject {
    
    func setInitialModule(on window: UIWindow)
}

// sourcery: AutoMockable
protocol HomeOutput: AnyObject {
}

final class HomeModule {

    let view: HomeViewController
    let presenter: HomePresenter
    let router: HomeRouter
    let interactor: HomeInteractor

    var output: HomeOutput? {
        get { presenter.output }
        set { presenter.output = newValue }
    }

    var input: HomeInput { presenter }

    init() {
        let surveyService = NetworkServiceFactory.shared.createSurveyService()
        
        view = HomeViewController()
        router = HomeRouter()
        interactor = HomeInteractor(surveyService: surveyService)
        presenter = HomePresenter(
            router: router,
            interactor: interactor
        )

        view.output = presenter

        presenter.view = view

        interactor.output = presenter

        router.view = view
        
        let question = [
            QuestionSubmission(
                id: "940d229e4cd87cd1e202",
                answers: [AnswerSubmission(id: "037574cb93d16800eecd", answers: nil)]
            ),
            QuestionSubmission(
                id: "c3a9b8ce5c2356010703",
                answers: [
                    AnswerSubmission(id: "2a49e148c5b170aca804", answers: "my answer"),
                    AnswerSubmission(id: "2a49e148c5b170aca804", answers: "my answer")
                ]
            )
        ]
        
        surveyService.submitSurvey(id: "d5de6a8f8f5f1cfe51bc", questions: question) { result in
            switch result {
            case .success:
                print("yes")
            case .failure(let err):
                dump(err)
            }
        }
    }
}
