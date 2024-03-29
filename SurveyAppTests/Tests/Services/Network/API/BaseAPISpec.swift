//
//  BaseAPISpec.swift
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

class BaseAPISpec: QuickSpec {

    override func spec() {
        
        var userSession: UserSessionProtocolMock!
        var api: BaseAPI!
        var configuration: RequestConfiguration!
        
        let sampleSuccessData = JSON.AuthenticationService.sampleUserCredential
        let sampleFailureData = JSON.APIError.sampleAPIError
        
        describe("a BaseAPI") {
            beforeEach {
                userSession = UserSessionProtocolMock()
                api = BaseAPI(userSession: userSession)
            }
            
            afterEach {
                HTTPStubs.removeAllStubs()
            }
            
            describe("when it performs a request") {
                context("the request returns success") {
                    beforeEach {
                        stub(condition: isMethodPOST()) { _ in
                            HTTPStubsResponse(data: sampleSuccessData, statusCode: 200, headers: [:])
                        }

                        configuration = RequestConfiguration(
                            method: .post,
                            url: "\(Defines.baseURL)/test"
                        )
                    }
                    
                    it("returns a decoded object") {
                        waitUntil(timeout: .seconds(2)) { done in
                            _ = api.performRequest(with: configuration) { (result: Result<UserCredential, APIError>) in
                                switch result {
                                case .success(let credentials):
                                    expect(credentials.accessToken) == "sampleAccessToken"
                                    expect(credentials.refreshToken) == "sampleRefreshToken"
                                case .failure:
                                    break
                                }
                                done()
                            }
                        }
                    }
                }
            
                context("the request returns failure") {
                    beforeEach {
                        stub(condition: isMethodPOST()) { _ in
                            HTTPStubsResponse(data: sampleFailureData, statusCode: 400, headers: [:])
                        }

                        configuration = RequestConfiguration(
                            method: .post,
                            url: "\(Defines.baseURL)/test"
                        )
                    }
                    
                    it("returns an APIError object") {
                        waitUntil(timeout: .seconds(2)) { done in
                            _ = api.performRequest(with: configuration) { (result: Result<UserCredential, APIError>) in
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
        }
        
        describe("a BaseAPI") {
            context("when passing a URL path") {
                it("creates a valid URL") {
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
