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

            context("when didPressLogin is called with valid email and password") {
                beforeEach {
                    let email = "email@example.com"
                    let password = "password"
                    presenter.didPressLogin(email: email, password: password)
                }

                it("triggers interactor authenticateEmail") {
                    expect(interactor.authenticateWithEmailEmailPasswordCalled) == true
                }
            }

            context("when didPressLogin is called with empty email and password") {
                beforeEach {
                    let email = ""
                    let password = ""
                    presenter.didPressLogin(email: email, password: password)
                }

                it("should not triggers interactor authenticateEmail") {
                    expect(interactor.authenticateWithEmailEmailPasswordCalled) == false
                }
            }

            context("when didPressLogin is called with invalid email") {
                beforeEach {
                    let email = "email"
                    let password = "password"
                    presenter.didPressLogin(email: email, password: password)
                }

                it("triggers view to show error") {
                    expect(view.showErrorMessageCalled) == true
                }

                it("view should receive error message correctly") {
                    expect(view.showErrorMessageReceivedMessage) == Localize.errorInvalidEmail()
                }
            }

            context("when didAuthenticateEmail is called with valid email and password") {
                beforeEach {
                    presenter.didAuthenticateWithEmail()
                }

                it("triggers router to show Home screen") {
                    expect(router.showHomeCalled) == true
                }
            }

            context("when didFailToAuthenticateEmail is called with valid email and password") {
                beforeEach {
                    presenter.didFailToAuthenticateWithEmail()
                }

                it("triggers view to show error") {
                    expect(view.showErrorMessageCalled) == true
                }

                it("view should receives error message correctly") {
                    expect(view.showErrorMessageReceivedMessage) == Localize.errorLoginFailed()
                }
            }
        }
    }
}
