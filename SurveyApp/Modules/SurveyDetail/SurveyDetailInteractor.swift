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
    
    private(set) var surveyService: SurveyServiceProtocol?
    
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
                    .compactMap {
                        let attributes = $0.attributes as? SurveyAnswerAttributes
                        return SurveyAnswer(
                            id: $0.id,
                            displayOrder: attributes?.displayOrder ?? 0,
                            text: attributes?.text ?? "",
                            inputPlaceholder: attributes?.inputMaskPlaceholder,
                            inputMask: attributes?.inputMask
                        )
                    }
                
                let questions: [SurveyQuestion] = response.included
                    .filter { $0.type == SurveyData.SurveyType.question.rawValue }
                    .compactMap {
                        let attributes = $0.attributes as? SurveyQuestionAttributes
                        let relationship = $0.relationships?.relationship.data
                        
                        if attributes?.displayType != "intro" && attributes?.displayType != "outro" {
                            var displayType: QuestionDisplayType {
                                guard let displayType = QuestionDisplayType(rawValue: attributes?.displayType ?? "") else { return .choice }
                                return displayType
                            }
                            
                            var pickType: SurveyQuestion.PickType {
                                guard let pickType = SurveyQuestion.PickType(rawValue: attributes?.pick ?? "") else { return .none }
                                return pickType
                            }
                            return SurveyQuestion(
                                id: $0.id,
                                displayOrder: attributes?.displayOrder ?? 0,
                                displayType: displayType,
                                text: attributes?.text ?? "",
                                pickType: pickType,
                                coverImageUrl: attributes?.coverImageUrl ?? "",
                                answers: answers.filter { answer in
                                    relationship?.contains(where: { $0.id == answer.id }) ?? false
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
