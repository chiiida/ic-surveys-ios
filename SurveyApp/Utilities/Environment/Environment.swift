//
//  Environment.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/11/21.
//

import Foundation

enum Environment {
    
    static func based<T>(staging: T, production: T) -> T {
        #if PRODUCTION
        return production
        #else
        return staging
        #endif
    }
}
