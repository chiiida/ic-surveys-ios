//
//  UITestConfiguration.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/15/21.
//

import Foundation

enum UITestConfiguration {
    
    static var isMockAPIKeyExist: Bool {
        return ProcessInfo.processInfo.environment[TestConstants.mockAPIKey] != nil
    }
    
    static var isLoggedIn: Bool {
        return ProcessInfo.processInfo.environment[TestConstants.userLoggedInKey] != nil
    }
}
