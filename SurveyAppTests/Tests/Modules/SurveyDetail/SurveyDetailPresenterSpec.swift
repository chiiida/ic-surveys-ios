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
            }

            describe("its viewDidLoad is called") {
                beforeEach {
                    let surveys: [Survey] = JSON.SurveyService.surveyModelList.decoded()
                    presenter.survey = surveys[0]
                    presenter.viewDidLoad()
                }

                it("triggers view to configure view") {
                    expect(view.configureWithCalled) == true
                }
                
                it("view should receive survey correctly") {
                    expect(view.configureWithReceivedSurvey?.title) == "Scarlett Bangkok"
                }
            }
        }
    }
}
