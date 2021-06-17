//
//  UserSessionTests.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

class UserSessionTests: QuickSpec {
    
    override func spec() {
        
        var keychain: KeychainStorageProtocol!
        var userSession: UserSession!
        
        let sampleUserCredential: UserCredential = JSON.AuthenticationService.sampleUserCredential.decoded()
    
        describe("UserSession") {
            
            beforeEach {
                keychain = KeychainStorage.default
                userSession = UserSession(keychain: keychain)
                UserSessionProvider.shared.userSession = userSession
                userSession.userCredential = sampleUserCredential
            }
            
            afterEach {
                UserSessionProvider.shared.clearCredentials()
            }
            
            context("when setting user credentials") {
                it("should set the access and refresh token in UserSession") {
                    expect(userSession.userCredential?.accessToken) == "sampleAccessToken"
                    expect(userSession.userCredential?.refreshToken) == "sampleRefreshToken"
                }
                it("should be logged in") {
                    expect(UserSessionProvider.shared.isLoggedIn) == true
                }
            }
            
            context("when clearing credentials in UserSessionProvider") {
                it("should delete credentials in UserSession") {
                    UserSessionProvider.shared.clearCredentials()

                    expect(userSession.userCredential?.accessToken).to(beNil())
                    expect(UserSessionProvider.shared.isLoggedIn) == false
                }
            }
        }
    }
}
