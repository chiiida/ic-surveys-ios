// swiftlint:disable all
//
//  AuthenticationServiceSpec.swift
//  SurveyAppTests
//
//  Created by Chananchida F. on 6/17/21.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import SurveyApp

final class AuthenticationServiceSpec: QuickSpec {

    override func spec() {

        var authenticationService: AuthenticationService!
        var userSession: UserSessionProtocolMock!
        var api: BaseAPI!

        describe("an AuthenticationService") {

            afterEach {
                HTTPStubs.removeAllStubs()
            }

            beforeEach {
                userSession = UserSessionProtocolMock()
                api = BaseAPI(userSession: userSession)

                authenticationService = AuthenticationService(api: api, baseURL: Defines.baseURL)
            }

            // MARK: – authenticateEmail
            describe("its authenticateEmail is called") {

                let grantType = "password"
                let email = "email@example.com"
                let password = "12345678"
                let clientId = "id"
                let clientSecret = "secret"

                let successRequestBody = [
                    "grant_type": grantType,
                    "email": email,
                    "password": password,
                    "client_id": clientId,
                    "client_secret": clientSecret
                ]

                context("when the request returns success") {
                    it("receives response object correctly") {
                        let data = JSON.AuthenticationService.authenticateEmailSuccess

                        stub(condition: pathEndsWith("/api/v1/oauth/token") && hasJsonBody(successRequestBody)) { _ in
                            HTTPStubsResponse(data: data, statusCode: 200, headers: nil)
                        }

                        waitUntil(timeout: .seconds(10), action: { done in
                            _ = authenticationService.authenticateEmail(email: email, password: password) { result in
                                switch result {
                                case .success(let response):
                                    expect(response.session?.userCredential?.accessToken) == "lbxD2K2BjbYtNzz8xjvh2FvSKx838KBCf79q773kq2c"
                                    expect(response.session?.userCredential?.refreshToken) == "3zJz2oW0njxlj_I3ghyUBF7ZfdQKYXd2n0ODlMkAjHc"
                                case .failure:
                                    fail("result should be successful")
                                }
                                done()
                            }
                        })
                    }
                }

                context("when the request returns failure") {
                    it("receives error response object correctly") {
                        let data = JSON.AuthenticationService.authenticateEmailFailure

                        stub(condition: pathEndsWith("/api/v1/oauth/token") && hasJsonBody(successRequestBody)) { _ in
                            HTTPStubsResponse(data: data, statusCode: 403, headers: nil)
                        }

                        waitUntil(timeout: .seconds(10), action: { done in
                            _ = authenticationService.authenticateEmail(email: email, password: password) { result in
                                switch result {
                                case .success:
                                    fail("result should be failure")
                                case .failure(let error):
                                    expect(error.errors?[0].code) == "invalid_client"
                                    expect(error.errors?[0].detail) == "Client authentication failed due to unknown client, no client authentication included, or unsupported authentication method."
                                }
                                done()
                            }
                        })
                    }
                }
            }
        }
    }
}
