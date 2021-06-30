//
//  SplashModuleSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/24/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SplashModuleSpec: QuickSpec {

    override func spec() {

        var output: SplashOutput!
        var module: SplashModule!

        describe("a SplashModule") {
            describe("its initializers are called") {
                beforeEach {
                    output = SplashOutputMock()
                    module = SplashModule()
                    module.output = output
                }

                it("sets view output with presenter") {
                    let view = module.view
                    expect(view.output).to(beAKindOf(SplashPresenter.self))
                }

                it("sets presenter's view, router, interactor, input, output") {
                    let presenter = module.presenter
                    expect(presenter.view).to(beAKindOf(SplashViewController.self))
                    expect(presenter.router).to(beAKindOf(SplashRouter.self))
                    expect(presenter.interactor).to(beAKindOf(SplashInteractor.self))
                    expect(presenter.output) === output
                    expect(presenter) === module.input
                }

                it("sets interactor output with presenter") {
                    let interactor = module.interactor
                    expect(interactor.output).to(beAKindOf(SplashPresenter.self))
                }

                it("sets router's view") {
                    let router = module.router
                    expect(router.view).to(beAKindOf(SplashViewController.self))
                }
            }
        }
    }
}
