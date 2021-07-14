//
//  TestConstants.swift
//  SurveyApp
//
//  Created by Chananchida F. on 7/2/21.
//

import Foundation

enum TestConstants {
    
    static let mockAPIKey = "test.mock.api"
    static let userLoggedInKey = "user.logged.in"
    
    enum Toolbar {
        
        static let keyboardDonebutton = "Done"
    }
    
    enum Login {
        
        static let emailInputTextField = "login.email.input.textfield"
        static let passwordInputTextField = "login.password.input.textfield"
        static let loginButton = "login.login.button"
    }
    
    enum Home {
        
        static let homeView = "home.view"
        static let surveyDetailButton = "home.survey.detail.button"
        static let collectionView = "home.survey.collection.view"
        static let surveyCellTitle = "home.survey.cell.title"
    }
    
    enum SurveyDetail {
        
        static let surveyDetailView = "survey.detail.view"
        static let startSurveyButton = "survey.detail.start.survey.button"
    }
    
    enum SurveyQuestion {
        
        static let surveyQuestionView = "survey.question.view"
        static let submitSurveyButton = "survey.question.submit.survey.button"
        static let collectionView = "survey.question.collection.view"
        static let pickerView = "survey.question.pickerView"
        static let multilineTextView = "survey.question.textview"
        static let lottieCompleteSurveyView = "survey.question.lottie.complete.survey.view"
    }
}
