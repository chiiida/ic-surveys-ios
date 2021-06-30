//
//  UserStorage.swift
//  SurveyApp
//
//  Created by Chananchida F. on 6/30/21.
//

import Foundation

enum UserStorage {
    
    @UserDefault(key: .cachedSurveyList, defaultValue: [Survey]())
    static var cachedSurveyList: [Survey]
}
