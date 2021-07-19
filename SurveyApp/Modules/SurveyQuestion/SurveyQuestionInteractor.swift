//
//  SurveyQuestionInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//  
//

// sourcery: AutoMockable
protocol SurveyQuestionInteractorInput: AnyObject {
    
    func submitSurvey(id: String, questions: [QuestionSubmission])
}

// sourcery: AutoMockable
protocol SurveyQuestionInteractorOutput: AnyObject {
    
    func didSubmitSurvey(questionCount: Int)
    func didFailToSubmitSurvey(_ error: APIError)
}

final class SurveyQuestionInteractor {

    weak var output: SurveyQuestionInteractorOutput?
    
    private var surveyService: SurveyServiceProtocol?
    
    private var submitSurveyRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
    }
}

// MARK: - SurveyQuestionInteractorInput

extension SurveyQuestionInteractor: SurveyQuestionInteractorInput {
    
    func submitSurvey(id: String, questions: [QuestionSubmission]) {
        submitSurveyRequest = surveyService?.submitSurvey(id: id, questions: questions) { [weak output] result in
            switch result {
            case .success:
                output?.didSubmitSurvey(questionCount: questions.count)
            case .failure(let error):
                output?.didFailToSubmitSurvey(error)
            }
        }
    }
}
