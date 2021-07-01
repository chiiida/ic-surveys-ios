//
//  SurveyDetailModuleSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 7/1/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SurveyDetailModuleSpec: QuickSpec {

    override func spec() {

        var output: SurveyDetailOutput!
        var module: SurveyDetailModule!

        describe("a SurveyDetailModule") {
            describe("its initializers are called") {
                beforeEach {
                    output = SurveyDetailOutputMock()
                    module = SurveyDetailModule()
                    module.output = output
                }

                it("sets view output with presenter") {
                    let view = module.view
                    expect(view.output).to(beAKindOf(SurveyDetailPresenter.self))
                }

                it("sets presenter's view, router, interactor, input, output") {
                    let presenter = module.presenter
                    expect(presenter.view).to(beAKindOf(SurveyDetailViewController.self))
                    expect(presenter.router).to(beAKindOf(SurveyDetailRouter.self))
                    expect(presenter.interactor).to(beAKindOf(SurveyDetailInteractor.self))
                    expect(presenter.output) === output
                    expect(presenter) === module.input
                }

                it("sets interactor output with presenter") {
                    let interactor = module.interactor
                    expect(interactor.output).to(beAKindOf(SurveyDetailPresenter.self))
                }

                it("sets router's view") {
                    let router = module.router
                    expect(router.view).to(beAKindOf(SurveyDetailViewController.self))
                }
            }
        }
    }
}
