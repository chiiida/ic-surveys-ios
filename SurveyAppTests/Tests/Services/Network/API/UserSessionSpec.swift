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
    
        describe("a UserSession") {
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
                it("sets the access token in UserSession") {
                    expect(userSession.userCredential?.accessToken) == sampleUserCredential.accessToken
                }
                
                it("sets the refresh token in UserSession") {
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
                
                it("deletes credentials in UserSession") {
                    expect(userSession.userCredential?.accessToken).to(beNil())
                }
                
                it("should not be logged in") {
                    expect(UserSessionProvider.shared.isLoggedIn) == false
                }
            }
        }
    }
}
