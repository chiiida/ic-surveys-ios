//
//  HomeInteractorSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/28/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class HomeInteractorSpec: QuickSpec {

    override func spec() {

        var interactor: HomeInteractor!
        var output: HomeInteractorOutputMock!
        var surveyService: SurveyServiceProtocolMock!

        describe("a HomeInteractor") {
            beforeEach {
                output = HomeInteractorOutputMock()
                surveyService = SurveyServiceProtocolMock()
                
                interactor = HomeInteractor(surveyService: surveyService)
                interactor.output = output
            }
            
            afterEach {
                interactor.cachedSurveyList = []
            }
            
            describe("its fetchSurveys is called") {
                context("when the request returns success") {
                    beforeEach {
                        surveyService.fetchSurveysPageNumberPageSizeCompletionClosure = { _, _, completion in
                            let data: SurveyResponse = JSON.SurveyService.fetchSurveysSuccess.decoded()
                            completion(.success(data))
                            return nil
                        }

                        interactor.cachedSurveyList = []
                        interactor.fetchSurveys(pageNumber: 1, pageSize: 2)
                    }

                    it("triggers output to call didFetchSurveys") {
                        expect(output.didFetchSurveysSurveysCalled) == true
                    }
                    
                    it("output should receive survey correctly") {
                        expect(output.didFetchSurveysSurveysReceivedSurveys?.count) == 2
                        expect(output.didFetchSurveysSurveysReceivedSurveys?.first?.title) == "Scarlett Bangkok"
                    }
                }

                context("when the request returns failure") {
                    beforeEach {
                        surveyService.fetchSurveysPageNumberPageSizeCompletionClosure = { _, _, completion in
                            completion(.failure(APIError()))
                            return nil
                        }

                        interactor.cachedSurveyList = []
                        interactor.fetchSurveys(pageNumber: 1, pageSize: 2)
                    }

                    it("triggers output to call didFailToFetchSurveys") {
                        expect(output.didFailToFetchSurveysCalled) == true
                    }
                }
            }
        }
    }
}
