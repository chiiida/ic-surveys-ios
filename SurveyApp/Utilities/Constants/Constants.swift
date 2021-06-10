//
//  Constants.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/9/21.
//

import Foundation

enum Constants {
    
    enum Network {
        static let baseUrl = Environment.based(
            staging: "https://nimble-survey-web-staging.herokuapp.com",
            production: "https://survey-api.nimblehq.co"
        )
    }
    
    enum UserDefaultsKey {
        
        static let accessToken: String = "accessToken"
        static let refreshToken: String = "refreshToken"
    }
}
