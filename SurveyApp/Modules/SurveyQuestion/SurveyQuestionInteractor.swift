//
//  SurveyQuestionInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/5/21.
//  
//

// sourcery: AutoMockable
protocol SurveyQuestionInteractorInput: AnyObject {
    
    func submitSurvey(id: String, question: [QuestionSubmission])
}

// sourcery: AutoMockable
protocol SurveyQuestionInteractorOutput: AnyObject {
    
    func didSubmitSurvey()
    func didFailToSubmitSurvey(_ error: APIError)
}

final class SurveyQuestionInteractor {

    weak var output: SurveyQuestionInteractorOutput?
    
    private(set) var surveyService: SurveyServiceProtocol?
    
    private var submitSurveyRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
    }
}

// MARK: - SurveyQuestionInteractorInput

extension SurveyQuestionInteractor: SurveyQuestionInteractorInput {
    
    func submitSurvey(id: String, question: [QuestionSubmission]) {
        submitSurveyRequest = surveyService?.submitSurvey(id: id, questions: question) { [weak output] result in
            switch result {
            case .success:
                output?.didSubmitSurvey()
            case .failure(let error):
                output?.didFailToSubmitSurvey(error)
            }
        }
    }
}
