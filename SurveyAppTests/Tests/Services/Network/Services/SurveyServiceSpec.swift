//
//  SurveyServiceSpec.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/28/21.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import SurveyApp

final class SurveyServiceSpec: QuickSpec {
    
    override func spec() {
        
        var surveyService: SurveyService!
        var userSession: UserSessionProtocolMock!
        var api: BaseAPI!
        
        describe("a SurveyService") {
            afterEach {
                HTTPStubs.removeAllStubs()
            }

            beforeEach {
                userSession = UserSessionProtocolMock()
                api = BaseAPI(userSession: userSession)

                surveyService = SurveyService(api: api, baseURL: Defines.baseURL)
            }
            
            // MARK: – fetchSurveys
            describe("its fetchSurveys is called") {
                let pageNumber = 1
                let pageSize = 2
                
                let successRequestQueryParams = [
                    "page[number]": pageNumber,
                    "page[size]": pageSize
                ].toQueryParams()
                
                context("when the request returns success") {
                    it("receives response object correctly") {
                        let data = JSON.SurveyService.fetchSurveysSuccess

                        stub(condition: pathEndsWith("/api/v1/surveys") && containsQueryParams(successRequestQueryParams)) { _ in
                            HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        }

                        waitUntil(timeout: .seconds(10), action: { done in
                            _ = surveyService.fetchSurveys(pageNumber: pageNumber, pageSize: pageSize) { result in
                                switch result {
                                case .success(let response):
                                    let attributes = response.data.first?.attributes as? SurveyAttributes
                                    expect(response.data.count) == 2
                                    expect(attributes?.description) == "We'd love ot hear from you!"
                                case .failure:
                                    fail("result should be successful")
                                }
                                done()
                            }
                        })
                    }
                }
                
                context("when the request returns failure") {
                    it("receives error response object correctly") {
                        let data = JSON.SurveyService.fetchSurveysFailure

                        stub(condition: pathEndsWith("/api/v1/surveys") && containsQueryParams(successRequestQueryParams)) { _ in
                            HTTPStubsResponse(data: data, statusCode: 401, headers: nil)
                        }

                        waitUntil(timeout: .seconds(10), action: { done in
                            _ = surveyService.fetchSurveys(pageNumber: pageNumber, pageSize: pageSize) { result in
                                switch result {
                                case .success:
                                    fail("result should be failure")
                                case .failure(let error):
                                    expect(error.errors?[0].code) == "invalid_token"
                                    expect(error.errors?[0].detail) == "The access token is invalid"
                                }
                                done()
                            }
                        })
                    }
                }
            }
            
            // MARK: – fetchSurveyDetail
            describe("its fetchSurveyDetail is called") {
                let surveyId = "d5de6a8f8f5f1cfe51bc"
                
                context("when the request returns success") {
                    it("receives response object correctly") {
                        let data = JSON.SurveyService.fetchSurveyDetailSuccess

                        stub(condition: pathEndsWith("/api/v1/surveys/\(surveyId)")) { _ in
                            HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        }

                        waitUntil(timeout: .seconds(10), action: { done in
                            _ = surveyService.fetchSurveyDetail(id: surveyId) { result in
                                switch result {
                                case .success(let response):
                                    let attributes = response.included.first?.attributes as? SurveyQuestionAttributes
                                    expect(response.data.relationships?.relationship.data.count) == 2
                                    expect(response.included.first?.type) == SurveyData.SurveyType.question.rawValue
                                    expect(attributes?.text) == "Thank you for visiting Scarlett! Please take a moment to share your feedback."
                                case .failure:
                                    fail("result should be successful")
                                }
                                done()
                            }
                        })
                    }
                }
                
                context("when the request returns failure") {
                    it("receives error response object correctly") {
                        let data = JSON.SurveyService.fetchSurveysFailure

                        stub(condition: pathEndsWith("/api/v1/surveys/\(surveyId)")) { _ in
                            HTTPStubsResponse(data: data, statusCode: 401, headers: nil)
                        }

                        waitUntil(timeout: .seconds(10), action: { done in
                            _ = surveyService.fetchSurveyDetail(id: surveyId) { result in
                                switch result {
                                case .success:
                                    fail("result should be failure")
                                case .failure(let error):
                                    expect(error.errors?[0].code) == "invalid_token"
                                    expect(error.errors?[0].detail) == "The access token is invalid"
                                }
                                done()
                            }
                        })
                    }
                }
            }
        }
    }
}
