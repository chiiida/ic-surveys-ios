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
    
    var surveyId: String?
    var questions: [SurveyQuestion]? 

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
    
    func didSubmitQuestions(questions: [QuestionSubmission]) {
        if let surveyId = surveyId {
            interactor.submitSurvey(id: surveyId, questions: questions)
        }
    }
}

// MARK: - SurveyInteractorOutput

extension SurveyQuestionPresenter: SurveyQuestionInteractorOutput {
    
    func didSubmitSurvey(questionCount: Int) {
        if let questions = questions, questionCount < questions.count {
            view?.showError(message: Localize.errorIncompleteSurvey())
        } else {
            view?.popToRootViewController()
        }
    }
    
    func didFailToSubmitSurvey(_ error: APIError) {
        view?.showError(message: error.errors?[0].detail ?? Localize.errorSubmitSurvey())
    }
}

// MARK: - SurveyQuestionInput

extension SurveyQuestionPresenter: SurveyQuestionInput {
        
    func setSurveyQuestions(id: String, questions: [SurveyQuestion]) {
        self.surveyId = id
        self.questions = questions
    }
}
