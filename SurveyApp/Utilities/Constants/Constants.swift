//
//  Constants.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Foundation

enum Constants {
    
    enum Network {
        static let baseUrl = Environment.based(
            staging: "https://nimble-survey-web-staging.herokuapp.com",
            production: "https://survey-api.nimblehq.co"
        )
    }
}
