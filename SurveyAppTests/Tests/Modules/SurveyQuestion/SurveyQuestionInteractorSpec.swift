//
//  SurveyQuestionInteractorSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/12/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyQuestionInteractorSpec: QuickSpec {

    override func spec() {

        var interactor: SurveyQuestionInteractor!
        var output: SurveyQuestionInteractorOutputMock!
        var surveyService: SurveyServiceProtocolMock!

        describe("a SurveyQuestionInteractor") {
            beforeEach {
                surveyService = SurveyServiceProtocolMock()
                output = SurveyQuestionInteractorOutputMock()
                
                interactor = SurveyQuestionInteractor(surveyService: surveyService)
                interactor.output = output
            }
            
            describe("its submitSurvey is called") {
                context("when the request returns success") {
                    beforeEach {
                        surveyService.submitSurveyIdQuestionsCompletionClosure = { _, _, completion in
                            let data = EmptyResponse()
                            completion(.success(data))
                            return nil
                        }

                        let surveyId = "d5de6a8f8f5f1cfe51bc"
                        let questions: [QuestionSubmission] = JSON.SurveyService.submitSurveyBody.decoded()
                        interactor.submitSurvey(id: surveyId, questions: questions)
                    }

                    it("triggers output to call didSubmitSurvey") {
                        expect(output.didSubmitSurveyQuestionCountCalled) == true
                    }
                    
                    it("output should receive questions count correctly") {
                        expect(output.didSubmitSurveyQuestionCountReceivedQuestionCount) == 2
                    }
                }

                context("when the request returns failure") {
                    beforeEach {
                        surveyService.submitSurveyIdQuestionsCompletionClosure = { _, _, completion in
                            let error: APIError = JSON.SurveyService.submitSurveyFailure.decoded()
                            completion(.failure(error))
                            return nil
                        }

                        let surveyId = "d5de6a8f8f5f1cfe51bc"
                        let questions: [QuestionSubmission] = JSON.SurveyService.submitSurveyBody.decoded()
                        interactor.submitSurvey(id: surveyId, questions: questions)
                    }

                    it("triggers output to call didFailToSubmitSurvey") {
                        expect(output.didFailToSubmitSurveyCalled) == true
                    }
                    
                    it("output should receive error correctly") {
                        expect(output.didFailToSubmitSurveyReceivedError?.errors?.first?.detail) == "Questions is invalid"
                    }
                }
            }
        }
    }
}
