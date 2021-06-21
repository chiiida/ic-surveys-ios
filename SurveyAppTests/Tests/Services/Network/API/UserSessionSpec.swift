//
//  UserSessionSpec.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble

@testable import SurveyApp

class UserSessionSpec: QuickSpec {
    
    override func spec() {
        
        var keychain: KeychainStorageProtocol!
        var userSession: UserSession!
        
        let sampleUserCredential: UserCredential = JSON.AuthenticationService.sampleUserCredential.decoded()
    
        describe("Test UserSession components") {
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
                it("should set the access token in UserSession") {
                    expect(userSession.userCredential?.accessToken) == sampleUserCredential.accessToken
                }
                
                it("should set the refresh token in UserSession") {
                    expect(userSession.userCredential?.refreshToken) == sampleUserCredential.refreshToken
                }
                
                it("should be logged in") {
                    expect(UserSessionProvider.shared.isLoggedIn) == true
                }
            }
            
            context("when clearing credentials in UserSessionProvider") {
                beforeEach {
                    UserSessionProvider.shared.clearCredentials()
                }
                
                it("should delete credentials in UserSession") {
                    expect(userSession.userCredential?.accessToken).to(beNil())
                }
                
                it("should not be logged in") {
                    expect(UserSessionProvider.shared.isLoggedIn) == false
                }
            }
        }
    }
}
