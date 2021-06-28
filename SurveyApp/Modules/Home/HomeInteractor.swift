//
//  HomeInteractor.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/14/21.
//  
//

// sourcery: AutoMockable
protocol HomeInteractorInput: AnyObject {
    
    func fetchSurveys(pageNumber: Int, pageSize: Int)
}

// sourcery: AutoMockable
protocol HomeInteractorOutput: AnyObject {
    
    func didFetchSurveys(surveys: [Survey])
    func didFailToFetchSurveys(_ error: APIError)
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
        fetchSurveysRequest = surveyService?.fetchSurveys(pageNumber: pageNumber, pageSize: pageSize) { [weak output] result in
            switch result {
            case .success(let surveyResponse):
                let surveys: [Survey] = surveyResponse.data.map {
                    return Survey(
                        id: $0.id,
                        title: $0.attributes.title,
                        description: $0.attributes.description,
                        coverImageUrl: $0.attributes.coverImageUrl + "l"
                    )
                }
                output?.didFetchSurveys(surveys: surveys)
            case .failure(let error):
                output?.didFailToFetchSurveys(error)
            }
        }
    }
}
