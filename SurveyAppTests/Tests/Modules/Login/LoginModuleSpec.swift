//
//  LoginModuleSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginModuleSpec: QuickSpec {

    override func spec() {
        var output: LoginOutput!
        var module: LoginModule!

        describe("a LoginModule") {
            describe("its initializers are called") {
                beforeEach {
                    output = LoginOutputMock()
                    module = LoginModule()
                    module.output = output
                }

                it("sets view's output with presenter") {
                    let view = module.view
                    expect(view.output).to(beAKindOf(LoginPresenter.self))
                }

                it("sets presenter's view, router, interactor, input, output") {
                    let presenter = module.presenter
                    expect(presenter.interactor).to(beAKindOf(LoginInteractor.self))
                    expect(presenter.router).to(beAKindOf(LoginRouter.self))
                    expect(presenter.view).to(beAKindOf(LoginViewController.self))
                    expect(presenter.output) === output
                    expect(presenter) === module.input
                }

                it("sets interactor's output with presenter") {
                    let interactor = module.interactor
                    expect(interactor.output).to(beAKindOf(LoginPresenter.self))
                }

                it("sets router's view") {
                    let router = module.router
                    expect(router.view).to(beAKindOf(LoginViewController.self))
                }
            }
        }
    }
}
