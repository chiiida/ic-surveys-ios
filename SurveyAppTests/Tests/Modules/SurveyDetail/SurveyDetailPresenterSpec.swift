//
//  SurveyDetailPresenterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/1/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyDetailPresenterSpec: QuickSpec {

    override func spec() {

        var presenter: SurveyDetailPresenter!
        var router: SurveyDetailRouterInputMock!
        var interactor: SurveyDetailInteractorInputMock!
        var view: SurveyDetailViewInputMock!
        var output: SurveyDetailOutputMock!
        
        let sampleSurveys: [Survey] = JSON.SurveyService.surveyModelList.decoded()

        describe("a SurveyDetailPresenter") {
            beforeEach {
                router = SurveyDetailRouterInputMock()
                interactor = SurveyDetailInteractorInputMock()
                view = SurveyDetailViewInputMock()
                presenter = SurveyDetailPresenter(
                    router: router,
                    interactor: interactor
                )
                output = SurveyDetailOutputMock()
                presenter.output = output
                presenter.view = view
                
                presenter.survey = sampleSurveys[0]
            }

            describe("its viewDidLoad is called") {
                beforeEach {
                    presenter.viewDidLoad()
                }

                it("triggers view to configure view") {
                    expect(view.configureWithCalled) == true
                }
                
                it("view should receive survey correctly") {
                    expect(view.configureWithReceivedSurvey?.title) == sampleSurveys[0].title
                }
            }
            
            describe("its didPressStartSurvey is called") {
                beforeEach {
                    presenter.didPressStartSurvey()
                }

                it("triggers interator to call fetchSurveyDetail") {
                    expect(interactor.fetchSurveyDetailIdCalled) == true
                }
                
                it("view should receive survey correctly") {
                    expect(interactor.fetchSurveyDetailIdReceivedId) == sampleSurveys[0].id
                }
            }
            
            describe("its didFetchSurveyDetail is called") {
                context("when parameters are valid id and questions") {
                    beforeEach {
                        let questions: [SurveyQuestion] = JSON.SurveyService.surveyQuestionModelList.decoded()
                        presenter.didFetchSurveyDetail(questions: questions)
                    }
                    
                    it("triggers router to call showSurveyQuestion") {
                        expect(router.showSurveyQuestionIdQuestionsCalled) == true
                    }
                    
                    it("view should receive surveys correctly") {
                        expect(router.showSurveyQuestionIdQuestionsReceivedArguments?.id) == sampleSurveys[0].id
                        expect(router.showSurveyQuestionIdQuestionsReceivedArguments?.questions.count) == 2
                        expect(router.showSurveyQuestionIdQuestionsReceivedArguments?.questions[0].displayType) == .star
                    }
                }
            }
            
            describe("its didFailToFetchSurveyDetail is called") {
                context("when parameters are valid id and questions") {
                    beforeEach {
                        presenter.didFailToFetchSurveyDetail()
                    }
                    
                    it("triggers view to call showError") {
                        expect(view.showErrorMessageCalled) == true
                    }

                    it("view should receive error message correctly") {
                        expect(view.showErrorMessageReceivedMessage) == Localize.errorFetchSurveys()
                    }
                }
            }
        }
    }
}
