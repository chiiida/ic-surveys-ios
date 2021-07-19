//
//  SurveyDetailInteractorSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/1/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyDetailInteractorSpec: QuickSpec {

    override func spec() {

        var interactor: SurveyDetailInteractor!
        var output: SurveyDetailInteractorOutputMock!
        var surveyService: SurveyServiceProtocolMock!
        
        let sampleSurveyDetail: SurveyDetailResponse = JSON.SurveyService.fetchSurveyDetailSuccess.decoded()
        let questionAttributes = sampleSurveyDetail.included[1].attributes as? SurveyQuestionAttributes
        
        describe("a SurveyDetailInteractor") {
            beforeEach {
                output = SurveyDetailInteractorOutputMock()
                surveyService = SurveyServiceProtocolMock()
                
                interactor = SurveyDetailInteractor(surveyService: surveyService)
                interactor.output = output
            }
            
            describe("its fetchSurveyDetail is called") {
                context("when the request returns success") {
                    beforeEach {
                        surveyService.fetchSurveyDetailIdCompletionClosure = { _, completion in
                            completion(.success(sampleSurveyDetail))
                            return nil
                        }

                        let surveyId = "d5de6a8f8f5f1cfe51bc"
                        interactor.fetchSurveyDetail(id: surveyId)
                    }

                    it("triggers output to call didFetchSurveyDetail") {
                        expect(output.didFetchSurveyDetailQuestionsCalled) == true
                    }
                    
                    it("output should receive questions correctly") {
                        expect(output.didFetchSurveyDetailQuestionsReceivedQuestions?.count) == 2
                        expect(output.didFetchSurveyDetailQuestionsReceivedQuestions?.first?.text) == questionAttributes?.text
                        expect(output.didFetchSurveyDetailQuestionsReceivedQuestions?.first?.displayType) == questionAttributes?.displayType
                    }
                }

                context("when the request returns failure") {
                    beforeEach {
                        surveyService.fetchSurveyDetailIdCompletionClosure = { _, completion in
                            completion(.failure(APIError()))
                            return nil
                        }

                        let surveyId = "d5de6a8f8f5f1cfe51bc"
                        interactor.fetchSurveyDetail(id: surveyId)
                    }

                    it("triggers output to call didFailToFetchSurveyDetail") {
                        expect(output.didFailToFetchSurveyDetailCalled) == true
                    }
                }
            }
        }
    }
}
