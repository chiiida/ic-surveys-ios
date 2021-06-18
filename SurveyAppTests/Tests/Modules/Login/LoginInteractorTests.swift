//
//  LoginInteractorTests.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/17/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class LoginInteractorTests: QuickSpec {

    override func spec() {
        var interactor: LoginInteractor!
        var output: LoginInteractorOutputMock!
        var authenticationService: AuthenticationServiceProtocolMock!
        
        describe("LoginInteractor") {
            
            beforeEach {
                output = LoginInteractorOutputMock()
                authenticationService = AuthenticationServiceProtocolMock()
                
                interactor = LoginInteractor(authenticationService: authenticationService)
                interactor.output = output
            }
            
            context("when authenticateEmail(email:, password:) is called and returns success") {
                beforeEach {
                    authenticationService.authenticateEmailEmailPasswordCompletionClosure = { _, _, closure in
                        let data: AuthToken = JSON.AuthenticationService.authenticateEmailSuccess.decoded()
                        closure(.success(data))
                        return nil
                    }

                    interactor.authenticateEmail(email: "email@example.com", password: "password")
                }

                it("triggers output call authentication succesfully ") {
                    expect(output.didAuthenticateEmailCalled) == true
                }
            }
            
            context("when authenticateEmail(email:, password:) is called and returns failure") {
                beforeEach {
                    authenticationService.authenticateEmailEmailPasswordCompletionClosure = { _, _, closure in
                        closure(.failure(APIError()))
                        return nil
                    }
                    
                    interactor.authenticateEmail(email: "email@example.com", password: "password")
                }

                it("triggers output call authentication failure ") {
                    expect(output.didFailToAuthenticateEmailCalled) == true
                }
            }
        }
    }
}
