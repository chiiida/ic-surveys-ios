//
//  HomePresenterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/28/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class HomePresenterSpec: QuickSpec {

    override func spec() {

        var presenter: HomePresenter!
        var router: HomeRouterInputMock!
        var interactor: HomeInteractorInputMock!
        var view: HomeViewInputMock!
        var output: HomeOutputMock!

        describe("a HomePresenter") {
            beforeEach {
                router = HomeRouterInputMock()
                interactor = HomeInteractorInputMock()
                view = HomeViewInputMock()
                presenter = HomePresenter(
                    router: router,
                    interactor: interactor
                )
                output = HomeOutputMock()
                presenter.output = output
                presenter.view = view
            }

            describe("its viewDidLoad is called") {
                beforeEach {
                    presenter.viewDidLoad()
                }

                it("triggers view to configure view") {
                    expect(view.configureCalled) == true
                }
                
                it("triggers interactor to call fetchSurveys") {
                    expect(interactor.fetchSurveysPageNumberPageSizeCalled) == true
                }
            }
            
            describe("its didFetchSurveys is called") {
                context("when parameters are valid pageNumber and pageSize") {
                    beforeEach {
                        let surveys: [Survey] = JSON.SurveyService.surveyModelList.decoded()
                        presenter.didFetchSurveys(surveys: surveys)
                    }
                    
                    it("triggers view to call setUpSurveys") {
                        expect(view.setUpSurveysCalled) == true
                    }
                    
                    it("view should receive surveys correctly") {
                        expect(view.setUpSurveysReceivedSurveys?.count) == 2
                        expect(view.setUpSurveysReceivedSurveys?.first?.title) == "Scarlett Bangkok"
                    }
                }
            }
            
            describe("its didFailToFetchSurveys is called") {
                context("when parameters are valid pageNumber and pageSize") {
                    beforeEach {
                        presenter.didFailToFetchSurveys()
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
