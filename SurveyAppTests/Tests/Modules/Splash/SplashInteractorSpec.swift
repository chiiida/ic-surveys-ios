//
//  SplashInteractorSpec.swift
//  SurveyApp Tests
//
//  Created by Chananchida F. on 6/24/21.
//  
//

import Quick
import Nimble

@testable import SurveyApp

final class SplashInteractorSpec: QuickSpec {

    override func spec() {

        var interactor: SplashInteractor!
        var output: SplashInteractorOutputMock!
        var userSessionProvider: UserSessionProviderProtocolMock!

        describe("a SplashInteractor") {
            beforeEach {
                output = SplashInteractorOutputMock()
                userSessionProvider = UserSessionProviderProtocolMock()
                
                interactor = SplashInteractor(userSessionProvider: userSessionProvider)
                interactor.output = output
            }
            
            describe("its isLogginIn is called") {
                context("when the user is authenticated") {
                    beforeEach {
                        userSessionProvider.isLoggedIn = true
                    }

                    it("isLoggedIn returns true") {
                        expect(interactor.isLoggedIn) == true
                    }
                }
                
                context("when the user is unauthenticated") {
                    beforeEach {
                        userSessionProvider.isLoggedIn = false
                    }

                    it("isLoggedIn returns false") {
                        expect(interactor.isLoggedIn) == false
                    }
                }
            }
        }
    }
}
