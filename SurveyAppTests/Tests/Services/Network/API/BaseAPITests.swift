//
//  BaseAPITests.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import SurveyApp

enum Defines {

    static let baseURL: String = "https://baseurl.com"
}

class BaseAPITests: QuickSpec {

    override func spec() {
        
        let keychain = KeychainStorage.default
        let userSession = UserSession(keychain: keychain)
        var api: BaseAPI!
        
        let sampleSuccessData = JSON.AuthenticationService.authenticateEmailSuccess
        let sampleFailureData = JSON.AuthenticationService.authenticateEmailFailure
        
        describe("BaseAPI") {
            
            context("when making a valid request") {
                it("returns a decoded object") {
                    api = BaseAPI(userSession: userSession)

                    stub(condition: isMethodPOST()) { _ in
                        HTTPStubsResponse(data: sampleSuccessData, statusCode: 200, headers: [:])
                    }

                    let configuration = RequestConfiguration(
                        method: .post,
                        url: "\(Defines.baseURL)/test"
                    )

                    waitUntil(timeout: .seconds(2)) { done in
                        _ = api.performRequest(with: configuration) { (result: Result<AuthToken, APIError>) in
                            switch result {
                            case .success(let token):
                                expect(token.session?.userCredential?.accessToken) == "sampleAccessToken"
                                expect(token.session?.userCredential?.refreshToken) == "sampleRefreshToken"
                            case .failure:
                                break
                            }
                            done()
                        }
                    }
                }
            }
            
            context("when making an invalid request") {
                it("returns an APIError object") {
                    api = BaseAPI(userSession: userSession)

                    stub(condition: isMethodPOST()) { _ in
                        HTTPStubsResponse(data: sampleFailureData, statusCode: 400, headers: [:])
                    }

                    let configuration = RequestConfiguration(
                        method: .post,
                        url: "\(Defines.baseURL)/test"
                    )

                    waitUntil(timeout: .seconds(2)) { done in
                        _ = api.performRequest(with: configuration) { (result: Result<AuthToken, APIError>) in
                            switch result {
                            case .success:
                                break
                            case .failure(let error):
                                expect(error).to(beAKindOf(APIError.self))
                                expect(error.errors?[0].detail) == "Sample API error detail"
                            }
                            done()
                        }
                    }
                }
            }
        }
        
        describe("BaseAPI") {
            context("when passing a URL path") {
                it("creates a valid url") {
                    api = BaseAPI(userSession: userSession)
                    
                    var url = api.url(forEndpoint: "test", baseURL: "http://sample.com")
                    expect(url) == "http://sample.com/test"
                    url = api.url(forEndpoint: "/test//endpoint", baseURL: "http://sample.com")
                    expect(url) == "http://sample.com/test//endpoint"
                    url = api.url(forEndpoint: "test?q=c17", baseURL: "http://sample.com")
                    expect(url) == "http://sample.com/test%3Fq=c17"
                    
                    api = BaseAPI(userSession: userSession)
                    
                    url = api.url(forEndpoint: "test", baseURL: "^")
                    expect(url) == "^"
                    url = api.url(forEndpoint: "/test//endpoint", baseURL: "^")
                    expect(url) == "^"
                    url = api.url(forEndpoint: "test?q=c17", baseURL: "^")
                    expect(url) == "^"
                }
            }
        }
    }
}
