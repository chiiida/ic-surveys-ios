//
//  LoginPresenterTests.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginPresenterTests: QuickSpec {
    
    override func spec() {
        var router: LoginRouterInputMock!
        var interactor: LoginInteractorInputMock!
        var view: LoginViewInputMock!
        var output: LoginOutputMock!
        var presenter: LoginPresenter!
        
        describe("LoginPresenter") {
            
            beforeEach {
                router = LoginRouterInputMock()
                interactor = LoginInteractorInputMock()
                output = LoginOutputMock()
                view = LoginViewInputMock()
                presenter = LoginPresenter(router: router, interactor: interactor)
                
                presenter.output = output
                presenter.view = view

            }
            
            context("when didPressLogin() is called and email and password are valid") {

                beforeEach {
                    view.emailInputString = "email@example.com"
                    view.passwordInputString = "password"
                    presenter.didPressLogin()
                }
                
                it("triggers interactor authenticateEmail ") {
                    expect(interactor.authenticateEmailEmailPasswordCalled) == true
                }
            }
            
            context("when didPressLogin() is called and email and password are empty") {

                beforeEach {
                    view.emailInputString = ""
                    view.passwordInputString = ""
                    presenter.didPressLogin()
                }

                it("should not triggers router to show Home screen") {
                    expect(interactor.authenticateEmailEmailPasswordCalled) == false
                    expect(router.showHomeCalled) == false
                }
            }
            
            context("when didPressLogin() is called and email is invalid") {

                beforeEach {
                    view.emailInputString = "email"
                    view.passwordInputString = "password"
                    presenter.didPressLogin()
                }

                it("triggers view to show error") {
                    expect(view.showErrorMessageCalled) == true
                }
                
                it("view should receive error message correctly") {
                    expect(view.showErrorMessageReceivedMessage) == Localize.errorInvalidEmail()
                }
            }
            
            context("when didAuthenticateEmail() is called and email and password are valid") {

                beforeEach {
                    presenter.didAuthenticateEmail()
                }

                it("triggers router to show Home screen") {
                    expect(router.showHomeCalled) == true
                }
            }
            
            context("when didFailToAuthenticateEmail() is called and email and password are valid") {

                beforeEach {
                    presenter.didFailToAuthenticateEmail()
                }

                it("triggers view to show error") {
                    expect(view.showErrorMessageCalled) == true
                }
                
                it("view should receive error message correctly") {
                    expect(view.showErrorMessageReceivedMessage) == Localize.errorLoginFailed()
                }
            }
        }
    }
}
