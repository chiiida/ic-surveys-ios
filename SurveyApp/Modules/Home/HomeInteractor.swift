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
    
    private var surveyService: SurveyServiceProtocol?
    
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
                let surveys: [Survey] = surveyResponse.data.compactMap {
                    let attributes = $0.attributes as? SurveyAttributes
                    return Survey(
                        id: $0.id,
                        type: $0.type,
                        title: attributes?.title ?? "",
                        description: attributes?.description ?? "",
                        coverImageUrl: attributes?.coverImageUrl ?? ""
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
