//
//  HomeModuleSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/28/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class HomeModuleSpec: QuickSpec {

    override func spec() {

        var output: HomeOutput!
        var module: HomeModule!

        describe("a HomeModule") {
            describe("its initializers are called") {
                beforeEach {
                    output = HomeOutputMock()
                    module = HomeModule()
                    module.output = output
                }

                it("sets view output with presenter") {
                    let view = module.view
                    expect(view.output).to(beAKindOf(HomePresenter.self))
                }

                it("sets presenter's view, router, interactor, input, output") {
                    let presenter = module.presenter
                    expect(presenter.view).to(beAKindOf(HomeViewController.self))
                    expect(presenter.router).to(beAKindOf(HomeRouter.self))
                    expect(presenter.interactor).to(beAKindOf(HomeInteractor.self))
                    expect(presenter.output) === output
                    expect(presenter) === module.input
                }

                it("sets interactor output with presenter") {
                    let interactor = module.interactor
                    expect(interactor.output).to(beAKindOf(HomePresenter.self))
                }

                it("sets router's view") {
                    let router = module.router
                    expect(router.view).to(beAKindOf(HomeViewController.self))
                }
            }
        }
    }
}
