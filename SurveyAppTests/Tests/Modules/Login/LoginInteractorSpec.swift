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

            describe("its authenticateEmail is called") {
                context("when the request returns success") {
                    beforeEach {
                        authenticationService.authenticateEmailEmailPasswordCompletionClosure = { _, _, completion in
                            let data: AuthToken = JSON.AuthenticationService.authenticateEmailSuccess.decoded()
                            completion(.success(data))
                            return nil
                        }

                        interactor.authenticateWithEmail(email: "email@example.com", password: "password")
                    }

                    it("triggers output to call didAuthenticateWithEmail") {
                        expect(output.didAuthenticateWithEmailCalled) == true
                    }
                }

                context("when the request returns failure") {
                    beforeEach {
                        authenticationService.authenticateEmailEmailPasswordCompletionClosure = { _, _, completion in
                            completion(.failure(APIError()))
                            return nil
                        }

                        interactor.authenticateWithEmail(email: "email@example.com", password: "password")
                    }

                    it("triggers output to call didFailToAuthenticateWithEmail") {
                        expect(output.didFailToAuthenticateWithEmailCalled) == true
                    }
                }
            }
        }
    }
}
