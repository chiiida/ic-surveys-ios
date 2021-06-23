//
//  LoginPresenterSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginPresenterSpec: QuickSpec {

    override func spec() {
        var router: LoginRouterInputMock!
        var interactor: LoginInteractorInputMock!
        var view: LoginViewInputMock!
        var output: LoginOutputMock!
        var presenter: LoginPresenter!

        describe("a LoginPresenter") {
            beforeEach {
                router = LoginRouterInputMock()
                interactor = LoginInteractorInputMock()
                output = LoginOutputMock()
                view = LoginViewInputMock()
                presenter = LoginPresenter(router: router, interactor: interactor)

                presenter.output = output
                presenter.view = view

            }

            describe("its didPressLogin is called") {
                context("when the parameters are valid email and password") {
                    beforeEach {
                        let email = "email@example.com"
                        let password = "password"
                        presenter.didPressLogin(email: email, password: password)
                    }

                    it("triggers interactor to call authenticateEmail") {
                        expect(interactor.authenticateWithEmailEmailPasswordCalled) == true
                    }
                }

                context("when the parameters are empty email and password") {
                    beforeEach {
                        let email = ""
                        let password = ""
                        presenter.didPressLogin(email: email, password: password)
                    }

                    it("should not trigger interactor to call authenticateEmail") {
                        expect(interactor.authenticateWithEmailEmailPasswordCalled) == false
                    }
                }

                context("when the parameter is invalid email") {
                    beforeEach {
                        let email = "email"
                        let password = "password"
                        presenter.didPressLogin(email: email, password: password)
                    }

                    it("triggers view to call showError") {
                        expect(view.showErrorMessageCalled) == true
                    }

                    it("view should receive error message correctly") {
                        expect(view.showErrorMessageReceivedMessage) == Localize.errorInvalidEmail()
                    }
                }
            }

            context("when didAuthenticateEmail is called with valid email and password") {
                beforeEach {
                    presenter.didAuthenticateWithEmail()
                }

                it("triggers router to call showHome") {
                    expect(router.showHomeCalled) == true
                }
            }

            context("when didFailToAuthenticateEmail is called with valid email and password") {
                beforeEach {
                    presenter.didFailToAuthenticateWithEmail()
                }

                it("triggers view to call showError") {
                    expect(view.showErrorMessageCalled) == true
                }

                it("view should receive error message correctly") {
                    expect(view.showErrorMessageReceivedMessage) == Localize.errorLoginFailed()
                }
            }
        }
    }
}
