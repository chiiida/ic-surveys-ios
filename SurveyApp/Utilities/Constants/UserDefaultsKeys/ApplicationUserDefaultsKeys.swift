//
//  ApplicationUserDefaultsKeys.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/29/21.
//

import Foundation

extension UserDefaultsKeys {
    
    static var cachedSurveyList: UserDefaultsKey<[Survey]> {
        return UserDefaultsKey("cachedSurveyList")
    }
}
