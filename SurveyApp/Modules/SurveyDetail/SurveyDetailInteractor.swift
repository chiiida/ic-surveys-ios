//
//  SurveyDetailInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//  
//

// sourcery: AutoMockable
protocol SurveyDetailInteractorInput: AnyObject {
    
    func fetchSurveyDetail(id: String)
}

// sourcery: AutoMockable
protocol SurveyDetailInteractorOutput: AnyObject {
    
    func didFetchSurveyDetail(questions: [SurveyQuestion])
    func didFailToFetchSurveyDetail()
}

final class SurveyDetailInteractor {

    weak var output: SurveyDetailInteractorOutput?
    
    private var surveyService: SurveyServiceProtocol?
    
    private var fetchSurveyDetailRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
    }
}

// MARK: - SurveyDetailInteractorInput

extension SurveyDetailInteractor: SurveyDetailInteractorInput {
    
    func fetchSurveyDetail(id: String) {
        fetchSurveyDetailRequest = surveyService?.fetchSurveyDetail(id: id) { [weak output] result in
            switch result {
            case .success(let response):
                let answers: [SurveyAnswer] = response.included
                    .filter { $0.type == SurveyData.SurveyType.answer.rawValue }
                    .map { SurveyAnswer(data: $0) }
                
                let questions: [SurveyQuestion] = response.included
                    .filter { $0.type == SurveyData.SurveyType.question.rawValue }
                    .compactMap {
                        let attributes = $0.attributes as? SurveyQuestionAttributes
                        let relatedAnswers = $0.relationships?.relationship.data
                        
                        if attributes?.displayType != .intro && attributes?.displayType != .outro {
                            return SurveyQuestion(
                                data: $0,
                                answers: answers.filter { answer in
                                    relatedAnswers?.contains(where: { $0.id == answer.id }) ?? false
                                }
                            )
                        } else {
                            return nil
                        }
                    }
                output?.didFetchSurveyDetail(questions: questions)
            case .failure:
                output?.didFailToFetchSurveyDetail()
            }
        }
    }
}
