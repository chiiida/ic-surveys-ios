//
//  HomeInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//  
//

import Foundation

// sourcery: AutoMockable
protocol HomeInteractorInput: AnyObject {
    
    func fetchSurveys(pageNumber: Int, pageSize: Int)
}

// sourcery: AutoMockable
protocol HomeInteractorOutput: AnyObject {
    
    func didFetchSurveys(surveys: [Survey])
    func didFailToFetchSurveys()
}

final class HomeInteractor {

    weak var output: HomeInteractorOutput?
    
    private(set) var surveyService: SurveyServiceProtocol?
    
    private var fetchSurveysRequest: Request? {
        didSet { oldValue?.cancel() }
    }
    
    init(surveyService: SurveyServiceProtocol) {
        self.surveyService = surveyService
    }
}

// MARK: - HomeInteractorInput

extension HomeInteractor: HomeInteractorInput {
    
    func fetchSurveys(pageNumber: Int, pageSize: Int) {
        if !UserStorage.cachedSurveyList.isEmpty {
            output?.didFetchSurveys(surveys: UserStorage.cachedSurveyList)
        }
        
        fetchSurveysRequest = surveyService?.fetchSurveys(pageNumber: pageNumber, pageSize: pageSize) { [weak self] result in
            switch result {
            case .success(let surveyResponse):
                let surveys: [Survey] = surveyResponse.data.map {
                    return Survey(
                        id: $0.id,
                        type: $0.type,
                        title: $0.attributes.title,
                        description: $0.attributes.description,
                        coverImageUrl: $0.attributes.coverImageUrl + "l"
                    )
                }
                
                if !(UserStorage.cachedSurveyList.hasSameChildren(as: surveys)) {
                    UserStorage.cachedSurveyList = surveys
                    self?.output?.didFetchSurveys(surveys: surveys)
                }
            case .failure:
                self?.output?.didFailToFetchSurveys()
            }
        }
    }
}
