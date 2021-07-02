//
//  TestConstants.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/2/21.
//

import Foundation

enum TestConstants {
    
    static let mockAPIKey = "test.mock.api"
    static let clearUserSession = "clear.user.session"
    static let userLoggedInKey = "user.logged.in"
    
    enum Login {
        
        static let emailInputTextField = "login.email.input.textfield"
        static let passwordInputTextField = "login.password.input.textfield"
        static let loginButton = "login.login.button"
    }
    
    enum Home {
        
        static let homeView = "home.view"
        static let collectionView = "home.survey.collection.view"
        static let surveyCellTitle = "home.survey.cell.title"
    }
}
