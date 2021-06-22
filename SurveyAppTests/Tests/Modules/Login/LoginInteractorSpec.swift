//
//  LoginInteractorSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginInteractorSpec: QuickSpec {

    override func spec() {
        var interactor: LoginInteractor!
        var output: LoginInteractorOutputMock!
        var authenticationService: AuthenticationServiceProtocolMock!
        var userSessionProvider: UserSessionProviderProtocol!

        describe("a LoginInteractor") {
            beforeEach {
                output = LoginInteractorOutputMock()
                authenticationService = AuthenticationServiceProtocolMock()
                userSessionProvider = UserSessionProviderProtocolMock()

                interactor = LoginInteractor(
                    authenticationService: authenticationService,
                    userSessionProvider: userSessionProvider
                )
                interactor.output = output
            }

            describe("when authenticateEmail is called") {
                context("the request returns success") {
                    beforeEach {
                        authenticationService.authenticateEmailEmailPasswordCompletionClosure = { _, _, closure in
                            let data: AuthToken = JSON.AuthenticationService.authenticateEmailSuccess.decoded()
                            closure(.success(data))
                            return nil
                        }

                        interactor.authenticateWithEmail(email: "email@example.com", password: "password")
                    }

                    it("triggers output call authentication with email succesfully ") {
                        expect(output.didAuthenticateWithEmailCalled) == true
                    }
                }

                context("the request returns failure") {
                    beforeEach {
                        authenticationService.authenticateEmailEmailPasswordCompletionClosure = { _, _, closure in
                            closure(.failure(APIError()))
                            return nil
                        }

                        interactor.authenticateWithEmail(email: "email@example.com", password: "password")
                    }

                    it("triggers output call authentication with email failure ") {
                        expect(output.didFailToAuthenticateWithEmailCalled) == true
                    }
                }
            }
        }
    }
}
