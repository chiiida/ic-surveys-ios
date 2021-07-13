//
//  SurveyQuestionPresenterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/12/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyQuestionPresenterSpec: QuickSpec {

    override func spec() {

        var presenter: SurveyQuestionPresenter!
        var router: SurveyQuestionRouterInputMock!
        var interactor: SurveyQuestionInteractorInputMock!
        var view: SurveyQuestionViewInputMock!
        var output: SurveyQuestionOutputMock!

        let sampleQuestions: [SurveyQuestion] = JSON.SurveyService.surveyQuestionModelList.decoded()
        
        describe("a SurveyQuestionPresenter") {
            beforeEach {
                router = SurveyQuestionRouterInputMock()
                interactor = SurveyQuestionInteractorInputMock()
                view = SurveyQuestionViewInputMock()
                presenter = SurveyQuestionPresenter(
                    router: router,
                    interactor: interactor
                )
                output = SurveyQuestionOutputMock()
                presenter.output = output
                presenter.view = view
                
                presenter.surveyId = "d5de6a8f8f5f1cfe51bc"
                presenter.questions = sampleQuestions
            }

            describe("its viewDidLoad is called") {
                beforeEach {
                    presenter.viewDidLoad()
                }

                it("triggers view to configure view") {
                    expect(view.configureWithCalled) == true
                }
                
                it("view should receive questions correctly") {
                    expect(view.configureWithReceivedViewModels?.count) == sampleQuestions.count
                    expect(view.configureWithReceivedViewModels?.first?.text) == sampleQuestions.first?.text
                }
            }
            
            describe("its didSubmitQuestions is called") {
                context("when parameter is valid questions") {
                    beforeEach {
                        let questions: [QuestionSubmission] = JSON.SurveyService.submitSurveyBody.decoded()
                        presenter.didSubmitQuestions(questions: questions)
                    }

                    it("triggers interator to call submitSurvey") {
                        expect(interactor.submitSurveyIdQuestionsCalled) == true
                    }
                    
                    it("interator should receive id and question correctly") {
                        expect(interactor.submitSurveyIdQuestionsReceivedArguments?.id) == "d5de6a8f8f5f1cfe51bc"
                        expect(interactor.submitSurveyIdQuestionsReceivedArguments?.questions.count) == 2
                    }
                }
            }
            
            describe("its didSubmitSurvey is called") {
                context("when parameter is valid questions count") {
                    beforeEach {
                        let questions: [QuestionSubmission] = JSON.SurveyService.submitSurveyBody.decoded()
                        let questionCount = questions.count
                        presenter.didSubmitSurvey(questionCount: questionCount)
                    }
                    
                    it("should not trigger view to call showError") {
                        expect(view.showErrorMessageCalled) == false
                    }
                }
                
                context("when parameter is invalid questions count") {
                    beforeEach {
                        let questionCount = 0
                        presenter.didSubmitSurvey(questionCount: questionCount)
                    }
                    
                    it("triggers view to call showError") {
                        expect(view.showErrorMessageCalled) == true
                    }

                    it("view should receive error message correctly") {
                        expect(view.showErrorMessageReceivedMessage) == Localize.errorIncompleteSurvey()
                    }
                }
            }
            
            describe("its didFailToSubmitSurvey is called") {
                context("when parameter is valid questions count") {
                    beforeEach {
                        let error: APIError = JSON.SurveyService.submitSurveyFailure.decoded()
                        presenter.didFailToSubmitSurvey(error)
                    }
                    
                    it("triggers view to call showError") {
                        expect(view.showErrorMessageCalled) == true
                    }

                    it("view should receive error message correctly") {
                        expect(view.showErrorMessageReceivedMessage) == "Questions is invalid"
                    }
                }
            }
        }
    }
}
