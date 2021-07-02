//
//  XCUIApplication.swift
//  SurveyAppUITests
//
//  Created by Chananchida F. on 7/1/21.
//

import XCTest
import Alamofire

extension XCUIApplication {
    
    var isUserLoggedIn: Bool {
        get { launchEnvironment[TestConstants.clearUserSession] == "yes" }
        set { launchEnvironment[TestConstants.clearUserSession] = newValue ? "yes" : nil }
    }
    
    var needClearUserSession: Bool {
        get { launchEnvironment[TestConstants.userLoggedInKey] == "yes" }
        set { launchEnvironment[TestConstants.userLoggedInKey] = newValue ? "yes" : nil }
    }
    
    func mockAPI(
        withMethod method: HTTPMethod,
        endPoint: String,
        willReturnStatus status: Bool,
        response: Data
    ) {
        let key = MockAPIKey(
            method: method,
            endPoint: endPoint,
            status: status
        ).rawValue

        launchEnvironment[TestConstants.mockAPIKey] = "yes"
        launchEnvironment[key] = String(data: response, encoding: .utf8)
    }
}
