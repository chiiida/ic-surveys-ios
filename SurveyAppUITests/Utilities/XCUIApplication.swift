//
//  XCUIApplication.swift
//  SurveyAppUITests
//
//  Created by Chananchida F. on 7/1/21.
//

import XCTest
import Alamofire

extension XCUIApplication {
    
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
