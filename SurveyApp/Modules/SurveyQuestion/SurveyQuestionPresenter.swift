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
    
    private(set) var id: String?
    private(set) var questions: [SurveyQuestion]? 

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
        if let questions = questions {
            let viewModels: [QuestionCollectionCellViewModel] = questions.map {
                return QuestionCollectionCellViewModel(question: $0)
            }
            view?.configure(with: viewModels)
        }
    }
}

// MARK: - SurveyInteractorOutput

extension SurveyQuestionPresenter: SurveyQuestionInteractorOutput {
}

// MARK: - SurveyQuestionInput

extension SurveyQuestionPresenter: SurveyQuestionInput {
        
    func setSurveyQuestions(id: String, questions: [SurveyQuestion]) {
        self.id = id
        self.questions = questions
    }
}
