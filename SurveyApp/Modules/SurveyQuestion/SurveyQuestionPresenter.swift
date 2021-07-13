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
        guard let questions = questions else { return }
        let viewModels: [QuestionCollectionCellViewModel] = questions.map {
            return QuestionCollectionCellViewModel(question: $0)
        }
        view?.configure(with: viewModels)
    }
    
    func didSubmitQuestions(questions: [QuestionSubmission]) {
        guard let surveyId = surveyId else { return }
        interactor.submitSurvey(id: surveyId, questions: questions)
    }
}

// MARK: - SurveyInteractorOutput

extension SurveyQuestionPresenter: SurveyQuestionInteractorOutput {
    
    func didSubmitSurvey(questionCount: Int) {
        guard let questions = questions, questionCount == questions.count else {
            view?.showError(message: Localize.errorIncompleteSurvey())
            return
        }
        view?.popToRootViewController()
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
